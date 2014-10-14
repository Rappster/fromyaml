#' @title
#' Build Expression Based on YAML Markup (generic)
#'
#' @description 
#' Builds expression(s) based on the YAML markup as identified by 
#' \code{\link[yamlr]{getYaml}} and parsed by \code{\link[yamlr]{parseYaml}}.
#'   	
#' @details
#' Expressions that should be executed in order to validate certain aspects can 
#' be put into a parsed reference's \code{expr} environment at subenvironment
#' \code{"validate"} (i.e. \code{{parse-yaml}${id}$expr$validate}).
#' That way, at any given time, one could simply execute all expressions in
#' that environment in order to validate if all prerequisites are met 
#' (for example "check if the specified reference actually exists and throw 
#' an error if it doesn't").
#' 
#' See method \code{\link[yamlr]{buildExpressionFromYaml-ObjectReferenceYamlParsed.S3-method}}
#' for an example for this
#'     
#' @template yaml-syntax
#'     
#' @param yaml \strong{Signature argument}.
#'    Object containing parsed YAML markup as returned by 
#'    \code{\link[yamlr]{parseYaml}}.
#' @param where \code{\link{environment}}.
#'    Environment in which to assign the function in the \code{src} field of 
#'    class \code{\link[yamlr]{ObjectReferenceYaml.S3}}. Only relevant 
#'    in case the YAML has been provided via comments instead of an 
#'    inline string as this involves some additional transformation steps.
#' @template threedots
#' @example inst/examples/buildExpressionFromYaml.r
#' @seealso \code{
#'   	\link[yamlr]{buildExpressionFromYaml-ObjectReferenceYamlParsed.S3-method}
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
    where = parent.frame(),
    ...
  ) {
    standardGeneric("buildExpressionFromYaml")       
  }
)

#' @title
#' Build Expression Based on YAML Markup (ObjectReferenceYamlParsed.S3)
#'
#' @description 
#' See generic: \code{\link[yamlyaml]{buildExpressionFromYaml}}
#'      
#' @inheritParams buildExpressionFromYaml
#' @param yaml \code{\link{ObjectReferenceYamlParsed.S3}}.
#' @return \code{\link{ObjectReferenceYamlProcessed.S3}}. 
#'    Processed YAML markup.
#' @example inst/examples/buildExpressionFromYaml.r
#' @seealso \code{
#'    \link[yamlyaml]{buildExpressionFromYaml}
#' }
#' @template author
#' @template references
#' @export
#' @aliases buildExpressionFromYaml-ObjectReferenceYamlParsed.S3-method
setMethod(
  f = "buildExpressionFromYaml", 
  signature = signature(
    yaml = "ObjectReferenceYamlParsed.S3"
  ), 
  definition = function(
    yaml,
    where,
    ...
  ) {
    
  expr_env <- new.env(parent = emptyenv())    
  expr <- lapply(yaml$parsed, function(el) {
    env <- el$expr
    ## Exists //
    assign(
      "exists", 
      substitute(
        exists(x = ID, envir = WHERE, inherits = FALSE),
        list(ID = el$id, WHERE = eval(el$where))
      ),
      env
    )
    ## Get and assign //
    assign("get_assign", substitute(AS <- get(x = ID, envir = WHERE, inherits = FALSE),
        list(AS = el$as, ID = el$id, WHERE = eval(el$where))
      ),
      env
    )
    ## Validate //
    env$validate <- new.env(parent = emptyenv())
    assign(
      "exists", 
      substitute(
        if (!EXISTS) {
          msg <- c(
            "Reactive reference does not exist:",
            paste0("ID: ", ID),
            paste0("Where: ", WHERE)
          )
          stop(paste(msg, collapse = "\n"))
        },
        list(ID = el$id, WHERE = capture.output(eval(el$where)),
             EXISTS = env$exists)
      ),
      env$validate
    )
    
    ## Assign to shorthand field //
    assign(el$id, env, expr_env)
    env
  })

  out <- ObjectReferenceYamlProcessed.S3(
    original = yaml$original,
    parsed = yaml$parsed,
    index = yaml$index,
    src = yaml$src,
    expr = expr_env
  )
  out
  
  }
)
