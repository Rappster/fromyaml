##------------------------------------------------------------------------------
context("updateYamlSource/basics")
##------------------------------------------------------------------------------

test_that("updateYamlSource/basics", {
  
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
  expect_equal(body(res$src)[[2]], res$expr$object_1$get_assign) 
      
})

test_that("updateYamlSource/just ID", {
  
  yaml <- getYaml(
    from = function() "object-ref: {id: x_1}",
    ctx = YamlContext.ObjectReference.S3()
  )
  yaml <- parseYaml(yaml = yaml)
  yaml <- buildExpressionFromYaml(yaml = yaml)
  expect_is(res <- updateYamlSource(yaml = yaml), 
            "ObjectReferenceYamlProcessed.S3")
  expect_is(res$src, "function") 
  expect_equal(body(res$src)[[2]], res$expr$object_1$get_assign) 
      
})

test_that("updateYamlSource/no yaml, no brackets", {
  
  yaml <- getYaml(
    from = function(refs = list(x_1 = list(id = "x_1"))) x_1,
    ctx = YamlContext.ObjectReference.S3()
  )
  yaml <- parseYaml(yaml = yaml)
  yaml <- buildExpressionFromYaml(yaml = yaml)
  expect_is(res <- updateYamlSource(yaml = yaml), 
            "ObjectReferenceYamlProcessed.S3")
  expect_is(res$src, "function") 
      
})
