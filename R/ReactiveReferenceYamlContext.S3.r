#' @title
#' Class: ReactiveReferenceYamlContext.S3 
#'
#' @description
#' Class representing the reactive reference context with respect to 
#' processing YAML markup.
#' 
#' @template intended-use
#'
#' @param .x \code{\link{ANY}}. An object of an arbitrary class whose class
#'    attribute should be updated so that it becomes an instance of class
#'    \code{ReactiveReferenceYamlContext.S3}. Mainly intended for rapid prototyping 
#'    purposes
#'    
#' @field ctx \code{\link{character}}.
#'    Context ID. Corresponds to the class name.
#'    Initial: \code{"ReactiveReferenceYamlContext.S3"}.
#' @return Instance of class \code{ReactiveReferenceYamlContext.S3}.
#' @example inst/examples/ReactiveReferenceYamlContext.S3.r
#' @template author
#' @template references
#' @export
ReactiveReferenceYamlContext.S3 <- function(
  .x,
  ctx = "ReactiveReferenceYamlContext.S3"
) {
  if (!missing(.x)) {
    class(.x) <- c("ReactiveReferenceYamlContext.S3", class(.x))
    out <- .x
  } else {
    out <- new.env()
    out$ctx <- ctx
    class(out) <- c("ReactiveReferenceYamlContext.S3", class(out))
  }
  return(out)
}

