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

## Inspeact //
yaml
yaml$yaml
yaml$yaml_parsed
yaml$index
yaml$src

}
