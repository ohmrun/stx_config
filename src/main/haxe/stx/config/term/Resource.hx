package stx.config.term;

@:forward abstract Resource(Provide<Cluster<Couple<String,String>>>) to Provide<Cluster<Couple<String,String>>>{
  static public function unit(){
    return new Resource();
  }
  public function new(){
    final bake      = __.bake();
    __.log().debug(_ -> _.pure(bake.defines));
    final resource  = bake.defines.map_filter(
      x -> x.key == 'stx.config.Resource' ? Some(__.couple(x.key,x.val)) : None
    ).map(
      x -> x.map(__.f(__.resource.bind(_,__.here())).then(x -> x.string()))
    );
    this = Provide.pure(resource);
  }
}