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
#' @param strict \code{\link{logical}}.
#'    \code{TRUE}: error if no YAML markup could be identified (which in turn
#'    results in field \code{original} in class 
#'    \code{\link[yamlr]{ObjectReferencedYaml.S3}} being empty);
#'    \code{FALSE}: no error if no YAML markup could be identified.
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
    strict = FALSE,
    ...
  ) {
    standardGeneric("getYaml")       
  }
)

#' @title
#' Get YAML Markup (ANY-YamlContext.ObjectReference.S3)
#'
#' @description 
#' See generic: \code{\link[yamlr]{getYaml}}
#'      
#' @inheritParams getYaml
#' @param from \code{\link{ANY}}.
#' @param ctx \code{\link{YamlContext.ObjectReference.S3}}.
#' @return \code{\link{character}}. Identified YAML markup.
#' @example inst/examples/getYaml.r
#' @seealso \code{
#'    \link[yamlr]{getYaml}
#' }
#' @template author
#' @template references
#' @aliases getYaml-ANY-YamlContext.ObjectReference.S3-method
#' @export
setMethod(
  f = "getYaml", 
  signature = signature(
    from = "ANY",
    ctx = "YamlContext.ObjectReference.S3"
  ), 
  definition = function(
    from,
    ctx,
    where,
    strict,
    ...
  ) {
    
  from <- captureExpression(expr = from)
  getYaml(
    from = from,
    ctx = ctx,
    where = where,
    strict = strict,
    ...
  )
  
  }
)

#' @title
#' Get YAML Markup (function-YamlContext.ObjectReference.S3)
#'
#' @description 
#' See generic: \code{\link[yamlr]{getYaml}}
#'      
#' @inheritParams getYaml
#' @param from \code{\link{function}}.
#' @param ctx \code{\link{YamlContext.ObjectReference.S3}}.
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
    strict,
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
  
  if (is.null(out$src)) {
    out$src <- from_0
  }
  
  if (strict && !length(out$original)) {
    msg <- c(
      "No YAML markup found in:",
      paste(capture.output(from_0), collapse = "\n")
    )
    stop(paste(msg, collapse = "\n"))
  }
  
  return(out)
  
  }
)

#' @title
#' Get YAML Markup (curlybracket-YamlContext.ObjectReference.S3)
#'
#' @description 
#' See generic: \code{\link[yamlr]{getYaml}}
#'      
#' @inheritParams getYaml
#' @param from \code{\link{{}}}.
#' @param ctx \code{\link{YamlContext.ObjectReference.S3}}.
#' @return \code{\link{character}}. Identified YAML markup.
#' @example inst/examples/getYaml.r
#' @seealso \code{
#'    \link[yamlr]{getYaml}
#' }
#' @template author
#' @template references
#' @name getYaml-brackets
#' @aliases getYaml-curlybracket-YamlContext.ObjectReference.S3-method
#' @export

setMethod(
  f = "getYaml", 
  signature = signature(
    from = "{",
    ctx = "YamlContext.ObjectReference.S3"
  ), 
  definition = function(
    from,
    ctx,
    where,
    strict,
    ...
  ) {
    
  ## Identification pattern //    
  pattern <- ctx$pattern
  
  ## Store initial form of `from` //
  from_0 <- from
  
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
  
  if (is.null(out$src)) {
    out$src <- from_0
  }
  
  if (strict && !length(out$original)) {
    msg <- c(
      "No YAML markup found in:",
      paste(capture.output(from_0), collapse = "\n")
    )
    stop(paste(msg, collapse = "\n"))
  }
  
  return(out)
  
  }
)

