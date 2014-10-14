#' @section YAML syntax:
#' 
#' Note that the YAML statement for specifying object references must 
#' be as follows:
#' 
#' \code{object-ref: {id: {id}, where: {where}, as: {id-ref}}}
#' 
#' Note that elements \code{where} and \code{as} are optional and that spaces
#' are required between each syntax component. While the lack of spaces will
#' cause a parsing error in \code{\link[yaml]{yaml.load}}, additional spaces 
#' do not casue any trouble.
#' 
#' Example for valid YAML statements
#' 
#' \itemize{
#'    \item{\code{object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}}}
#'    \item{\code{object-ref: {id: x_1, where: .GlobalEnv}}}
#'    \item{\code{object-ref: {id: x_1}}}
#'    \item{\code{object-ref:  {  id:   x_1, where  : .GlobalEnv, as: ref_1  }}}
#' }
#' 
#' See the official \href{YAML website}{http://www.yaml.org/} for more 
#' details about YAML
