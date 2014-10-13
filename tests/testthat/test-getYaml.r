context("getYaml-A")
test_that("getYaml", {
  
  from <- function() {
    "reactive-ref: {id: x_1, where:.GlobalEnv, as: ref_1}"
  }
  expect_is(res <- getYaml(
    from = from,
    ctx = YamlContext.ReactiveReference.S3()
    ), 
    "ReactiveReferenceYaml.S3"
  )
  expect_equal(res$original, "reactive-ref: {id: x_1, where:.GlobalEnv, as: ref_1}")
  expect_equal(res$index, 2)
  expect_equal(res$src, from)
  
})
