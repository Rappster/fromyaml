#' @title
#' Parse YAML Markup (generic)
#'
#' @description 
#' Parses YAML markup as identified by \code{\link[fromyaml]{getYaml}}.
#'   	
#' @param yaml \strong{Signature argument}.
#'    Object containing identified YAML markup as returned by 
#'    \code{\link[fromyaml]{getYaml}}.
#' @template threedots
#' @example inst/examples/parseYaml.r
#' @seealso \code{
#'   	\link[fromyaml]{parseYaml-function-ReactiveReferenceYamlContext.S3-method}
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
        
  nms <- vector("character", length(yaml$yaml))
  parsed <- lapply(seq(along=yaml$yaml), function(ii) {
    parsed <- yaml::yaml.load(yaml$yaml[ii])[[1]]
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
    parsed
  })
  names(parsed) <- nms
  out <- fromyaml::ReactiveReferenceYamlParsed.S3(
    yaml = yaml$yaml,
    yaml_parsed = parsed,
    index = yaml$index,
    src = yaml$src
  )
  return(out)
  
  }
)
