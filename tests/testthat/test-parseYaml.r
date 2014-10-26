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
    list(object_1 = list(
      id = "x_1", 
      where = quote(.GlobalEnv),
      as = quote(ref_1),
      uid = "object_1",
      index = 2,
      expr = res$parsed$object_1$expr
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
    list(object_1 = list(
      id = "x_1", 
      where = quote(.GlobalEnv),
      as = quote(ref_1),
      uid = "object_1",
      index = 2,
      expr = res$parsed$object_1$expr
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
    list(object_1 = list(
      id = "x_1", 
      where = quote(.GlobalEnv),
      as = quote(ref_1),
      uid = "object_1",
      index = 2,
      expr = res$parsed$object_1$expr
    ))
  )
  
})

##------------------------------------------------------------------------------
context("parseYaml/bugfix #6")
##------------------------------------------------------------------------------

test_that("parseYaml/bugfix #6", {
  
  x_1 <- new.env()
  x_2 <- new.env()
  from <- function() { 
    "object-ref: {id: field_1, where: x_1, as: x_1_f_1}"
    "object-ref: {id: field_2, where: x_1, as: x_1_f_2}"
    "object-ref: {id: field_1, where: x_2, as: x_2_f_1}"
  }
  
  yaml <- getYaml(
    from = from,
    ctx = YamlContext.ObjectReference.S3()
  )
  yaml <- parseYaml(yaml = yaml)
  expect_equal(names(yaml$parsed), paste0("object_", 1:length(yaml$parsed))) 
  sapply(seq(along = yaml$parsed), function(ii) {
    res <- expect_equal(yaml$parsed[[ii]]$uid, paste0("object_", ii))
    res$passed
  })
      
})
