context("YamlContext.ReactiveReference.S3_A")
test_that("YamlContext.ReactiveReference.S3", {

  expect_is(res <- YamlContext.ReactiveReference.S3(), 
            "YamlContext.ReactiveReference.S3")
  expect_equal(res$ctx, "YamlContext.ReactiveReference.S3")
  expect_is(YamlContext.ReactiveReference.S3(TRUE), 
            "YamlContext.ReactiveReference.S3")
  
  expect_is(res <- YamlContext.ReactiveReference.S3(
      ctx = "YamlContext.ReactiveReference.S3"
    ), 
    "YamlContext.ReactiveReference.S3"
  )
  expect_equal(res$ctx, "YamlContext.ReactiveReference.S3")
  
})

