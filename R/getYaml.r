#' @title
#' Get YAML Markup (generic)
#'
#' @description 
#' Identifies lines that correspond to YAML markup.
#'   	
#' @param from \strong{Signature argument}.
#'    Object containing YAML markup.
#' @param ctx \strong{Signature argument}.
#'    Markup proecessing context.
#' @template threedots
#' @example inst/examples/getYaml.r
#' @seealso \code{
#'   	\link[fromyaml]{getYaml-function-YamlContext.ReactiveReference.S3-method}
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
    ...
  ) {
    standardGeneric("getYaml")       
  }
)

#' @title
#' Get YAML Markup (function-YamlContext.ReactiveReference.S3)
#'
#' @description 
#' See generic: \code{\link[fromyaml]{getYaml}}
#'      
#' @inheritParams getYaml
#' @param from \code{\link{missing}}.
#' @return \code{\link{character}}. Identified YAML markup.
#' @example inst/examples/getYaml.r
#' @seealso \code{
#'    \link[fromyaml]{getYaml}
#' }
#' @template author
#' @template references
#' @aliases getYaml-function-YamlContext.ReactiveReference.S3-method
#' @export
setMethod(
  f = "getYaml", 
  signature = signature(
    from = "function",
    ctx = "YamlContext.ReactiveReference.S3"
  ), 
  definition = function(
    from,
    ctx,
    ...
  ) {
    
  ## Identification pattern //    
  pattern <- ".*reactive-ref:\\s?\\{\\s?id\\s?:\\s?\\w+.*\\}"
  
  ## Store initial form of `from` //
  from_0 <- from
  
  from <- body(from_0)
  in_body <- TRUE  
  
  index <- which(sapply(from, function(from) {
    any(grepl(pattern, from))
  }))
  if (!length(index)) {
    ## Try if YAML was specified as comment //
    code <- capture.output(from_0)
    index <- which(sapply(code, function(from) {
      any(grepl(pattern, from))
    }))
    if (length(index)) {
      ## Transform expression //
      code[index] <- paste0("\"", gsub("\\s*#\\s*", "", code[index]), "\"")
      from_0 <- eval(parse(text = code)[[1]])
      environment(from_0) <- where
      from <- body(from_0)
      index <- which(sapply(from, function(from) {
        any(grepl(pattern, from))
      }))
      in_body <- TRUE
    }
  }
  if (length(index)) {
    ReactiveReferenceYaml.S3(
      yaml = sapply(index, function(idx) from[[idx]]),
      index = index,
      src = from_0
    )
  } else {
    ReactiveReferenceYaml.S3()
  }
  
  }
)
