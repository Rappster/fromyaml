##------------------------------------------------------------------------------
context("buildExpressionFromYaml/basics")
##------------------------------------------------------------------------------

test_that("buildExpressionFromYaml/basics", {
  
  yaml <- getYaml(
    from = function() {
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    },
    ctx = YamlContext.ObjectReference.S3()
  )
  yaml <- parseYaml(yaml = yaml)
  expect_is(res <- buildExpressionFromYaml(yaml = yaml), 
            "ObjectReferenceYamlProcessed.S3")
  expect_is(res$expr$x_1, "environment") 
  expect_is(res$expr$x_1$get_assign, "<-") 
  
  expect_true(exists("get_assign", res$expr$x_1, inherits = FALSE))
  expect_true(exists("exists", res$expr$x_1, inherits = FALSE))
  expect_true(exists("validate", res$expr$x_1, inherits = FALSE))
  expect_true(exists("exists", res$expr$x_1$validate, inherits = FALSE))
  
  expect_true(exists("get_assign", res$parsed$x_1$expr, inherits = FALSE))
  expect_true(exists("exists", res$parsed$x_1$expr, inherits = FALSE))
  expect_true(exists("validate", res$parsed$x_1$expr, inherits = FALSE))
  expect_true(exists("exists", res$parsed$x_1$expr$validate, inherits = FALSE))
      
  expect_true(identical(res$expr$x_1, res$parsed$x_1$expr))
  
})

