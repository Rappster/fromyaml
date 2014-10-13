\dontrun{

##------------------------------------------------------------------------------  
## As inline string //
##------------------------------------------------------------------------------

## With curly brackets //  
yaml <- getYaml(
  from = function() {
    "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1 * 2
  },
  ctx = YamlContext.ReactiveReference.S3()
)
yaml
yaml$original
yaml$index
yaml$src

## W/o curly brackets //
yaml <- getYaml(
  from = function()
    "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}",
  ctx = YamlContext.ReactiveReference.S3()
)
yaml$original
yaml$original
yaml$index
yaml$src

##------------------------------------------------------------------------------  
## As comment //
##------------------------------------------------------------------------------

## With curly brackets //  
yaml <- getYaml(
  from = function() {
    ## reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}
    ref_1 * 2
  },
  ctx = YamlContext.ReactiveReference.S3()
)
yaml$original
yaml$index
yaml$src

## W/o curly brackets //
yaml <- getYaml(
  from = function()
    ## reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}
    ref_1 * 2,
  ctx = YamlContext.ReactiveReference.S3()
)
yaml$original
yaml$index
yaml$src

}
