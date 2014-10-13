#' @title
#' Parse YAML Markup (generic)
#'
#' @description 
#' Parses YAML markup as identified by \code{\link[yamlr]{getYaml}}.
#'   	
#' @param yaml \strong{Signature argument}.
#'    Object containing identified YAML markup as returned by 
#'    \code{\link[yamlr]{getYaml}}.
#' @template threedots
#' @example inst/examples/parseYaml.r
#' @seealso \code{
#'   	\link[yamlr]{parseYaml-function-YamlContext.ReactiveReference.S3-method}
#' }
#' @template author
#' @template references
setGeneric(
  name = "parseYaml",
  signature = c(
    "yaml"
  ),
  def = function(
    yaml,
    ...
  ) {
    standardGeneric("parseYaml")       
  }
)

#' @title
#' Parse YAML Markup (ReactiveReferenceYaml.S3)
#'
#' @description 
#' See generic: \code{\link[yamlyaml]{parseYaml}}
#'      
#' @inheritParams parseYaml
#' @param yaml \code{\link{ReactiveReferenceYaml.S3}}.
#' @return \code{\link{ReactiveReferenceYamlParsed.S3}}. 
#'    Parsed YAML markup.
#' @example inst/examples/parseYaml.r
#' @seealso \code{
#'    \link[yamlyaml]{parseYaml}
#' }
#' @template author
#' @template references
#' @export
#' @import yaml
#' @aliases parseYaml-ReactiveReferenceYaml.S3-method
setMethod(
  f = "parseYaml", 
  signature = signature(
    yaml = "ReactiveReferenceYaml.S3"
  ), 
  definition = function(
    yaml,
    ...
  ) {
        
  nms <- vector("character", length(yaml$original))
  parsed <- lapply(seq(along=yaml$original), function(ii) {
    parsed <- yaml::yaml.load(yaml$original[ii])[[1]]
    if (is.null(parsed$where)) {
      parsed$where <- as.name("where")
    } else {
      parsed$where <- as.name(parsed$where)
    }
    if (is.null(parsed$as)) {
      parsed$as <- as.name(parsed$id)
    } else {
      parsed$as <- as.name(parsed$as)
    }
    nms[[ii]] <<- parsed$id
    parsed$index <- yaml$index[ii]
    parsed$expr <- new.env(parent = emptyenv())
    parsed
  })
  names(parsed) <- nms
  out <- yamlr::ReactiveReferenceYamlParsed.S3(
    original = yaml$original,
    parsed = parsed,
    index = yaml$index,
    src = yaml$src
  )
  return(out)
  
  }
)
