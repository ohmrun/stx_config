package stx.config.term;

abstract Directory(Attempt<HasDevice,Cluster<Couple<String,stx.fs.path.Directory>>,ConfigFailure>){
  public function new(){
    this = __.attempt((state:HasDevice) -> {
      final bake      = __.bake();
      __.log().debug(_ -> _.pure(bake.defines));
      final dir  = bake.defines.map_filter(
        x -> x.key == 'stx.config.Directory' ? Some(x.val) : None
      );
      return Produce.bind_fold(
        dir.map(
          name -> __.f(Path.parse).then(x -> x.produce(state).errate(e -> (e:FsFailure)))(name).map(
            __.couple.bind(name)
          )
        ),
        (next:Produce<Couple<String,Raw>,FsFailure>,memo:Cluster<Couple<String,stx.fs.path.Directory>>) -> {
          return next.attempt(
            (couple) -> {
              final that  = couple.snd().realize().adjust(
                address -> address.toDirectory().errate(e -> (e:FsFailure))
              );
              final thatI = that.map(
                directory -> memo.snoc(__.couple(couple.fst(),directory))
              ).produce(state);
              //$type(thatI);
              return thatI;
            }
            // couple.snd().toDirectory().map(
            //   dir -> cluster
            // );
          );
        },
        Cluster.unit()
      );
    }).errate(e -> (e:ConfigFailure));
  }
}