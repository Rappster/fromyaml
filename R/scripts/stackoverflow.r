captureExpression <- function(
  expr,
  caller_offset = 1,
  brackets = TRUE
) {
  out <- eval(substitute(substitute(expr)), parent.frame(caller_offset))
  if (brackets && class(out) != "{") {
    out <- substitute({CODE}, list(CODE = out))
  }
  out
}
captureExpression(x_1 * 2)

foo <- function(expr) {
  captureExpression(expr = expr)
}
foo(x_1 * 2)

setGeneric(
  name = "bar",
  signature = c(
    "expr"
  ),
  def = function(
    expr,
    ...
  ) {
    standardGeneric("bar")       
  }
)
setMethod(
  f = "bar", 
  signature = signature(
    expr = "ANY"
  ), 
  definition = function(
    expr,
    ...
  ) {
  captureExpression(expr = expr, ...)    
})
bar(x_1 * 2)
bar(x_1 * 2, caller_offset = 2)
bar(x_1 * 2, caller_offset = 3)


################################################################################

#' @title
#' Foo (generic)
#'
#' @description 
#' Blabla.
#'     
#' @param x \strong{Signature argument}.
#'    Object containing expression information. Typically, a function or an
#'    "curly expression/call".
setGeneric(
  name = "foo",
  signature = c(
    "x"
  ),
  def = function(
    x,
    ...
  ) {
    standardGeneric("foo")       
  }
)

#' @describeIn foo
#' @inheritParams foo
#' @param x \code{\link{{}}.
#' @return \code{\link{expression}}. 
#' @export
setMethod(
  f = "foo", 
  signature = signature(
    x = "{"
  ), 
  definition = function(
    x,
    ...
  ) {
    
  print(x)
  return(TRUE)
  
  }
)

foo(x = quote({1 + 2}))
