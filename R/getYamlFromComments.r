#' @title
#' Get YAML Markup From Comments (generic)
#'
#' @description 
#' Identifies lines that correspond to YAML markup in comments.
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
#' @example inst/examples/getYamlFromComments.r
#' @seealso \code{
#'   	\link[yamlr]{getYamlFromComments-function-YamlContext.ObjectReference.S3-method},
#'     \link[yamlr]{getYaml}
#' }
#' @template author
#' @template references
setGeneric(
  name = "getYamlFromComments",
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
    standardGeneric("getYamlFromComments")       
  }
)

#' @title
#' Get YAML Markup From Comments (function-YamlContext.ObjectReference.S3)
#'
#' @description 
#' See generic: \code{\link[yamlr]{getYamlFromComments}}
#'      
#' @inheritParams getYamlFromComments
#' @param from \code{\link{missing}}.
#' @return \code{\link{character}}. Identified YAML markup.
#' @example inst/examples/getYamlFromComments.r
#' @seealso \code{
#'    \link[yamlr]{getYamlFromComments},
#'     \link[yamlr]{getYaml}
#' }
#' @template author
#' @template references
#' @aliases getYamlFromComments-function-YamlContext.ObjectReference.S3-method
#' @export
setMethod(
  f = "getYamlFromComments", 
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
  
  ## Try if YAML was specified as comment //
  bdy <- body(from)
# print(bdy)
# print(class(bdy))
  has_curly <- if (class(bdy) == "{") {
    TRUE
  } else {
    FALSE
  }
  from_env <- environment(from)
  code <- capture.output(from)
  
  ## Remove empty lines //
  idx_empty <- grep("^\\s+$", code)
  if (length(idx_empty)) {
    code <- code[-idx_empty]
  }
  
  ## Catch function environment //
  idx_env <- grep("<environment:", code)
  if (length(idx_env)) {
    code <- code[-idx_env]
  }
# print(code)  
  index <- which(sapply(code, function(from) {
    any(grepl(pattern, from))
  }))
  if (length(index)) {
    ## Transform expression //
    ## Remove trailing curly bracket //
    if (has_curly) {
      if (grepl("^\\}|[^\\w]\\s?\\}$", code[length(code)], perl = TRUE)) {
      ## Last line only contains whitespace and `}` //
        ## --> very important to check for *both* patterns!!!
        code <- code[-length(code)]
      } else {
      ## Last line only contains actual code and `}` at end //        
        code[length(code)] <- gsub("}", "", code[length(code)])
      }
    }
    code[index] <- paste0("\"", gsub("\\s*#\\s*", "", code[index]), "\"") 
    expr_char <- paste(c("quote({", paste(rep("NULL", length(code[-1]))), "})"),
                       collapse = "\n")
# print(code)    
    ## Create dummy function whose body is filled //
    tmp <- function() expr
    body(tmp) <- eval(parse(text = expr_char))
    ## Fill body and remove NULL //
    is_null <- NULL
    for(ii in seq(along = code[-1])) {
      expr_this <- parse(text = code[-1][[ii]])
      if (length(expr_this)) {
         body(tmp)[[ii+1]] <- substitute(
          CODE, 
          list(CODE = expr_this[[1]])
        )
      } else {
        is_null <- unique(c(is_null, ii))
      }
    }
    is_null <- is_null + 1
    if (length(is_null)) {
      body(tmp)[is_null] <- NULL  
    }
    
    ## Pass arguments along //
    formals(tmp) <- formals(from)
    
    ## Rename and function environment //
    from_0 <- tmp
#     environment(from_0) <- where
    environment(from_0) <- from_env
    from <- body(from_0)
    
    ## Regular function now --> grep pattern like above //
    index <- which(sapply(from, function(from) {
      any(grepl(pattern, from))
    }))
    in_body <- TRUE
  }
  
  if (length(index)) {
    ObjectReferenceYaml.S3(
      original = unname(sapply(index, function(idx) from[[idx]])),
      index = index,
      src = from_0
    )
  } else {
    ObjectReferenceYaml.S3()
  }
  
  }
)
