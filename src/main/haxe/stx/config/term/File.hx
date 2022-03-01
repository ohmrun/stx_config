package stx.config.term;

@:forward abstract File(Attempt<HasDevice,Ensemble<String>,ConfigFailure>) to Attempt<HasDevice,Ensemble<String>,ConfigFailure>{
  public function new(){
    this = __.attempt((state:HasDevice) -> {
      final bake      = __.bake();
      __.log().debug(_ -> _.pure(bake.defines));
      final file  = bake.defines.map_filter(
        x -> x.key == 'stx.config.File' ? Some(x.val) : None
      );
      return Produce.bind_fold(
        file.map(
          name -> __.f(Path.parse).then(x -> x.produce(state).errate(e -> (e:FsFailure)))(name).map(
            __.couple.bind(name)
          )
        ),
        (next:Produce<Couple<String,Raw>,FsFailure>,memo:Cluster<Couple<String,Archive>>) -> {
          return next.attempt(
            (couple:Couple<String,Raw>) -> {
              final kind = couple.snd().kind();
              return kind.absolute.if_else(
                () -> Produce.fromRes(couple.snd().toArchive()).errate(e -> (e:FsFailure)),
                () -> state.device.shell.cwd.pop().produce(state).errate(e -> (e:FsFailure)).adjust(
                  (dir:Directory) -> couple.snd().toAttachment().map(__.couple.bind(dir)).errate(e -> (e:FsFailure))
                ).adjust(
                  __.decouple(
                    (dir:Directory,attachment:Attachment) -> __.tracer()(dir.archive(attachment))
                  )
                )
              ).map(
                __.couple.bind(couple.fst())
              );
            }
          ).map(
            couple -> memo.snoc(couple)
          );
        },
        Cluster.unit()
      ).attempt(
        __.attempt(
          (cluster:Cluster<Couple<String,Archive>>) -> Produce.bind_fold(
            cluster,
            (next:Couple<String,Archive>,memo:Cluster<Couple<String,String>>) -> 
              state.device.volume
                .read(next.snd())
                .map(
                  (x:sys.io.FileInput) -> 
                    memo.snoc(__.couple(next.fst(),x.readAll().toString()))
                ),
            Cluster.unit()
          )
        )
      ).errate(e -> (e:ConfigFailure))
       .map(
         (cluster:Cluster<Couple<String,String>>) -> cluster.lfold(
          (next:Couple<String,String>,memo:Ensemble<String>) -> memo.set(
            next.fst(),
            next.snd()
          ),
          Ensemble.unit()
         )
       );
    });
  }
}