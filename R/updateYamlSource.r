#' @title
#' Update Object that originally contained YAML Markup (generic)
#'
#' @description 
#' Updates the object that originally contained YAML markup. To be more 
#' specific, the function updates field \code{src} or class 
#' \code{\link[fromyaml]{ReactiveReferenceYamlProcessed}} as returned by 
#' \code{\link[fromyaml]{buildExpressionFromYaml}}.
#'   	
#' @param yaml \strong{Signature argument}.
#'    Object containing processed YAML markup as returned by 
#'    \code{\link[fromyaml]{buildExpressionFromYaml}}.
#' @template threedots
#' @example inst/examples/updateYamlSource.r
#' @seealso \code{
#'   	\link[fromyaml]{updateYamlSource-ReactiveReferenceYamlProcessed.S3-method},
#'     \link[fromyaml]{getYaml},
#'     \link[fromyaml]{parseYaml},
#'     \link[fromyaml]{buildExpressionFromYaml}
#' }
#' @template author
#' @template references
setGeneric(
  name = "updateYamlSource",
  signature = c(
    "yaml"
  ),
  def = function(
    yaml,
    ...
  ) {
    standardGeneric("updateYamlSource")       
  }
)

#' @title
#' Parse YAML Markup (ReactiveReferenceYaml.S3)
#'
#' @description 
#' See generic: \code{\link[yamlyaml]{updateYamlSource}}
#'      
#' @inheritParams updateYamlSource
#' @param yaml \code{\link{ReactiveReferenceYamlProcessed.S3}}.
#' @return \code{\link{ReactiveReferenceYamlProcessed}}.
#'  Processed YAML markup with Updated \code{src} field value.
#'  The original markup has been substituted by the respective expression
#'  (\code{$expr${ref}$get_assign} with \code{{ref}} being the ID of the 
#'  reactive reference). 
#' @example inst/examples/updateYamlSource.r
#' @seealso \code{
#'    \link[yamlyaml]{updateYamlSource},
#'     \link[fromyaml]{getYaml},
#'     \link[fromyaml]{parseYaml},
#'     \link[fromyaml]{buildExpressionFromYaml}
#' }
#' @template author
#' @template references
#' @export
#' @aliases updateYamlSource-ReactiveReferenceYamlProcessed.S3-method
setMethod(
  f = "updateYamlSource", 
  signature = signature(
    yaml = "ReactiveReferenceYamlProcessed.S3"
  ), 
  definition = function(
    yaml,
    ...
  ) {
        
  in_body <- is.function(yaml$src)
  index <- yaml$index
  src <- yaml$src
  expr <- yaml$expr
  parsed <- yaml$yaml_parsed

  for (ii in names(parsed)) {
    if (in_body) {
      body(src)[[parsed[[ii]]$index]] <- expr[[ii]]$get_assign
    } else {
      src[[parsed[[ii]]$index]] <- expr[[ii]]$get_assign
    }
  }
  yaml$src <- src

  return(yaml)
  
  }
)
