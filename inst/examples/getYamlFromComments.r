\dontrun{

yaml <- getYamlFromComments(
  from = function() {
    ## object-ref: {id: x_1, where:.GlobalEnv, as: ref_1}
  },
  ctx = YamlContext.ObjectReference.S3()
)
yaml$original
yaml$src

}
