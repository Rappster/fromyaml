##------------------------------------------------------------------------------
context("parseYaml/basics")
##------------------------------------------------------------------------------

test_that("parseYaml/inline", {
  
  yaml <- getYaml(
    from = function() {
      "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    },
    ctx = YamlContext.ObjectReference.S3()
  )
  
  expect_is(res <- parseYaml(yaml = yaml), "ObjectReferenceYamlParsed.S3")
  expect_equal(res$parsed, 
    list(x_1 = list(
      id = "x_1", 
      where = quote(.GlobalEnv),
      as = quote(ref_1),
      index = 2,
      expr = res$parsed$x_1$expr
    ))
  )
  
})

test_that("parseYaml/comments", {
  
  yaml <- getYaml(
    from = function() {
      ## object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}
    },
    ctx = YamlContext.ObjectReference.S3()
  )

  expect_is(res <- parseYaml(yaml = yaml), "ObjectReferenceYamlParsed.S3")
  expect_equal(res$parsed, 
    list(x_1 = list(
      id = "x_1", 
      where = quote(.GlobalEnv),
      as = quote(ref_1),
      index = 2,
      expr = res$parsed$x_1$expr
    ))
  )
  
})

test_that("parseYaml/messed up", {
  
  ## Missing spaces //
  ## --> not allowed
  yaml <- getYaml(
    from = function() {
    "object-ref:{id: x_1, where: .GlobalEnv, as: ref_1}"
    },
    ctx = YamlContext.ObjectReference.S3()
  )
#   expect_error(res <- parseYaml(yaml = yaml))
  expect_is(res <- parseYaml(yaml = yaml), "ObjectReferenceYamlParsed.S3")
  
  ## Additional spaces //
  ## --> okay
  yaml <- getYaml(
    from = function() {
    "object-ref: { id: x_1,   where:   .GlobalEnv, as   : ref_1}"
    },
    ctx = YamlContext.ObjectReference.S3()
  )
  expect_is(res <- parseYaml(yaml = yaml), "ObjectReferenceYamlParsed.S3")
#   res$parsed

})

test_that("parseYaml/strict", {
  
  yaml <- getYaml(
    from = function() {
      "Invalid YAML markup"
    },
    ctx = YamlContext.ObjectReference.S3()
  )

  expect_is(res <- parseYaml(yaml = yaml), "ObjectReferenceYamlParsed.S3")
  expect_error(parseYaml(yaml = yaml, strict = TRUE))
  
})

##------------------------------------------------------------------------------
context("parseYaml/from expression")
##------------------------------------------------------------------------------

test_that("parseYaml/from expression/inline", {
  
  yaml <- getYaml(
    from = captureExpression({
      "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
      ref_1
    }),
    ctx = YamlContext.ObjectReference.S3()
  )
  
  expect_is(res <- parseYaml(yaml = yaml), "ObjectReferenceYamlParsed.S3")
  expect_equal(res$parsed, 
    list(x_1 = list(
      id = "x_1", 
      where = quote(.GlobalEnv),
      as = quote(ref_1),
      index = 2,
      expr = res$parsed$x_1$expr
    ))
  )
  
})
