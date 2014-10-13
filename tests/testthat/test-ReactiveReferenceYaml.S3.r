context("ReactiveReferenceYaml.S3_A")
test_that("ReactiveReferenceYaml.S3", {

  expect_is(ReactiveReferenceYaml.S3(), "ReactiveReferenceYaml.S3")
  expect_is(ReactiveReferenceYaml.S3(TRUE), "ReactiveReferenceYaml.S3")
  
  expect_is(res <- ReactiveReferenceYaml.S3(
      original = "abcd",
      index = 10,
      src = expression(1+2)
    ), 
    "ReactiveReferenceYaml.S3"
  )
  expect_equal(res$original, "abcd")
  expect_equal(res$index, 10)
  expect_equal(res$src, expression(1 + 2))

})

