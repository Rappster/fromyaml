\dontrun{

## Example YAML //
yaml <- getYaml(
  from = function() {
    "object-ref: {id: x_1, where:.GlobalEnv, as: ref_1}"
    ref_1
  },
  ctx = YamlContext.ObjectReference.S3()  
)  
  
## Informal use (intended mainly for rapid prototyping) //
## Takes *any* object and simply changes the class attributes
ObjectReferenceYamlParsed.S3(
  list(
    original = yaml$original,
    parsed = list(
      id = "x_1", 
      where = as.name("where"), 
      as = as.name("ref_1"),
      index = 2
    ),
    index = yaml$index,
    src = yaml$src
  )
)  
ObjectReferenceYamlParsed.S3(TRUE)  

## Formal use (explicitly using 'fields') //
res <- ObjectReferenceYamlParsed.S3()
ls(res)
res <- ObjectReferenceYamlParsed.S3(
  original = yaml$original,
  parsed = list(
    id = "x_1", 
    where = as.name("where"), 
    as = as.name("ref_1"),
    index = 2
  ),
  index = yaml$index,
  src = yaml$src
)
res$original
res$parsed
res$index
res$src

## Recommended: include namespace //
## Regardless if you plan on using this class in an informal or formal way
yamlr::ObjectReferenceYamlParsed.S3()

}
