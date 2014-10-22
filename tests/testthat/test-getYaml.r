##------------------------------------------------------------------------------
context("getYaml/from function")
##------------------------------------------------------------------------------

test_that("getYaml/from function", {
  
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

test_that("getYaml/from function/strict", {
  
  from <- function() {
    "no valid YAML markup"
  }
  expect_is(res <- getYaml(
    from = from,
    ctx = YamlContext.ObjectReference.S3()
    ), 
    "ObjectReferenceYaml.S3"
  )
  expect_equal(res$original, character())
  expect_equal(res$index, numeric())
  expect_equal(res$src, from)
  
  expect_error(getYaml(
    from = from,
    ctx = YamlContext.ObjectReference.S3(),
    strict = TRUE
    )
  )
  
})


##------------------------------------------------------------------------------
context("getYaml/from expression")
##------------------------------------------------------------------------------

test_that("getYaml/from expression", {
  
  x_1 <- 10
  from <- quote({
    "object-ref: {id: x_1}"
    x_1 * 2
  })
    
  expect_is(res <- getYaml(
    from = {
      "object-ref: {id: x_1}"
      x_1 * 2
    },
    ctx = YamlContext.ObjectReference.S3()
    ), 
    "ObjectReferenceYaml.S3"
  )
  expect_equal(res$original, "object-ref: {id: x_1}")
  expect_equivalent(res$index, 2)
  expect_equal(res$src, from)
  
  x_1 <- 10
  from <- quote("object-ref: {id: x_1}")
  
  expect_is(res <- getYaml(
    from = "object-ref: {id: x_1}",
    ctx = YamlContext.ObjectReference.S3()
    ), 
    "ObjectReferenceYaml.S3"
  )
  expect_equal(res$original, "object-ref: {id: x_1}")
  expect_equivalent(res$index, 2)
  expect_equal(res$src, substitute({FROM}, list(FROM = from)))
  
})

test_that("getYaml/from expression/comments", {
  
  skip("not finished yet; methods are still missing")
  x_1 <- 10
  from <- quote({
    ## object-ref: {id: x_1}
    x_1 * 2
  })
    
  expect_is(res <- getYaml(
    from = captureExpression({
      ## object-ref: {id: x_1}
      x_1 * 2
    }),
    ctx = YamlContext.ObjectReference.S3()
    ), 
    "ObjectReferenceYaml.S3"
  )
  expect_equal(res$original, "object-ref: {id: x_1}")
  expect_equivalent(res$index, 2)
  expect_equal(res$src, from)
  
})
