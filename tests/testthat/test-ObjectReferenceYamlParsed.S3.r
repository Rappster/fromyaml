##------------------------------------------------------------------------------
context("ObjectReferenceYamlParsed.S3/basics")
##------------------------------------------------------------------------------

test_that("ObjectReferenceYamlParsed.S3/basics", {

  expect_is(ObjectReferenceYamlParsed.S3(), 
            "ObjectReferenceYamlParsed.S3")
  expect_is(ObjectReferenceYamlParsed.S3(TRUE), 
            "ObjectReferenceYamlParsed.S3")
  yaml <- getYaml(
    from = function() {
      "object-ref: {id: x_1, where:.GlobalEnv, as: ref_1}"
      ref_1
    },
    ctx = YamlContext.ObjectReference.S3()  
  )
  expect_is(ObjectReferenceYamlParsed.S3(
      original = yaml$original,
      parsed = list(id = "x_1", where = as.name("where"), as = as.name("ref_1")),
      index = yaml$index,
      src = yaml$src
    ), 
    "ObjectReferenceYamlParsed.S3"
  )
  
})

