#' @title
#' Process YAML Markup (generic)
#'
#' @description 
#' Convenience wrapper. Processes YAML markup in the sense that the complete 
#' workflow associated to a given application context is executed. 
#' 
#' @details 
#' Currently, this means that all processing steps associated with the context 
#' \code{\link[fromyaml]{YamlContext.ReactiveReference.S3}} are executed:
#' 
#' \itemiz{
#'    \item{\code{\link[fromyaml]{getYaml}}}
#'    \item{\code{\link[fromyaml]{parseYaml}}}
#'    \item{\code{\link[fromyaml]{buildExpressionFromYaml}}}
#'    \item{\code{\link[fromyaml]{updateYamlSource}}}
#' }
#'   	
#' @param from \strong{Signature argument}.
#'    Object containing YAML markup.
#' @param ctx \strong{Signature argument}.
#'    Markup proecessing context.
#' @param where \code{\link{environment}}.
#'    Environment in which to assign the function in the \code{src} field of 
#'    class \code{\link[fromyaml]{ReactiveReferenceYaml.S3}}. Only relevant 
#'    in case the YAML has been provided via comments instead of an 
#'    inline string as this involves some additional transformation steps.
#' @template threedots
#' @example inst/examples/processYaml.r
#' @seealso \code{
#'   	\link[fromyaml]{processYaml-function-YamlContext.ReactiveReference.S3-method},
#'    \link[fromyaml]{getYaml},
#'    \link[fromyaml]{parseYaml},
#'    \link[fromyaml]{buildExpressionFromYaml},
#'    \link[fromyaml]{updateYamlSource}
#' }
#' @template author
#' @template references
setGeneric(
  name = "processYaml",
  signature = c(
    "from",
    "ctx"
  ),
  def = function(
    from,
    ctx = NULL,
    where = parent.frame(),
    ...
  ) {
    standardGeneric("processYaml")       
  }
)

#' @title
#' Get YAML Markup (function-YamlContext.ReactiveReference.S3)
#'
#' @description 
#' See generic: \code{\link[fromyaml]{processYaml}}
#'      
#' @inheritParams processYaml
#' @param from \code{\link{missing}}.
#' @return \code{\link{character}}. Identified YAML markup.
#' @example inst/examples/processYaml.r
#' @seealso \code{
#'    \link[fromyaml]{processYaml},
#'    \link[fromyaml]{getYaml},
#'    \link[fromyaml]{parseYaml},
#'    \link[fromyaml]{buildExpressionFromYaml},
#'    \link[fromyaml]{updateYamlSource}
#' }
#' @template author
#' @template references
#' @aliases processYaml-function-YamlContext.ReactiveReference.S3-method
#' @export
setMethod(
  f = "processYaml", 
  signature = signature(
    from = "function",
    ctx = "YamlContext.ReactiveReference.S3"
  ), 
  definition = function(
    from,
    ctx,
    where,
    ...
  ) {
    
  ## Get //  
  yaml <- getYaml(from = from, ctx = ctx)
    
  ## Parse //
  yaml <- parseYaml(yaml = yaml)
  
  ## Build //
  yaml <- buildExpressionFromYaml(yaml = yaml)
  
  ## Update //
  yaml <- updateYamlSource(yaml = yaml)
  
  return(yaml)
  
  }
)
