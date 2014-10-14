##------------------------------------------------------------------------------
context("getYamlFromComments/basics")
##------------------------------------------------------------------------------

test_that("getYamlFromComments/basics", {
  
  from <- function() {
    ## object-ref: {id: x_1, where:.GlobalEnv, as: ref_1}
  }
  expect_is(res <- getYamlFromComments(
    from = from,
    ctx = YamlContext.ObjectReference.S3()
    ), 
    "ObjectReferenceYaml.S3"
  )
  expect_equal(res$original, "object-ref: {id: x_1, where:.GlobalEnv, as: ref_1}")
  expect_equal(res$index, 2)
  expect_equal(body(res$src)[[2]], "object-ref: {id: x_1, where:.GlobalEnv, as: ref_1}")
  
})

