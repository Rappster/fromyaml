\dontrun{

##------------------------------------------------------------------------------  
## As inline string //
##------------------------------------------------------------------------------

## With curly brackets //  
yaml <- getYaml(
  from = function() {
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1 * 2
  },
  ctx = YamlContext.ObjectReference.S3()
)
yaml
yaml$original
yaml$index
yaml$src

## W/o curly brackets //
yaml <- getYaml(
  from = function()
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}",
  ctx = YamlContext.ObjectReference.S3()
)
yaml$original
yaml$original
yaml$index
yaml$src

## Expression //
yaml <- getYaml(
  from = captureExpression({
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1 * 2
  }),
  ctx = YamlContext.ObjectReference.S3()
)
yaml
yaml$original
yaml$index
yaml$src

## Condition handling //
yaml <- getYaml(
  from = function (){
    "Invalid YAML markup"
    ref_1 * 2
  },
  ctx = YamlContext.ObjectReference.S3()
)
yaml
yaml$original
yaml$index
yaml$src

try(getYaml(
  from = function (){
    "Invalid YAML markup"
    ref_1 * 2
  },
  ctx = YamlContext.ObjectReference.S3(),
  strict = TRUE
))

##------------------------------------------------------------------------------  
## As comment //
##------------------------------------------------------------------------------

## With curly brackets //  
yaml <- getYaml(
  from = function() {
    ## object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}
    ref_1 * 2
  },
  ctx = YamlContext.ObjectReference.S3()
)
yaml$original
yaml$index
yaml$src

## W/o curly brackets //
yaml <- getYaml(
  from = function()
    ## object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}
    ref_1 * 2,
  ctx = YamlContext.ObjectReference.S3()
)
yaml$original
yaml$index
yaml$src

}
