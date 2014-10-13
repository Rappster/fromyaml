context("processYaml-A")
test_that("processYaml", {
  
  yaml <- processYaml(
    from = function() {
      "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
      ref_1 * 2
    },
    ctx = YamlContext.ReactiveReference.S3()
  )
  expect_is(yaml$src, "function") 
  expect_equal(body(yaml$src)[[2]], yaml$expr$x_1$get_assign) 
      
})
