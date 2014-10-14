#' @title
#' Class: YamlContext.ObjectReference.S3 
#'
#' @description
#' Class representing the reactive reference context with respect to 
#' processing YAML markup.
#' 
#' @template intended-use
#'
#' @param .x \code{\link{ANY}}. An object of an arbitrary class whose class
#'    attribute should be updated so that it becomes an instance of class
#'    \code{YamlContext.ObjectReference.S3}. Mainly intended for rapid prototyping 
#'    purposes
#'    
#' @field ctx \code{\link{character}}.
#'    Context ID. Corresponds to the class name.
#'    Initial: \code{"YamlContext.ObjectReference.S3"}.
#' @field pattern \code{\link{character}}.
#'    Pattern to recognize YAML markup. 
#'    Initial: \code{".*object-ref:\\s?\\{\\s?id\\s?: \\w+.*\\}"}.
#' @return Instance of class \code{YamlContext.ObjectReference.S3}.
#' @example inst/examples/YamlContext.ObjectReference.S3.r
#' @template author
#' @template references
#' @export
YamlContext.ObjectReference.S3 <- function(
  .x,
  ctx = "YamlContext.ObjectReference.S3",
  pattern = ".*object-ref:\\s?\\{\\s?id\\s?: \\w+.*\\}"
) {
  if (!missing(.x)) {
    class(.x) <- c("YamlContext.ObjectReference.S3", class(.x))
    out <- .x
  } else {
    out <- new.env()
    out$ctx <- ctx
    out$pattern <- pattern
    class(out) <- c("YamlContext.ObjectReference.S3", class(out))
  }
  return(out)
}

