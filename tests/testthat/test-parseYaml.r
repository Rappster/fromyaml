context("parseYaml-A")
test_that("parseYaml", {
  
  yaml <- getYaml(
    from = function() {
    "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    },
    ctx = YamlContext.ReactiveReference.S3()
  )
  yaml
  expect_is(res <- parseYaml(yaml = yaml), "ReactiveReferenceYamlParsed.S3")
  expect_equal(res$yaml_parsed, 
    list(x_1 = list(
      id = "x_1", 
      where = quote(.GlobalEnv),
      as = quote(ref_1),
      index = 2
    ))
  )
  
})
