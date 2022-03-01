package stx.config.term;

@:forward abstract Resource(Provide<Cluster<String>>) to Provide<Cluster<String>>{
  static public function unit(){
    return new Resource();
  }
  public function new(){
    final bake      = __.bake();
    __.log().debug(_ -> _.pure(bake.defines));
    final resource  = bake.defines.map_filter(
      x -> x.key == 'stx.config.Resource' ? Some(x.val) : None
    ).map(
      x -> __.resource(x).string()
    );
    this = Provide.pure(resource);
  }
}