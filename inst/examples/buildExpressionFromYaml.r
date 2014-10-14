\dontrun{

## Get //  
yaml <- getYaml(
  from = function() {
  "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
  },
  ctx = YamlContext.ObjectReference.S3()
)

## Parse //
yaml <- parseYaml(yaml = yaml)

## Build //
yaml <- buildExpressionFromYaml(yaml = yaml)

## Two ways of accessing expressions //
## 1) Via 'parsed':
ls(yaml$parsed$x_1$expr)
yaml$parsed$x_1$expr$exists
yaml$parsed$x_1$expr$validate
yaml$parsed$x_1$expr$get_assign

## 2) Via 'expr':
ls(yaml$expr$x_1)
yaml$expr$x_1$exists
yaml$expr$x_1$validate
yaml$expr$x_1$get_assign

## NOTE
## The environment in `expr${id}` corresponds to the environment 
## in `parsed${id}$expr. So expressions are not actually stored redundantly
## as environments implement a "pass-by-referenc" instead of the otherwise
## typical "pass-by-value" paradigm. 
## Environment `expr` simply exists as a shorthand for accessing expressions

## Example of expression execution //
## Validity checks:
suppressWarnings(rm(x_1))
eval(yaml$parsed$x_1$expr$exists)
eval(yaml$parsed$x_1$expr$validate)
x_1 <- 10
eval(yaml$parsed$x_1$expr$exists)
eval(yaml$parsed$x_1$expr$validate)

## The line that contained the YAML markup in 'from' above will be substituted
## by this expression 
eval(yaml$parsed$x_1$expr$get_assign)
ref_1

}
