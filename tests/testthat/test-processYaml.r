context("processYaml-A")
test_that("processYaml", {
  
  yaml <- processYaml(
    from = function() {
      "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
      ref_1 * 2
    },
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_is(yaml$src, "function") 
  expect_equal(body(yaml$src)[[2]], yaml$expr$x_1$get_assign) 
      
})

test_that("multiple", {
  skip("manual only")
  yaml <- processYaml(
    from = function()
      ## object-ref: {id: x_1, where: where, as: ref_1}
      ## object-ref: {id: x_2, as: ref_2}
      ref_1 + ref_2,
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_is(yaml$src, "function") 
  expect_is(body(yaml$src)[[2]], "<-") 
  expect_is(body(yaml$src)[[3]], "<-") 
  expect_equal(body(yaml$src)[[4]], quote(ref_1 + ref_2)) 
      
})
