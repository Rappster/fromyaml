\dontrun{

from <- function() {
  "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
}
yaml <- getYaml(
  from = from,
  ctx = YamlContext.ReactiveReference.S3()
)
yaml
yaml$yaml
yaml$index
yaml$src

}
