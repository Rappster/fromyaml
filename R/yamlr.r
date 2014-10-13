#' @title
#' Processing of YAML markup
#'
#' @description
#' Useful functionality to identify, parse and process YAML markup.
#' 
#' @details 
#' The package aims at providing a general interface for processing YAML
#' markup in a flexible and extendable manner based on the 
#' \code{S4 \link[methods]{Methods}} mechanism.
#' 
#' To realize a generic approach, the basic workflow method
#' \code{\link[yamlr]{getYaml}} takes two arguments:
#' 
#' \enumerate{
#' 		\item{\code{from}: } {
#' 			An object containing YAML markup
#' 		}
#' 		\item{\code{ctx}: } {
#' 			An object denoting the application context.
#' 
#' 			Current available contexts:
#' 
#' 			\itemize{
#' 				\item{\code{\link[yamlr]{YamlContext.ReactiveReference.S3}}}
#' 			}
#' 		}
#' } 
#' 
#' @section Processing YAML markup:
#' 
#' Function \code{\link[yamlr]{processYaml}}:
#' 
#' This is the main top-level function for using this package. It is 
#' wrapper around the sequential execution of 
#' 
#' \itemize{
#'   	\item{\code{\link[yamlr]{getYaml}}}
#'     \item{\code{\link[yamlr]{parseYaml}}}
#'     \item{\code{\link[yamlr]{buildExpressionFromYaml}}}
#'     \item{\code{\link[yamlr]{updateYamlSource}}}
#' } 
#' 
#' Takes an object that contains YAML markup and then processes it eventually
#' resulting in updating the underlying object so that it can be used/executed. 
#' 
#' Current available methods:
#' 
#' \itemize{
#'   	\item{\code{\link[yamlr]{processYaml-function-YamlContext.ReactiveReference.S3-method}}: } {
#' 
#' 			Returns instance of class \code{\link[yamlr]{ReactiveReferenceYamlProcessed.S3}}.
#' 		}
#' } 
#' 
#' @section Identifying/retrieving YAML markup:
#' 
#' Function \code{\link[yamlr]{getYaml}}:
#' 
#' Takes an object that contains YAML markup and then tries to identify and
#' retrieve the actual markup. 
#' 
#' Current available methods:
#' 
#' \itemize{
#' 		\item{\code{\link[yamlr]{getYaml-function-YamlContext.ReactiveReference.S3-method}}: } {
#' 
#' 			Returns instance of class \code{\link[yamlr]{ReactiveReferenceYaml.S3}}.
#' 		}
#' } 
#' 
#' @section Parsing YAML markup:
#' 
#' Function \code{\link[yamlr]{parseYaml}}:
#' 
#' Takes an object as returned by \code{\link[yamlr]{getYaml}}
#' and parses it. 
#' 
#' Current available methods:
#' 
#' \itemize{
#' 		\item{\code{\link[yamlr]{parseYaml-ReactiveReferenceYaml.S3-method}}: } {
#' 
#' 			Returns instance of class \code{\link[yamlr]{ReactiveReferenceYamlParsed.S3}}.
#' 		}
#' }  
#' 
#' @section Building expressions from YAML markup:
#' 
#' Function \code{\link[yamlr]{buildExpressionFromYaml}}:
#' 
#' Takes an object as returned by \code{\link[yamlr]{parseYaml}}
#' and builds suitable expressions based on the provided YAML markup. 
#' 
#' Current available methods:
#' 
#' \itemize{
#' 		\item{\code{\link[yamlr]{buildExpressionFromYaml-ReactiveReferenceYamlParsed.S3-method}}: } {
#' 
#' 			Returns instance of class \code{\link[yamlr]{ReactiveReferenceYamlProcessed.S3}}.
#' 		}
#' }  
#' 
#' @section Update original object that contained YAML markup:
#' 
#' Function \code{\link[yamlr]{updateYamlSource}}:
#' 
#' Takes an object as returned by \code{\link[yamlr]{buildExpressionFromYaml}}
#' and updates the underlying source object in order to substitute the 
#' YAML markup by suitable expressions to make the object fully self-contained. 
#' 
#' Current available methods:
#' 
#' \itemize{
#' 		\item{\code{\link[yamlr]{updateYamlSource-ReactiveReferenceYamlProcessed.S3-method}}: } {
#' 
#' 			Returns instance of class \code{\link[yamlr]{ReactiveReferenceYamlProcessed.S3}}.
#' 			
#' 			The object in field \code{src} can be used/evaluated as all YAML markup
#' 			\strong{as expected by the application context (see details)}
#' 			has been substituted by actual expressions.
#' 		}
#' }  
#' 
#' @section Classes and constructors:
#' 
#' The package defines the following S3 classes 
#' (in order of their workflow usage):
#' 
#' \itemize{
#'   	\item{\code{\link[yamlr]{YamlContext.ReactiveReference.S3}}}
#'     \item{\code{\link[yamlr]{ReactiveReferenceYaml.S3}}}
#'     \item{\code{\link[yamlr]{ReactiveReferenceYamlParsed.S3}}}
#'     \item{\code{\link[yamlr]{ReactiveReferenceYamlProcessed.S3}}}
#' }  
#' 
#' \strong{NOTE}
#' 
#' S3 classes are generally used for speeding up rapid prototyping. It is possible
#' that these classes are transformed to actual \code{S4} classes at some point
#' 
#' @template author
#' @template references
#' @docType package
#' @name yamlr
NULL
