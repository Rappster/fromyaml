\dontrun{

## Informal use (intended mainly for rapid prototyping) //
## Takes *any* object and simply changes the class attributes
ReactiveReferenceYaml.S3(
  list(
    yaml = "reactive-ref: {id: x_1, where:.GlobalEnv, as: ref_1}",
    index = 1,
    src = function() {
      "reactive-ref: {id: x_1, where:.GlobalEnv, as: ref_1}"
      ref_1
    }
  )
)  
ReactiveReferenceYaml.S3(TRUE)  

## Formal use (explicitly using 'fields') //
res <- ReactiveReferenceYaml.S3()
ls(res)
res <- ReactiveReferenceYaml.S3(
  yaml = "reactive-ref: {id: x_1, where:.GlobalEnv, as: ref_1}",
  index = 1,
  src = function() {
    "reactive-ref: {id: x_1, where:.GlobalEnv, as: ref_1}"
    ref_1
  }
)
res$yaml
res$index
res$src

## Recommended: include namespace //
## Regardless if you plan on using this class in an informal or formal way
fromyaml::ReactiveReferenceYaml.S3(
  yaml = "reactive-ref: {id: x_1, where:.GlobalEnv, as: ref_1}",
  index = 1,
  src = function() {
    "reactive-ref: {id: x_1, where:.GlobalEnv, as: ref_1}"
    ref_1
  }
)

}
