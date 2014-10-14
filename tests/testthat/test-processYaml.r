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

test_that("YAML in comments (single)", {
  
  skip("manual only")
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

test_that("YAML in comments (multiple)", {
  
  skip("manual only")
  
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

test_that("function with arguments", {
  
  skip("manual only")
  
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