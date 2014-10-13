\dontrun{

## Get //  
yaml <- getYaml(
  from = function() {
  "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
  },
  ctx = ReactiveReferenceYamlContext.S3()
)

## Parse //
yaml <- parseYaml(yaml = yaml)

## Build //
res <- buildExpressionFromYaml(yaml = yaml)
res$expr$x_1
res$expr$x_1$get_assign

## Example of expression execution //
## The line that contained the YAML markup in 'from' above will be substituted
## by this expression 
x_1 <- 10
eval(res$expr$x_1$get_assign)
ref_1

}
