% Generated by roxygen2 (4.0.2): do not edit by hand
\name{buildExpressionFromYaml}
\alias{buildExpressionFromYaml}
\title{Build Expression Based on YAML Markup (generic)}
\usage{
buildExpressionFromYaml(yaml, where = parent.frame(), ...)
}
\arguments{
\item{yaml}{\strong{Signature argument}.
Object containing parsed YAML markup as returned by
\code{\link[yamlr]{parseYaml}}.}

\item{where}{\code{\link{environment}}.
Environment in which to assign the function in the \code{src} field of
class \code{\link[yamlr]{ObjectReferenceYaml.S3}}. Only relevant
in case the YAML has been provided via comments instead of an
inline string as this involves some additional transformation steps.}

\item{...}{Further arguments to be passed to subsequent functions/methods.}
}
\description{
Builds expression(s) based on the YAML markup as identified by
\code{\link[yamlr]{getYaml}} and parsed by \code{\link[yamlr]{parseYaml}}.
}
\details{
Expressions that should be executed in order to validate certain aspects can
be put into a parsed reference's \code{expr} environment at subenvironment
\code{"validate"} (i.e. \code{{parse-yaml}${id}$expr$validate}).
That way, at any given time, one could simply execute all expressions in
that environment in order to validate if all prerequisites are met
(for example "check if the specified reference actually exists and throw
an error if it doesn't").

See method \code{\link[yamlr]{buildExpressionFromYaml-ObjectReferenceYamlParsed.S3-method}}
for an example for this
}
\section{YAML syntax}{


Note that the YAML statement for specifying object references must
be as follows:

\code{object-ref: {id: {id}, where: {where}, as: {id-ref}}}

Note that elements \code{where} and \code{as} are optional and that spaces
are required between each syntax component. While the lack of spaces will
cause a parsing error in \code{\link[yaml]{yaml.load}}, additional spaces
do not casue any trouble.

Example for valid YAML statements

\itemize{
   \item{\code{object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}}}
   \item{\code{object-ref: {id: x_1, where: .GlobalEnv}}}
   \item{\code{object-ref: {id: x_1}}}
   \item{\code{object-ref:  {  id:   x_1, where  : .GlobalEnv, as: ref_1  }}}
}

See the official \href{YAML website}{http://www.yaml.org/} for more
details about YAML
}
\examples{
\dontrun{

## Get //  
yaml <- getYaml(
  from = function() {
  "object-ref: {id: x_1, where: .GlobalEnv, as: ref_1}"
  },
  ctx = YamlContext.ObjectReference.S3()
)

## Parse //
yaml <- parseYaml(yaml = yaml)

## Build //
yaml <- buildExpressionFromYaml(yaml = yaml)

## Two ways of accessing expressions //
## 1) Via 'parsed':
ls(yaml$parsed$x_1$expr)
yaml$parsed$x_1$expr$exists
yaml$parsed$x_1$expr$validate
yaml$parsed$x_1$expr$get_assign

## 2) Via 'expr':
ls(yaml$expr$x_1)
yaml$expr$x_1$exists
yaml$expr$x_1$validate
yaml$expr$x_1$get_assign

## NOTE
## The environment in `expr${id}` corresponds to the environment 
## in `parsed${id}$expr. So expressions are not actually stored redundantly
## as environments implement a "pass-by-referenc" instead of the otherwise
## typical "pass-by-value" paradigm. 
## Environment `expr` simply exists as a shorthand for accessing expressions

## Example of expression execution //
## Validity checks:
suppressWarnings(rm(x_1))
eval(yaml$parsed$x_1$expr$exists)
eval(yaml$parsed$x_1$expr$validate)
x_1 <- 10
eval(yaml$parsed$x_1$expr$exists)
eval(yaml$parsed$x_1$expr$validate)

## The line that contained the YAML markup in 'from' above will be substituted
## by this expression 
eval(yaml$parsed$x_1$expr$get_assign)
ref_1

}
}
\author{
Janko Thyson \email{janko.thyson@rappster.de}
}
\references{
\url{http://github.com/Rappster/yamlr}
}
\seealso{
\code{
  	\link[yamlr]{buildExpressionFromYaml-ObjectReferenceYamlParsed.S3-method}
}
}

