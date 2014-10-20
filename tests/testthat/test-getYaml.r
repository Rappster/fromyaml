##------------------------------------------------------------------------------
context("getYaml/basics")
##------------------------------------------------------------------------------

test_that("getYaml/basics", {
  
  from <- function() {
    "object-ref: {id: x_1, where:.GlobalEnv, as: ref_1}"
  }
  expect_is(res <- getYaml(
    from = from,
    ctx = YamlContext.ObjectReference.S3()
    ), 
    "ObjectReferenceYaml.S3"
  )
  expect_equal(res$original, "object-ref: {id: x_1, where:.GlobalEnv, as: ref_1}")
  expect_equal(res$index, 2)
  expect_equal(res$src, from)
  
})

