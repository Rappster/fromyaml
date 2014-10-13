\dontrun{

## Get //  
yaml <- getYaml(
  from = function() {
  "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
  },
  ctx = YamlContext.ReactiveReference.S3()
)

## Parse //
yaml <- parseYaml(yaml = yaml)

## Build //
yaml <- buildExpressionFromYaml(yaml = yaml)
yaml$expr$x_1
yaml$expr$x_1$get_assign

## Example of expression execution //
## The line that contained the YAML markup in 'from' above will be substituted
## by this expression 
x_1 <- 10
eval(yaml$expr$x_1$get_assign)
ref_1

}
