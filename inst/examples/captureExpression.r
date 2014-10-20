\dontrun{

## Expression wrapped in curly brackets //  
res <- captureExpression({
  "object-ref: {id: x_1}"
  x_2 * 2
})
res
class(res)
inherits(res, "call")

## Expression w/o curly brackets //
res <- captureExpression(x_2 * 2)
res
class(res)

res <- captureExpression(x_2 * 2, brackets = FALSE)
res
class(res)

## Character //
res <- captureExpression("object-ref: {id: x_1}")
res
class(res)

res <- captureExpression("object-ref: {id: x_1}", brackets = FALSE)
res
class(res)

}
