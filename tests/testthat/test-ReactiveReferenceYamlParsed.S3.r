context("ReactiveReferenceYamlParsed.S3_A")
test_that("ReactiveReferenceYamlParsed.S3", {

  expect_is(ReactiveReferenceYamlParsed.S3(), 
            "ReactiveReferenceYamlParsed.S3")
  expect_is(ReactiveReferenceYamlParsed.S3(TRUE), 
            "ReactiveReferenceYamlParsed.S3")
  yaml <- getYaml(
    from = function() {
      "reactive-ref: {id: x_1, where:.GlobalEnv, as: ref_1}"
      ref_1
    },
    ctx = YamlContext.ReactiveReference.S3()  
  )
  expect_is(ReactiveReferenceYamlParsed.S3(
      yaml = yaml$yaml,
      yaml_parsed = list(id = "x_1", where = as.name("where"), as = as.name("ref_1")),
      index = yaml$index,
      src = yaml$src
    ), 
    "ReactiveReferenceYamlParsed.S3"
  )
  
})

