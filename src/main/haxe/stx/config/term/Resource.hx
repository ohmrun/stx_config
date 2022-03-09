package stx.config.term;

typedef ResourceDef = Produce<Ensemble<String>,ConfigFailure>;
@:forward abstract Resource(ResourceDef) to ResourceDef{
  static public function unit(){
    return new Resource();
  }
  public function new(){
    final bake      = __.bake();
    __.log().debug(_ -> _.pure(bake.defines));
    final resource  = Ensemble.fromClusterCouple(bake.defines.map_filter(
      x -> x.key == 'stx.config.Resource' ? Some(__.couple(x.key,x.val)) : None
    ).map(
      x -> x.map(__.f(__.resource.bind(_,__.here())).then(x -> x.string()))//TODO handle error
    ));
    this = Produce.pure(resource);
  }
}