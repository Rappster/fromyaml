\dontrun{

## Example YAML //
yaml <- getYaml(
  from = function() {
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1
  },
  ctx = YamlContext.ObjectReference.S3()  
)  
yaml <- parseYaml(yaml = yaml)
  
## Informal use (intended mainly for rapid prototyping) //
## Takes *any* object and simply changes the class attributes
expr <- new.env()
expr$x_1 <- new.env()
expr$x_1$get_assign <- quote(ref_1 <- get("x_1", .GlobalEnv, inherits = FALSE))
ObjectReferenceYamlProcessed.S3(
  list(
    original = yaml$original,
    parsed = yaml$parsed,
    index = yaml$index,
    src = yaml$src,
    expr = expr
  )
)  
ObjectReferenceYamlProcessed.S3(TRUE)  

## Formal use (explicitly using 'fields') //
res <- ObjectReferenceYamlProcessed.S3()
ls(res)
res <- ObjectReferenceYamlProcessed.S3(
  original = yaml$original,
  parsed = yaml$parsed,
  index = yaml$index,
  src = yaml$src,
  expr = expr
)
res$original
res$parsed
res$index
res$src
res$expr$x_1$get_assign

## Recommended: include namespace //
## Regardless if you plan on using this class in an informal or formal way
yamlr::ObjectReferenceYamlProcessed.S3()

}
