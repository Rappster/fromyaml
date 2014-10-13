context("ReactiveReferenceYamlProcessed.S3_A")
test_that("ReactiveReferenceYamlProcessed.S3", {

  expect_is(ReactiveReferenceYamlProcessed.S3(), 
            "ReactiveReferenceYamlProcessed.S3")
  expect_is(ReactiveReferenceYamlProcessed.S3(TRUE), 
            "ReactiveReferenceYamlProcessed.S3")
  yaml <- getYaml(
    from = function() {
      "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
      ref_1
    },
    ctx = YamlContext.ReactiveReference.S3()  
  )
  yaml <- parseYaml(yaml = yaml)
  
  expr <- new.env()
  expr$x_1 <- new.env()
  expr$x_1$get_assign <- quote(ref_1 <- get("x_1", .GlobalEnv, inherits = FALSE))
  expect_is(res <- ReactiveReferenceYamlProcessed.S3(
      yaml = yaml$yaml,
      yaml_parsed = yaml$yaml_parsed,
      index = yaml$index,
      src = yaml$src,
      expr = expr
    ), 
    "ReactiveReferenceYamlProcessed.S3"
  )
  expect_is(res$expr, "environment")
  expect_is(res$expr$x_1$get_assign, "<-")
  
})

