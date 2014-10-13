#' @title
#' Class: ReactiveReferenceYamlProcessed.S3 
#'
#' @description
#' Class representing parsed YAML markup as returned by function 
#' \code{\link[fromyaml]{parseYaml}}
#' in the context of reactive references and its constructor function.
#' 
#' 
#' @template intended-use
#'
#' @param .x \code{\link{ANY}}. An object of an arbitrary class whose class
#'    attribute should be updated so that it becomes an instance of class
#'    \code{ReactiveReferenceYamlProcessed.S3}. Mainly intended for rapid prototyping 
#'    purposes
#'    
#' @field yaml \code{\link{character}}.
#'    YAML markup as identified by 
#'    \code{\link[fromyaml]{getYaml}}
#'    Initial: \code{character()}.
#' @field yaml_parsed \code{\link{list}}.
#'    Parsed YAML markup as identified by 
#'    \code{\link[fromyaml]{getYaml}} and parsed by \code{\link[fromyaml]{parseYaml}}.
#'    Initial: \code{list(id = character, where = NULL, as = NULL)}.
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
#' @field expr \code{\link{environment}}.
#'    Necessary expressions in the context of processing YAML markup.
#'    Typically, these are \code{\link[base]{get}}, \code{\link[base]{exists}}
#'    and \code{\link[base]{assign}} expressions, but generally this field 
#'    can hold any valid R expression.
#'    Initial: \code{new.env(parent = emptyenv())}.
#' @return Instance of class \code{ReactiveReferenceYamlProcessed.S3}.
#' @example inst/examples/ReactiveReferenceYamlProcessed.S3.r
#' @seealso \code{
#'   	\link[fromyaml]{ReactiveReferenceYaml.S3},
#'     \link[fromyaml]{ReactiveReferenceYamlProcessed.S3},
#'     \link[fromyaml]{getYaml},
#'     \link[fromyaml]{parseYaml}
#' }
#' @template author
#' @template references
#' @export
ReactiveReferenceYamlProcessed.S3 <- function(
  .x,
  yaml = character(),
  yaml_parsed = list(id = character, where = NULL, as = NULL),
  index = numeric(),
  src = NULL,
  expr = new.env(parent = emptyenv())
) {
  if (!missing(.x)) {
    class(.x) <- c("ReactiveReferenceYamlProcessed.S3", class(.x))
    out <- .x
  } else {
    out <- new.env()
    out$yaml <- yaml
    out$yaml_parsed <- yaml_parsed
    out$index <- index
    out$src <- src
    out$expr <- expr
    class(out) <- c("ReactiveReferenceYamlProcessed.S3", class(out))
  }
  return(out)
}

