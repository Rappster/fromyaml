##------------------------------------------------------------------------------
context("captureExpression/basics")
##------------------------------------------------------------------------------

test_that("captureExpression/basics", {

#   skip("manual only due to environment issues")
  res <- captureExpression({
    "object-ref: {id: x_2}"
    x_2 * 2
  })

  expect_equal(res, quote({
    "object-ref: {id: x_2}"
    x_2 * 2
  }))
  expect_is(res, "{")
  
  res <- captureExpression(x_2 * 2)
  expect_equal(res, quote({x_2 * 2}))
  expect_is(res, "{")
  
  res <- captureExpression(x_2 * 2, brackets = FALSE)
  expect_equal(res, quote(x_2 * 2))
  expect_is(res, "call")
  
})

##------------------------------------------------------------------------------
context("captureExpression/character")
##------------------------------------------------------------------------------

test_that("captureExpression/character", {
  
  skip("manual only due to environment issues")
  res <- captureExpression(expr = "object-ref: {id: x_1}")
  expect_is(res, "{")
  
  res <- captureExpression(expr = "object-ref: {id: x_1}", brackets = FALSE)
  expect_is(res, "character")
  
})

