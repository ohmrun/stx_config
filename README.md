# Config

```hxml
#Attempts to read the contents of files in `HasDevice#device.volume` at runtime
-D stx.config.File(${absolute_or_relative})//Attempt<Cluster<Couple<String,String>>,ConfigFailure>


#Produces the resource (`-resource path@name`)
-D stx.config.Resource(${name_of_resource})//Produce<Cluster<Couple<String,String>>,ConfigFailure>


#Attempts to read the Directory of `HasDevice#device.volume`
-D stx.config.Directory(${absolute_or_relative})//Attempt<HasDevice,Cluster<Couple<String,Directory>>,ConfigFailure>

```