\dontrun{

## Get //  
yaml <- getYaml(
  from = function() {
  "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
  ref_1 * 2
  },
  ctx = ReactiveReferenceYamlContext.S3()
)

## Parse //
yaml <- parseYaml(yaml = yaml)

## Build //
yaml <- buildExpressionFromYaml(yaml = yaml)

## Update //
yaml <- updateYamlSource(yaml = yaml)

## Inspect //
yaml$src
## --> note that the original YAML markup has been substituted by a 
## suitable expression for this specific context (`yaml$src$x_1$get_assign`).
## The processing is now complete and the source object can be used as is
## as it is now "self contained" in the sense that it contains all information
## that are needed in order for it to do its job.

## Actual use of the source object //
x_1 <- 10
eval(yaml$src())

## Clean up //
rm(x_1)
rm(yaml)
rm(yaml)

}
