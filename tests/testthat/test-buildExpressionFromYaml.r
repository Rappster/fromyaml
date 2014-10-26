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
  expect_is(res$expr$object_1, "environment") 
  expect_is(res$expr$object_1$get_assign, "<-") 
  
  expect_true(exists("get_assign", res$expr$object_1, inherits = FALSE))
  expect_true(exists("exists", res$expr$object_1, inherits = FALSE))
  expect_true(exists("validate", res$expr$object_1, inherits = FALSE))
  expect_true(exists("exists", res$expr$object_1$validate, inherits = FALSE))
  
  expect_true(exists("get_assign", res$parsed$object_1$expr, inherits = FALSE))
  expect_true(exists("exists", res$parsed$object_1$expr, inherits = FALSE))
  expect_true(exists("validate", res$parsed$object_1$expr, inherits = FALSE))
  expect_true(exists("exists", res$parsed$object_1$expr$validate, inherits = FALSE))
      
  expect_true(identical(res$expr$object_1, res$parsed$object_1$expr))
  
})

