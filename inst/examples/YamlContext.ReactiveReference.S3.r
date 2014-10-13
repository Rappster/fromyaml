\dontrun{

## Informal use (intended mainly for rapid prototyping) //
## Takes *any* object and simply changes the class attributes
YamlContext.ReactiveReference.S3(
  list(
    ctx = "abcd"
  )
)  
YamlContext.ReactiveReference.S3(TRUE)  

## Formal use (explicitly using 'fields') //
res <- YamlContext.ReactiveReference.S3()
ls(res)
res$ctx
res <- YamlContext.ReactiveReference.S3(
  ctx = "YamlContext.ReactiveReference.S3"
)
res$ctx

## Recommended: include namespace //
## Regardless if you plan on using this class in an informal or formal way
fromyaml::YamlContext.ReactiveReference.S3()

}
