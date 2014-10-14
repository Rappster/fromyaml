\dontrun{

## Informal use (intended mainly for rapid prototyping) //
## Takes *any* object and simply changes the class attributes
ObjectReferenceYaml.S3(
  list(
    original = "object-ref: {id: x_1, where:.GlobalEnv, as: ref_1}",
    index = 1,
    src = function() {
      "object-ref: {id: x_1, where:.GlobalEnv, as: ref_1}"
      ref_1
    }
  )
)  
ObjectReferenceYaml.S3(TRUE)  

## Formal use (explicitly using 'fields') //
res <- ObjectReferenceYaml.S3()
ls(res)
res <- ObjectReferenceYaml.S3(
  original = "object-ref: {id: x_1, where:.GlobalEnv, as: ref_1}",
  index = 1,
  src = function() {
    "object-ref: {id: x_1, where:.GlobalEnv, as: ref_1}"
    ref_1
  }
)
res$original
res$index
res$src

## Recommended: include namespace //
## Regardless if you plan on using this class in an informal or formal way
yamlr::ObjectReferenceYaml.S3(
  original = "object-ref: {id: x_1, where:.GlobalEnv, as: ref_1}",
  index = 1,
  src = function() {
    "object-ref: {id: x_1, where:.GlobalEnv, as: ref_1}"
    ref_1
  }
)

}
