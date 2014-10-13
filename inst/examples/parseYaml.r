\dontrun{

## Get //
yaml <- getYaml(
  from = function() {
  "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
  },
  ctx = ReactiveReferenceYamlContext.S3()
)

## Parse //
res <- parseYaml(yaml = yaml)

## Inspeact //
res
res$yaml
res$yaml_parsed
res$index
res$src

}
