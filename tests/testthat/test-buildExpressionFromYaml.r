context("buildExpressionFromYaml-A")
test_that("buildExpressionFromYaml", {
  
  yaml <- getYaml(
    from = function() {
    "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    },
    ctx = ReactiveReferenceYamlContext.S3()
  )
  yaml <- parseYaml(yaml = yaml)
  expect_is(res <- buildExpressionFromYaml(yaml = yaml), 
            "ReactiveReferenceYamlProcessed.S3")
  expect_is(res$expr$x_1, "environment") 
  expect_is(res$expr$x_1$get_assign, "<-") 
      
})
