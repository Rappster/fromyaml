\dontrun{

##------------------------------------------------------------------------------
## From function //
##------------------------------------------------------------------------------

## Get //
yaml <- getYaml(
  from = function() {
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
  },
  ctx = YamlContext.ObjectReference.S3()
)

## Parse //
yaml <- parseYaml(yaml = yaml)

## Inspect //
yaml
yaml$original
yaml$parsed
yaml$index
yaml$src

## Condition handling //
yaml <- getYaml(
  from = function() {
    "Invalid YAML markup"
  },
  ctx = YamlContext.ObjectReference.S3()
)
yaml$original

try(getYaml(
  from = function() {
    "Invalid YAML markup"
  },
  ctx = YamlContext.ObjectReference.S3(),
  strict = TRUE
))

##------------------------------------------------------------------------------
## From expression //
##------------------------------------------------------------------------------

yaml <- getYaml(
  from = captureExpression({
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1
  }),
  ctx = YamlContext.ObjectReference.S3()
)
yaml <- parseYaml(yaml = yaml)

## Inspect //
yaml
yaml$original
yaml$parsed
yaml$index
yaml$src

}
