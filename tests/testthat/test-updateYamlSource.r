context("updateYamlSource-A")
test_that("updateYamlSource", {
  
  yaml <- getYaml(
    from = function() {
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1
    },
    ctx = YamlContext.ObjectReference.S3()
  )
  yaml <- parseYaml(yaml = yaml)
  yaml <- buildExpressionFromYaml(yaml = yaml)
  expect_is(res <- updateYamlSource(yaml = yaml), 
            "ObjectReferenceYamlProcessed.S3")
  expect_is(res$src, "function") 
  expect_equal(body(res$src)[[2]], res$expr$x_1$get_assign) 
      
})

test_that("just ID", {
  
  yaml <- getYaml(
    from = function() "object-ref: {id: x_1}",
    ctx = YamlContext.ObjectReference.S3()
  )
  yaml <- parseYaml(yaml = yaml)
  yaml <- buildExpressionFromYaml(yaml = yaml)
  expect_is(res <- updateYamlSource(yaml = yaml), 
            "ObjectReferenceYamlProcessed.S3")
  expect_is(res$src, "function") 
  expect_equal(body(res$src)[[2]], res$expr$x_1$get_assign) 
      
})
