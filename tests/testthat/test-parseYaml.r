context("parseYaml-A")
test_that("parseYaml", {
  
  yaml <- getYaml(
    from = function() {
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    },
    ctx = YamlContext.ObjectReference.S3()
  )
  ls(yaml)
  expect_is(res <- parseYaml(yaml = yaml), "ObjectReferenceYamlParsed.S3")
  expect_equal(res$parsed, 
    list(x_1 = list(
      id = "x_1", 
      where = quote(.GlobalEnv),
      as = quote(ref_1),
      index = 2,
      expr = res$parsed$x_1$expr
    ))
  )
  
})

test_that("messed up YAML", {
  
  ## Missing spaces //
  ## --> not allowed
  yaml <- getYaml(
    from = function() {
    "object-ref:{id: x_1, where: .GlobalEnv, as: ref_1}"
    },
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_error(res <- parseYaml(yaml = yaml))
  
  ## Additional spaces //
  ## --> okay
  yaml <- getYaml(
    from = function() {
    "object-ref: { id: x_1,   where:   .GlobalEnv, as   : ref_1}"
    },
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_is(res <- parseYaml(yaml = yaml), "ObjectReferenceYamlParsed.S3")
#   res$parsed

})