# Config

### File Config  


#### hxml
```hxml
#Attempts to read the contents of files in `HasDevice#device.volume` at runtime
-D stx.config.File=${absolute_or_relative}
```
#### haxe
```haxe
  using stx.Nano;//import Wildcard
  using stx.Config;//Wildcard extension `config`
  function file(){
    var cfg = __.config().File();
    $type(cfg);//Attempt<HasDevice,Ensemble<String>,ConfigFailure>
  }
```

### Resource Config
#### hxml
```hxml
#Produces the resource (`-resource path@name`)
-D stx.config.Resource=${name_of_resource}
```
#### haxe
```haxe
  using stx.Nano;//import Wildcard
  using stx.Config;//Wildcard extension `config`
  function file(){
    var cfg = __.config().Resource();
    $type(cfg);//Produce<Ensemble<String>,ConfigFailure>
  }
```

### Directory Config

#### hxml
```hxml
#Attempts to read the Directory of `HasDevice#device.volume`
-D stx.config.Directory=${absolute_or_relative}
```
#### haxe
```haxe
  using stx.Nano;//import Wildcard
  using stx.Config;//Wildcard extension `config`
  function file(){
    var cfg = __.config().Directory();
    $type(cfg);//Attempt<HasDevice,Ensemble<Directory>,ConfigFailure>
  }
```