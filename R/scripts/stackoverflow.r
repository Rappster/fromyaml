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
