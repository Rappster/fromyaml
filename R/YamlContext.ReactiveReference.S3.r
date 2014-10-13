#' @title
#' Class: YamlContext.ReactiveReference.S3 
#'
#' @description
#' Class representing the reactive reference context with respect to 
#' processing YAML markup.
#' 
#' @template intended-use
#'
#' @param .x \code{\link{ANY}}. An object of an arbitrary class whose class
#'    attribute should be updated so that it becomes an instance of class
#'    \code{YamlContext.ReactiveReference.S3}. Mainly intended for rapid prototyping 
#'    purposes
#'    
#' @field ctx \code{\link{character}}.
#'    Context ID. Corresponds to the class name.
#'    Initial: \code{"YamlContext.ReactiveReference.S3"}.
#' @return Instance of class \code{YamlContext.ReactiveReference.S3}.
#' @example inst/examples/YamlContext.ReactiveReference.S3.r
#' @template author
#' @template references
#' @export
YamlContext.ReactiveReference.S3 <- function(
  .x,
  ctx = "YamlContext.ReactiveReference.S3"
) {
  if (!missing(.x)) {
    class(.x) <- c("YamlContext.ReactiveReference.S3", class(.x))
    out <- .x
  } else {
    out <- new.env()
    out$ctx <- ctx
    class(out) <- c("YamlContext.ReactiveReference.S3", class(out))
  }
  return(out)
}

