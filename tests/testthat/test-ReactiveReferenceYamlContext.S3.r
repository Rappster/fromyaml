context("ReactiveReferenceYamlContext.S3_A")
test_that("ReactiveReferenceYamlContext.S3", {

  expect_is(res <- ReactiveReferenceYamlContext.S3(), 
            "ReactiveReferenceYamlContext.S3")
  expect_equal(res$ctx, "ReactiveReferenceYamlContext.S3")
  expect_is(ReactiveReferenceYamlContext.S3(TRUE), 
            "ReactiveReferenceYamlContext.S3")
  
  expect_is(res <- ReactiveReferenceYamlContext.S3(
      ctx = "ReactiveReferenceYamlContext.S3"
    ), 
    "ReactiveReferenceYamlContext.S3"
  )
  expect_equal(res$ctx, "ReactiveReferenceYamlContext.S3")
  
})

