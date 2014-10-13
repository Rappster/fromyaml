fromyaml
======

Useful functionality to identify, parse and process YAML markup in a flexible and extendable manner.

## Installation 

```
require("devtools")
devtools::install_github("Rappster/fromyaml")
require("fromyaml")
```

## Purpose 

The package aims at providing a general interface for processing [YAML markup](http://www.yaml.org/) in a flexible and extendable manner based on the `S4` mechanism.
 
To realize a generic approach, the basic workflow method `getYaml()` takes two arguments:
 
- `from`: an object containing YAML markup

- `ctx` an object denoting the application context
 
  Current available contexts:
 
  - `YamlContext.ReactiveReference.S3`
 
## Processing YAML markup

Function `processYaml` is a convenience wrapper around all functions that are involved in processing YAML markup (see functions below).

The goal of processing an object containing YAML markup is to identify and parse the markup in order to update the underlying source object in a way, that YAML markup is substituted with actual expressions so that the object becomes "self-contained" in the sense that it holds all necessary information in order to do its job.

Currently, the underlying objects containing YAML markup are functions and the processing result is a function where the markup is substituted with expressions that retrieve referenced objects

### Example 

```
yaml <- processYaml(
  from = function() {
    "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1 * 2
  },
  ctx = YamlContext.ReactiveReference.S3()
)
yaml$src

# function () 
# {
#     ref_1 <- get(x = "x_1", envir = <environment>, inherits = FALSE)
#     ref_1 * 2
# }
```
The source object can now be executed

```
x_1 <- 10
eval(yaml$src())

# [1] 20
## --> 'x_1' from '.GlobalEnv' used as 'ref_1' times 2
```

-----

## Identifying/retrieving YAML markup
 
Function `getYaml`:
 
Takes an object that contains YAML markup and then tries to identify and retrieve the actual markup. 
 
Current available methods:
 
- `getYaml-function-YamlContext.ReactiveReference.S3-method`:
 
  returns instance of class `ReactiveReferenceYaml.S3`
 	
### Example

YAML markdown as inline string

```
## With curly brackets //  
yaml <- getYaml(
  from = function() {
    "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1 * 2
  },
  ctx = YamlContext.ReactiveReference.S3()
)
yaml
yaml$yaml
yaml$index
yaml$src

## W/o curly brackets //
yaml <- getYaml(
  from = function()
    "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}",
  ctx = YamlContext.ReactiveReference.S3()
)
yaml$yaml
yaml$yaml
yaml$index
yaml$src
```

YAML markdown as comment

```
## With curly brackets //  
yaml <- getYaml(
  from = function() {
    ## reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}
    ref_1 * 2
  },
  ctx = YamlContext.ReactiveReference.S3()
)
yaml$yaml
yaml$index
yaml$src

## W/o curly brackets //
yaml <- getYaml(
  from = function()
    ## reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}
    ref_1 * 2,
  ctx = YamlContext.ReactiveReference.S3()
)
yaml$yaml
yaml$index
yaml$src
```
   
## Parsing YAML markup
 
Function `parseYaml`:
 
Takes an object as returned by `getYaml` and parses it. 
 
Current available methods:
 
- `parseYaml-ReactiveReferenceYaml.S3-method`:
 
  returns instance of class `ReactiveReferenceYamlParsed.S3`
 
### Example 

```
## Get //
yaml <- getYaml(
  from = function() {
    "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1 * 2
  },
  ctx = YamlContext.ReactiveReference.S3()
)

## Parse //
yaml <- parseYaml(yaml = yaml)

## Inspeact //
yaml
yaml$yaml
yaml$yaml_parsed
yaml$index
yaml$src
```
 
## Building expressions from YAML markup
 
Function `buildExpressionFromYaml`:
 
Takes an object as returned by `parseYaml` and builds suitable expressions based on the provided YAML markup. 
 
Current available methods:
 
- `buildExpressionFromYaml-ReactiveReferenceYamlParsed.S3-method`:
 
  returns instance of class `ReactiveReferenceYamlProcessed.S3`
 	
### Example 

```
## Get //
yaml <- getYaml(
  from = function() {
    "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1 * 2
  },
  ctx = YamlContext.ReactiveReference.S3()
)

## Parse //
yaml <- parseYaml(yaml = yaml)

## Build //
yaml <- buildExpressionFromYaml(yaml = yaml)
yaml
yaml$expr$x_1
ls(yaml$expr$x_1)

## Example of expression execution //
## The line that contained the YAML markup in 'from' above will be substituted
## by this expression 
x_1 <- 10
yaml$expr$x_1$get_assign
eval(yaml$expr$x_1$get_assign)
ref_1
```
   
## Update original object that contained YAML markup
 
Function `updateYamlSource`:
 
Takes an object as returned by `buildExpressionFromYaml` and updates the underlying source object in order to substitute the YAML markup by suitable expressions to make the object fully self-contained. 
 
Current available methods:
 
- `updateYamlSource-ReactiveReferenceYamlProcessed.S3-method`:
 
  returns instance of class `ReactiveReferenceYamlProcessed.S3`
 			
  The object in field `src` can be used/evaluated as all YAML markup **as expected by the application context (see details in `?fromyaml`)** has been substituted by actual expressions.
 	
### Example 

```
## Get //  
yaml <- getYaml(
  from = function() {
    "reactive-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1 * 2
  },
  ctx = YamlContext.ReactiveReference.S3()
)

## Parse //
yaml <- parseYaml(yaml = yaml)

## Build //
yaml <- buildExpressionFromYaml(yaml = yaml)

## Update //
yaml <- updateYamlSource(yaml = yaml)

## Inspect //
yaml$src
## --> note that the original YAML markup has been substituted by a 
## suitable expression for this specific context (`yaml$src$x_1$get_assign`).
## The processing is now complete and the source object can be used as is
## as it is now "self contained" in the sense that it contains all information
## that are needed in order for it to do its job.

## Actual use of the source object //
x_1 <- 10
eval(yaml$src())

## Clean up //
rm(x_1)
rm(yaml)
```
   
## Classes and constructors
 
The package defines the following S3 classes (in order of their workflow usage):
 
- `YamlContext.ReactiveReference.S3`
- `ReactiveReferenceYaml.S3`
- `ReactiveReferenceYamlParsed.S3`
- `ReactiveReferenceYamlProcessed.S3`
  
### NOTE
 
S3 classes are generally used for speeding up rapid prototyping. It is possible that these classes are transformed to actual `S4` classes at some point
