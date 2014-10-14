\dontrun{

## Informal use (intended mainly for rapid prototyping) //
## Takes *any* object and simply changes the class attributes
YamlContext.ObjectReference.S3(
  list(
    ctx = "abcd"
  )
)  
YamlContext.ObjectReference.S3(TRUE)  

## Formal use (explicitly using 'fields') //
res <- YamlContext.ObjectReference.S3()
ls(res)
res$ctx
res <- YamlContext.ObjectReference.S3(
  ctx = "YamlContext.ObjectReference.S3"
)
res$ctx

## Recommended: include namespace //
## Regardless if you plan on using this class in an informal or formal way
yamlr::YamlContext.ObjectReference.S3()

}
