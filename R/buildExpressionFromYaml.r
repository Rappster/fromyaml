#' @title
#' Build Expression Based on YAML Markup (generic)
#'
#' @description 
#' Builds expression(s) based on the YAML markup as identified by 
#' \code{\link[fromyaml]{getYaml}} and parsed by \code{\link[fromyaml]{parseYaml}}.
#'   	
#' @param yaml \strong{Signature argument}.
#'    Object containing parsed YAML markup as returned by 
#'    \code{\link[fromyaml]{parseYaml}}.
#' @template threedots
#' @example inst/examples/buildExpressionFromYaml.r
#' @seealso \code{
#'   	\link[fromyaml]{buildExpressionFromYaml-ReactiveReferenceYamlParsed.S3-method}
#' }
#' @template author
#' @template references
setGeneric(
  name = "buildExpressionFromYaml",
  signature = c(
    "yaml"
  ),
  def = function(
    yaml,
    ...
  ) {
    standardGeneric("buildExpressionFromYaml")       
  }
)

#' @title
#' Build Expression Based on YAML Markup (ReactiveReferenceYamlParsed.S3)
#'
#' @description 
#' See generic: \code{\link[yamlyaml]{buildExpressionFromYaml}}
#'      
#' @inheritParams buildExpressionFromYaml
#' @param yaml \code{\link{ReactiveReferenceYamlParsed.S3}}.
#' @return \code{\link{ReactiveReferenceYamlProcessed.S3}}. 
#'    Processed YAML markup.
#' @example inst/examples/buildExpressionFromYaml.r
#' @seealso \code{
#'    \link[yamlyaml]{buildExpressionFromYaml}
#' }
#' @template author
#' @template references
#' @export
#' @aliases buildExpressionFromYaml-ReactiveReferenceYamlParsed.S3-method
setMethod(
  f = "buildExpressionFromYaml", 
  signature = signature(
    yaml = "ReactiveReferenceYamlParsed.S3"
  ), 
  definition = function(
    yaml,
    ...
  ) {
  
  expr <- lapply(yaml$yaml_parsed, function(el) {
    env <- new.env(parent = emptyenv())
    assign("get_assign", substitute(AS <- get(x = ID, envir = WHERE, inherits = FALSE),
        list(AS = el$as, ID = el$id, WHERE = eval(el$where))
      ),
      env
    )
    env
  })

  expr_env <- new.env(parent = emptyenv())
  sapply(names(expr), function(id) {
    assign(id, expr[[id]], expr_env)  
  })
#   expr_env$x_1$get
  out <- ReactiveReferenceYamlProcessed.S3(
    yaml = yaml$yaml,
    yaml_parsed = yaml$yaml_parsed,
    index = yaml$index,
    src = yaml$src,
    expr = expr_env
  )
  out
  
  }
)
