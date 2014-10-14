yamlr
=====

Useful functionality to identify, parse and process YAML markup in a flexible and extendable manner.

## Installation 

```
require("devtools")
devtools::install_github("Rappster/yamlr")
require("yamlr")
```

## Purpose 

The package aims at providing a general interface for processing [YAML markup](http://www.yaml.org/) in a flexible and extendable manner based on the `S4` mechanism.
 
To realize a generic approach, the basic workflow method `getYaml()` takes two arguments:
 
- `from`: an object containing YAML markup

- `ctx` an object denoting the application context
 
  Currently available contexts:
 
  - `YamlContext.ObjectReference.S3`
 
## YAML syntax

Note that the YAML statement for specifying **object references** (currently the only context that is defined in the package iteself) must be as follows:

```
object-ref: {id: {id}, where: {where}, as: {id-ref}}
```

Note that elements `where` and `as` are optional and that spaces are required between each syntax component. While the lack of spaces will cause a parsing error in `yaml::yaml.load`, additional spaces do not casue any trouble.

This is the regular expression used to identify YAML markup

```
.*object-ref:\\s+\\{\\s*id\\s*:\\s+\\w+.*\\}
```

### Example for valid YAML statements

```
object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}
object-ref: {id: x_1, where: parent.env()}
object-ref: {id: x_1}
object-ref:  {  id:   x_1, where  : where_1, as: ref_1  }
```

See the official [YAML website]{http://www.yaml.org/} for more details about YAML
 
## Processing YAML markup

Function `processYaml` is a convenience wrapper around all functions that are involved in processing YAML markup (see functions below).

The goal of processing an object containing YAML markup is to identify and parse the markup in order to update the underlying source object in a way, that YAML markup is substituted with actual expressions so that the object becomes "self-contained" in the sense that it holds all necessary information in order to do its job.

Currently, the underlying objects containing YAML markup are functions and the processing result is a function where the markup is substituted with expressions that retrieve referenced objects

### Example 

```
yaml <- processYaml(
  from = function() {
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1 * 2
  },
  ctx = YamlContext.ObjectReference.S3()
)
yaml
yaml$src
```
The source object can now be executed

```
x_1 <- 10
eval(yaml$src())
```

Note that the function body of `from` can also call arbitrary other functions in order to process the object reference in the desired way

```
x_1 <- 10
foo <- function(x) {
  message("Value of 'x' in 'foo()':")
  print(x)
  x * 2
}
yaml <- processYaml(
  from = function() {
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    message("Referenced object 'x_1' from '.GlobalEnv' as 'ref_1':")
    foo(x = ref_1)
  },
  ctx = YamlContext.ObjectReference.S3()
)
yaml
yaml$src
eval(yaml$src())
```

-----

## Identifying/retrieving YAML markup
 
Function `getYaml`:
 
Takes an object that contains YAML markup and then tries to identify and retrieve the actual markup. 
 
Currently available methods:
 
- `getYaml-function-YamlContext.ObjectReference.S3-method`:
 
  returns instance of class `ObjectReferenceYaml.S3`
 	
### Example

YAML markdown as inline string

```
## With curly brackets //  
yaml <- getYaml(
  from = function() {
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1 * 2
  },
  ctx = YamlContext.ObjectReference.S3()
)
yaml
yaml$original
yaml$index
yaml$src

## W/o curly brackets //
yaml <- getYaml(
  from = function()
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}",
  ctx = YamlContext.ObjectReference.S3()
)
yaml$original
yaml$original
yaml$index
yaml$src
```

YAML markdown as comment

```
## With curly brackets //  
yaml <- getYaml(
  from = function() {
    ## object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}
    ref_1 * 2
  },
  ctx = YamlContext.ObjectReference.S3()
)
yaml$original
yaml$index
yaml$src

## W/o curly brackets //
yaml <- getYaml(
  from = function()
    ## object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}
    ref_1 * 2,
  ctx = YamlContext.ObjectReference.S3()
)
yaml$original
yaml$index
yaml$src
```
   
## Parsing YAML markup
 
Function `parseYaml`:
 
Takes an object as returned by `getYaml` and parses it. 
 
Currently available methods:
 
- `parseYaml-ObjectReferenceYaml.S3-method`:
 
  returns instance of class `ObjectReferenceYamlParsed.S3`
 
### Example 

```
## Get //
yaml <- getYaml(
  from = function() {
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1 * 2
  },
  ctx = YamlContext.ObjectReference.S3()
)

## Parse //
yaml <- parseYaml(yaml = yaml)

## Inspeact //
yaml
yaml$original
yaml$parsed
yaml$index
yaml$src
```
 
## Building expressions from YAML markup
 
Function `buildExpressionFromYaml`:
 
Takes an object as returned by `parseYaml` and builds suitable expressions based on the provided YAML markup. 
 
Currently available methods:
 
- `buildExpressionFromYaml-ObjectReferenceYamlParsed.S3-method`:
 
  returns instance of class `ObjectReferenceYamlProcessed.S3`
 	
### Example 

```
## Get //
yaml <- getYaml(
  from = function() {
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1 * 2
  },
  ctx = YamlContext.ObjectReference.S3()
)

## Parse //
yaml <- parseYaml(yaml = yaml)

## Build //
yaml <- buildExpressionFromYaml(yaml = yaml)

## Two ways of accessing expressions //
## 1) Via 'parsed':
ls(yaml$parsed$x_1$expr)
yaml$parsed$x_1$expr$exists
yaml$parsed$x_1$expr$validate
yaml$parsed$x_1$expr$get_assign

## 2) Via 'expr':
ls(yaml$expr$x_1)
yaml$expr$x_1$exists
yaml$expr$x_1$validate
yaml$expr$x_1$get_assign

## NOTE
## The environment in `expr${id}` corresponds to the environment 
## in `parsed${id}$expr. So expressions are not actually stored redundantly
## as environments implement a "pass-by-referenc" instead of the otherwise
## typical "pass-by-value" paradigm. 
## Environment `expr` simply exists as a shorthand for accessing expressions

## Example of expression execution //
## Validity checks:
suppressWarnings(rm(x_1))
eval(yaml$parsed$x_1$expr$exists)
eval(yaml$parsed$x_1$expr$validate)
x_1 <- 10
eval(yaml$parsed$x_1$expr$exists)
eval(yaml$parsed$x_1$expr$validate)

## The line that contained the YAML markup in 'from' above will be substituted
## by this expression 
eval(yaml$parsed$x_1$expr$get_assign)
ref_1
```
   
## Update original object that contained YAML markup
 
Function `updateYamlSource`:
 
Takes an object as returned by `buildExpressionFromYaml` and updates the underlying source object in order to substitute the YAML markup by suitable expressions to make the object fully self-contained. 
 
Currently available methods:
 
- `updateYamlSource-ObjectReferenceYamlProcessed.S3-method`:
 
  returns instance of class `ObjectReferenceYamlProcessed.S3`
 			
  The object in field `src` can be used/evaluated as all YAML markup **as expected by the application context (see details in `?yamlr`)** has been substituted by actual expressions.
 	
### Example 

```
## Get //  
yaml <- getYaml(
  from = function() {
    "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
    ref_1 * 2
  },
  ctx = YamlContext.ObjectReference.S3()
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
 
- `YamlContext.ObjectReference.S3`
- `ObjectReferenceYaml.S3`
- `ObjectReferenceYamlParsed.S3`
- `ObjectReferenceYamlProcessed.S3`
  
### NOTE
 
S3 classes are generally used for speeding up rapid prototyping. It is possible that these classes are transformed to actual `S4` classes at some point
