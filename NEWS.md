# CHANGES IN yamlr VERSION 0.4.9

## NEW FEATURES

## BUG FIXES

- fixed: #5

## MAJOR CHANGES

## MINOR CHANGES

## MISC

-----

# CHANGES IN yamlr VERSION 0.4.8

## NEW FEATURES

- added: argument `strict` in `getYaml()`, `parseYaml()` and `processYaml()`.
  If `TRUE`, then an error is thrown in case no YAML markup could be identified

## BUG FIXES

## MAJOR CHANGES

## MINOR CHANGES

## MISC

-----

# CHANGES IN yamlr VERSION 0.4.7

## NEW FEATURES

- get and parse YAML code based on an `expression` or `captureExpression(expr)`

## BUG FIXES

## MAJOR CHANGES

## MINOR CHANGES

- modified: unit tests and examples

## MISC

-----

# CHANGES IN yamlr VERSION 0.4.6

## NEW FEATURES

## BUG FIXES

## MAJOR CHANGES

## MINOR CHANGES

- modified: pattern to identify YAML markup in `YamlContext.ObjectReference.S3`
- modified: `README.md`

## MISC

-----

# CHANGES IN yamlr VERSION 0.4.5

## NEW FEATURES

## BUG FIXES

- fixed: #3
  Empty lines when providing functions with YAML as comments no longer leads to an error in `getYaml()`/`getYamlFromComments()`

## MAJOR CHANGES

- refactored: `getYaml()` --> `getYamlFromComments()`
  Refactored code that previously was inside `getYaml()` to a own function in order to make it more reusible and the the code base more modular
- modified: default of argument `where` is now `parent.frame()` instead of `.GlobalEnv`

## MINOR CHANGES

- modified: made code now in `getYamlFromComments()` more robust
- modified: unit tests

## MISC

-----

# CHANGES IN yamlr VERSION 0.4.4

## NEW FEATURES

## BUG FIXES

- fixed: #1
  Certain constellations of curly brackets and YAML in comments still led to errors.

## MAJOR CHANGES

## MINOR CHANGES

- modified: `README.md`

## MISC

-----

# CHANGES IN yamlr VERSION 0.4.3

## NEW FEATURES

## BUG FIXES

- fixed: #10
  Failure to recognize multiple YAML statements when specified as comments

## MAJOR CHANGES

- renamed: `ReactiveReference*` --> `ObjectReference*` 
- added: field `pattern` in `YamlContext.ObjectReference.S3()`
  Regular expression pattern to identify the YAML markup for the respective context.
- added: roxygen template `yaml-syntax` 

## MINOR CHANGES

## MISC

- checked YAML syntax validity in unit test `test-parseYaml.r`

-----

# CHANGES IN yamlr VERSION 0.4.2

## NEW FEATURES

## BUG FIXES

- fixed: #1 
  Ensurance of curly brackets when length of function body is 1

## MAJOR CHANGES

## MINOR CHANGES

## MISC

-----

# CHANGES IN yamlr VERSION 0.4.1

## NEW FEATURES

## BUG FIXES

## MAJOR CHANGES

## MINOR CHANGES

- renamed: `README.Rmd` --> `README.md`

## MISC

-----

# CHANGES IN yamlr VERSION 0.4

## NEW FEATURES

## BUG FIXES

## MAJOR CHANGES

- renamed entire package: `fromyaml` --> `yamlr`
- changed internal structure of classes:
  - `ReactiveReferenceYaml.S3`
  - `ReactiveReferenceYamlParsed.S3`
  - `ReactiveReferenceYamlProcessed.S3`
- changed: `expr` inside `buildExpressionFromYaml`

## MINOR CHANGES

- renamed: `README.md` --> `README.Rmd`
- changed: examples and some unit tests

## MISC

-----

# CHANGES IN fromyaml VERSION 0.3.3

## NEW FEATURES

- added: `processYaml()`

## BUG FIXES

## MAJOR CHANGES

## MINOR CHANGES

- modified: `README.md`
- modified: examples
- added: unit test for `processYaml()`

## MISC

-----

# CHANGES IN fromyaml VERSION 0.3.2

## NEW FEATURES

## BUG FIXES

## MAJOR CHANGES

## MINOR CHANGES

- added: `where` in `getYaml()`
- Renamed: `ReactiveReference.S3` --> `YamlContext.ReactiveReference.S3` 
- modified: `README.md` 
- modified: examples

## MISC

-----

# CHANGES IN fromyaml VERSION 0.3.1

## NEW FEATURES

## BUG FIXES

## MAJOR CHANGES

## MINOR CHANGES

- modified: `README.md`
- modified: examples

## MISC

-----

# CHANGES IN fromyaml VERSION 0.3

## NEW FEATURES

## BUG FIXES

## MAJOR CHANGES

## MINOR CHANGES

## MISC

- successful git version bumped failed, no actual changes

-----

# CHANGES IN fromyaml VERSION 0.2

## NEW FEATURES

## BUG FIXES

## MAJOR CHANGES

## MINOR CHANGES

## MISC

- git version bumped failed, no actual changes

-----

# CHANGES IN VERSION 0.1

## NEW FEATURES

## BUG FIXES

## MAJOR CHANGES

## MINOR CHANGES

## MISC

- initial version
