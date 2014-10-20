#' @title
#' Capture expression
#'
#' @description 
#' Captures an arbitrary R expression \strong{before} it is actually 
#' evaluated. This might be useful in situations, where you want to delay
#' the evaluation of the expression.
#'     
#' @param expr \strong{Signature argument}.
#'    Expression to capture.
#' @param caller_offset \code{\link{numeric}}.
#'    If specified, the offset in the callstack of the expression to be 
#'    treated as the caller.
#' @param brackets \code{\link{logical}}.
#'    \code{TRUE}: ensure that resulting expression is wrapped inside curly
#'    brackets (\code{{}});
#'    \code{FALSE}: expression returned exactly as captured.
#' @return \code{{} if \code{brackets = TRUE}, else class of evaluated 
#' expression.
#' @template threedots
#' @example inst/examples/captureExpression.r
#' @seealso \code{
#'   	\link[base]{substitute},
#'     \link[base]{parent.frame}
#' }
#' @template author
#' @template references
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
