#' @title
#' Class: ReactiveReferenceYaml.S3 
#'
#' @description
#' Class representing YAML markup in the context of reactive references and 
#' its constructor function. The class for the reactive reference context is
#' \code{\link[fromyaml]{ReactiveReferenceYamlContext.S3}}
#' 
#' @template intended-use
#'
#' @param .x \code{\link{ANY}}. An object of an arbitrary class whose class
#'    attribute should be updated so that it becomes an instance of class
#'    \code{ReactiveReferenceYaml.S3}. Mainly intended for rapid prototyping 
#'    purposes
#'    
#' @field yaml \code{\link{character}}.
#'    YAML markup as identified by 
#'    \code{\link[fromyaml]{getYaml}}
#'    Initial: \code{character()}.
#' @field index \code{\link{numeric}}.
#'    Index denoting the lines/expressions that where YAML was identified. 
#'    These lines/expressions will later be substituted by suitable expressions.
#'    Initial: \code{numeric()}. 
#' @field src \code{\link{ANY}}.
#'    Object in which YAML markup was identified. Typcially, this corresponds
#'    to a function or expression, but it can generally be any R object that
#'    can contain YAML markup and for which methods for 
#'    \code{\link[fromyaml]{getYaml}} are defined.
#'    Initial: \code{NULL}.
#' @return Instance of class \code{ReactiveReferenceYaml.S3}.
#' @example inst/examples/ReactiveReferenceYaml.S3.r
#' @seealso \code{
#'   	\link[fromyaml]{ReactiveReferenceYamlContext.S3}
#' }
#' @template author
#' @template references
#' @export
ReactiveReferenceYaml.S3 <- function(
  .x,
  yaml = character(),
  index = numeric(),
  src = NULL
) {
  if (!missing(.x)) {
    class(.x) <- c("ReactiveReferenceYaml.S3", class(.x))
    out <- .x
  } else {
    out <- new.env()
    out$yaml <- yaml
    out$index <- index
    out$src <- src
    class(out) <- c("ReactiveReferenceYaml.S3", class(out))
  }
  return(out)
}

