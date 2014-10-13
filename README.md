fromyaml
======

Useful functionality to identify, parse and process YAML markup in a flexible and extendable manner

## Installation 

```
require("devtools")
devtools::install_github("Rappster/fromyaml")
require("fromyaml")
```

## Purpose 

The package aims at providing a general interface for processing YAML markup in a flexible and extendable manner based on the `S4` mechanism.
 
To realize a generic approach, the basic workflow method `getYaml()` takes two arguments:
 
- `from`: an object containing YAML markup

- `ctx` an object denoting the application context
 
  Current available contexts:
 
  - `ReactiveReferenceYamlContext.S3`
 
## Identifying/retrieving YAML markup
 
Function `getYaml`:
 
Takes an object that contains YAML markup and then tries to identify and retrieve the actual markup. 
 
Current available methods:
 
- `getYaml-function-ReactiveReferenceYamlContext.S3-method`:
 
  returns instance of class `ReactiveReferenceYaml.S3`
 	
## Parsing YAML markup
 
Function `parseYaml`:
 
Takes an object as returned by `getYaml` and parses it. 
 
Current available methods:
 
- `parseYaml-ReactiveReferenceYaml.S3-method`:
 
  returns instance of class `ReactiveReferenceYamlParsed.S3`
 
## Building expressions from YAML markup
 
Function `buildExpressionFromYaml`:
 
Takes an object as returned by `parseYaml` and builds suitable expressions based on the provided YAML markup. 
 
Current available methods:
 
- `buildExpressionFromYaml-ReactiveReferenceYamlParsed.S3-method`:
 
  returns instance of class `ReactiveReferenceYamlProcessed.S3`
 	
## Update original object that contained YAML markup
 
Function `updateYamlSource`:
 
Takes an object as returned by `buildExpressionFromYaml` and updates the underlying source object in order to substitute the YAML markup by suitable expressions to make the object fully self-contained. 
 
Current available methods:
 
- `updateYamlSource-ReactiveReferenceYamlProcessed.S3-method`:
 
  returns instance of class `ReactiveReferenceYamlProcessed.S3`
 			
  The object in field `src` can be used/evaluated as all YAML markup **as expected by the application context (see details in `?fromyaml`)** has been substituted by actual expressions.
 	
## Classes and constructors
 
The package defines the following S3 classes (in order of their workflow usage):
 
- `ReactiveReferenceYamlContext.S3`
- `ReactiveReferenceYaml.S3`
- `ReactiveReferenceYamlParsed.S3`
- `ReactiveReferenceYamlProcessed.S3`
  
### NOTE
 
S3 classes are generally used for speeding up rapid prototyping. It is possible that these classes are transformed to actual `S4` classes at some point
