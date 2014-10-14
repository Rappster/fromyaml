context("ObjectReferenceYamlProcessed.S3_A")
test_that("ObjectReferenceYamlProcessed.S3", {

  expect_is(ObjectReferenceYamlProcessed.S3(), 
            "ObjectReferenceYamlProcessed.S3")
  expect_is(ObjectReferenceYamlProcessed.S3(TRUE), 
            "ObjectReferenceYamlProcessed.S3")
  yaml <- getYaml(
    from = function() {
      "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
      ref_1
    },
    ctx = YamlContext.ObjectReference.S3()  
  )
  yaml <- parseYaml(yaml = yaml)
  
  expr <- new.env()
  expr$x_1 <- new.env()
  expr$x_1$get_assign <- quote(ref_1 <- get("x_1", .GlobalEnv, inherits = FALSE))
  expect_is(res <- ObjectReferenceYamlProcessed.S3(
      original = yaml$original,
      parsed = yaml$parsed,
      index = yaml$index,
      src = yaml$src,
      expr = expr
    ), 
    "ObjectReferenceYamlProcessed.S3"
  )
  expect_is(res$expr, "environment")
  expect_is(res$expr$x_1$get_assign, "<-")
  
})

