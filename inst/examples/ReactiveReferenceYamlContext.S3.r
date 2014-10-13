\dontrun{

## Informal use (intended mainly for rapid prototyping) //
## Takes *any* object and simply changes the class attributes
ReactiveReferenceYamlContext.S3(
  list(
    ctx = "abcd"
  )
)  
ReactiveReferenceYamlContext.S3(TRUE)  

## Formal use (explicitly using 'fields') //
res <- ReactiveReferenceYamlContext.S3()
ls(res)
res$ctx
res <- ReactiveReferenceYamlContext.S3(
  ctx = "ReactiveReferenceYamlContext.S3"
)
res$ctx

## Recommended: include namespace //
## Regardless if you plan on using this class in an informal or formal way
fromyaml::ReactiveReferenceYamlContext.S3()

}
