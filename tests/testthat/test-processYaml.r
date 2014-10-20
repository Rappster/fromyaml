##------------------------------------------------------------------------------
context("processYaml/inline")
##------------------------------------------------------------------------------

test_that("processYaml/from inline/single", {
  
  yaml <- processYaml(
    from = function() {
      "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
      ref_1 * 2
    },
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_is(yaml$src, "function") 
  expect_equal(body(yaml$src)[[2]], yaml$expr$x_1$get_assign) 
  expect_equal(body(yaml$src)[[3]], quote(ref_1 * 2)) 
      
})

test_that("processYaml/from inline/multiple", {
  
  yaml <- processYaml(
    from = function() {
      "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
      "object-ref: {id: x_2, where: .GlobalEnv, as: ref_1}"
      ref_1 + ref_2 * 2
    },
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_is(yaml$src, "function") 
  expect_equal(body(yaml$src)[[2]], yaml$expr$x_1$get_assign) 
  expect_equal(body(yaml$src)[[3]], yaml$expr$x_2$get_assign) 
  expect_equal(body(yaml$src)[[4]], quote(ref_1 + ref_2 * 2)) 
      
})

##------------------------------------------------------------------------------
context("processYaml/comments")
##------------------------------------------------------------------------------

test_that("processYaml/from comment/single", {
    
  ## With curly brackets //
  yaml <- processYaml(
    from = function() {
      ## object-ref: {id: x_1}
      x_1
    },
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_is(yaml$src, "function") 
  expect_is(body(yaml$src)[[2]], "<-") 
  expect_equal(body(yaml$src)[[3]], quote(x_1)) 
  
  ## With curly brackets at end of line //
  yaml <- processYaml(
    from = function() {
      ## object-ref: {id: x_1}
      x_1},
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_is(yaml$src, "function") 
  expect_is(body(yaml$src)[[2]], "<-") 
  expect_equal(body(yaml$src)[[3]], quote(x_1)) 

  ## W/o curly brackets //
  yaml <- processYaml(
    from = function()
      ## object-ref: {id: x_1}
      x_1,
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_is(yaml$src, "function") 
  expect_is(body(yaml$src)[[2]], "<-") 
  expect_equal(body(yaml$src)[[3]], quote(x_1)) 
      
})

test_that("processYaml/from comments/multiple", {
  
#   skip("manual only due to environment issues")
  
  ## With curly brackets //
  yaml <- processYaml(
    from = function() {
      ## object-ref: {id: x_1, where: where, as: ref_1}
      ## object-ref: {id: x_2, as: ref_2}
      ref_1 + ref_2
    },
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_is(yaml$src, "function") 
  expect_is(body(yaml$src)[[2]], "<-") 
  expect_is(body(yaml$src)[[3]], "<-") 
  expect_equal(body(yaml$src)[[4]], quote(ref_1 + ref_2)) 
  
  ## W/o curly brackets //
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

test_that("processYaml/from comments/empty lines)", {
  
  ## With curly brackets //
  yaml <- processYaml(
    from = function() {
      ## object-ref: {id: x_1, where: where}
      
      ## Do something // 
      x_1 * 2
    },
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_is(yaml$src, "function") 
  expect_is(body(yaml$src)[[2]], "<-") 
  expect_is(body(yaml$src)[[3]], "call") 
  expect_equal(body(yaml$src)[[3]], quote(x_1 * 2)) 
  
  ## W/o curly brackets //
  yaml <- processYaml(
    from = function()
      ## object-ref: {id: x_1, where: where, as: ref_1}
      ## object-ref: {id: x_2, as: ref_2}
      
      ## Do something //
      ref_1 + ref_2,
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_is(yaml$src, "function") 
  expect_is(body(yaml$src)[[2]], "<-") 
  expect_is(body(yaml$src)[[3]], "<-") 
  expect_equal(body(yaml$src)[[4]], quote(ref_1 + ref_2)) 
      
})

##------------------------------------------------------------------------------
context("processYaml/function with arguments")
##------------------------------------------------------------------------------

test_that("function with arguments", {
  
  ## With curly brackets //
  yaml <- processYaml(
    from = function(strict = FALSE) {
      ## object-ref: {id: x_1}
      x_1
    },
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_is(yaml$src, "function") 
  expect_is(body(yaml$src)[[2]], "<-") 
  expect_equal(body(yaml$src)[[3]], quote(x_1)) 
  expect_equal(names(formals(yaml$src)), "strict") 
  
  ## With curly brackets at end of line //
  yaml <- processYaml(
    from = function(strict = FALSE) {
      ## object-ref: {id: x_1}
      x_1},
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_is(yaml$src, "function") 
  expect_is(body(yaml$src)[[2]], "<-") 
  expect_equal(body(yaml$src)[[3]], quote(x_1)) 
  expect_equal(names(formals(yaml$src)), "strict") 
  
  ## W/o curly brackets //
  yaml <- processYaml(
    from = function(strict = FALSE)
      ## object-ref: {id: x_1}
      x_1,
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_is(yaml$src, "function") 
  expect_is(body(yaml$src)[[2]], "<-") 
  expect_equal(body(yaml$src)[[3]], quote(x_1)) 
  expect_equal(names(formals(yaml$src)), "strict") 
      
})

