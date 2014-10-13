\dontrun{

from <- function() {
  "reactive-ref: {id: x_1, where:.GlobalEnv, as: ref_1}"
}
res <- getYaml(
  from = from,
  ctx = ReactiveReferenceYamlContext.S3()
)
res
res$yaml
res$index
res$src

}
