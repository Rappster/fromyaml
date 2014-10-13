\dontrun{

## Example YAML //
yaml <- getYaml(
  from = function() {
    "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1
  },
  ctx = ReactiveReferenceYamlContext.S3()  
)  
yaml <- parseYaml(yaml = yaml)
  
## Informal use (intended mainly for rapid prototyping) //
## Takes *any* object and simply changes the class attributes
expr <- new.env()
expr$x_1 <- new.env()
expr$x_1$get_assign <- quote(ref_1 <- get("x_1", .GlobalEnv, inherits = FALSE))
ReactiveReferenceYamlProcessed.S3(
  list(
    yaml = yaml$yaml,
    yaml_parsed = yaml$yaml_parsed,
    index = yaml$index,
    src = yaml$src,
    expr = expr
  )
)  
ReactiveReferenceYamlProcessed.S3(TRUE)  

## Formal use (explicitly using 'fields') //
res <- ReactiveReferenceYamlProcessed.S3()
ls(res)
res <- ReactiveReferenceYamlProcessed.S3(
  yaml = yaml$yaml,
  yaml_parsed = yaml$yaml_parsed,
  index = yaml$index,
  src = yaml$src,
  expr = expr
)
res$yaml
res$yaml_parsed
res$index
res$src
res$expr$x_1$get_assign

## Recommended: include namespace //
## Regardless if you plan on using this class in an informal or formal way
fromyaml::ReactiveReferenceYamlProcessed.S3()

}
