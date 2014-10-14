
##------------------------------------------------------------------------------
context("ObjectReferenceYaml.S3/basics")
##------------------------------------------------------------------------------

test_that("ObjectReferenceYaml.S3/basics", {

  expect_is(ObjectReferenceYaml.S3(), "ObjectReferenceYaml.S3")
  expect_is(ObjectReferenceYaml.S3(TRUE), "ObjectReferenceYaml.S3")
  
  expect_is(res <- ObjectReferenceYaml.S3(
      original = "abcd",
      index = 10,
      src = expression(1+2)
    ), 
    "ObjectReferenceYaml.S3"
  )
  expect_equal(res$original, "abcd")
  expect_equal(res$index, 10)
  expect_equal(res$src, expression(1 + 2))

})

