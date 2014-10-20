#' @title
#' Get YAML Markup (generic)
#'
#' @description 
#' Identifies lines that correspond to YAML markup.
#'   	
#' @template yaml-syntax
#'     
#' @param from \strong{Signature argument}.
#'    Object containing YAML markup.
#' @param ctx \strong{Signature argument}.
#'    Markup proecessing context.
#' @param where \code{\link{environment}}.
#'    Environment in which to assign the function in the \code{src} field of 
#'    class \code{\link[yamlr]{ObjectReferenceYaml.S3}}. Only relevant 
#'    in case the YAML has been provided via comments instead of an 
#'    inline string as this involves some additional transformation steps.
#' @template threedots
#' @example inst/examples/getYaml.r
#' @seealso \code{
#'   	\link[yamlr]{getYaml-function-YamlContext.ObjectReference.S3-method}
#' }
#' @template author
#' @template references
setGeneric(
  name = "getYaml",
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
    standardGeneric("getYaml")       
  }
)

#' @title
#' Get YAML Markup (function-YamlContext.ObjectReference.S3)
#'
#' @description 
#' See generic: \code{\link[yamlr]{getYaml}}
#'      
#' @inheritParams getYaml
#' @param from \code{\link{missing}}.
#' @return \code{\link{character}}. Identified YAML markup.
#' @example inst/examples/getYaml.r
#' @seealso \code{
#'    \link[yamlr]{getYaml}
#' }
#' @template author
#' @template references
#' @aliases getYaml-function-YamlContext.ObjectReference.S3-method
#' @export
setMethod(
  f = "getYaml", 
  signature = signature(
    from = "function",
    ctx = "YamlContext.ObjectReference.S3"
  ), 
  definition = function(
    from,
    ctx,
    where,
    ...
  ) {
    
  ## Identification pattern //    
  pattern <- ctx$pattern
  
  ## Store initial form of `from` //
  from_0 <- from
  
  from <- body(from_0)
  in_body <- TRUE  
  
  index <- which(sapply(from, function(from) {
    any(grepl(pattern, from))
  }))
  if (!length(index)) {
    out <- getYamlFromComments(from = from_0, ctx = ctx, where = where)
  } else {
    out <- ObjectReferenceYaml.S3(
      original = unname(sapply(index, function(idx) from[[idx]])),
      index = index,
      src = from_0
    )
  }
  return(out)
  
  }
)
