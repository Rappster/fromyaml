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

## Inspeact //
yaml
yaml$original
yaml$parsed
yaml$index
yaml$src

}
