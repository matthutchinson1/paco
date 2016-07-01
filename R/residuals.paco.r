#' Get procrustes residuals from a paco object
#' @param object a list with the data
#' @param type whether the whole residual matrix (\code{matrix}) or the residuals per interaction (\code{interaction}) is desired
#' @return a data frame of raw residuals from the Procrustean superimposition
#' @export
#' @examples
#' data(gopherlice)
#' library(ape)
#' gdist <- cophenetic(gophertree)
#' ldist <- cophenetic(licetree)
#' D <- prepare_paco_data(gdist, ldist, gl_links)
#' D <- add_pcoord(D, correction='cailliez')
#' D <- PACo(D, nperm=100, seed=42, method='r0', correction='cailliez')
#' residuals.paco(D$proc)
residuals_paco <- function (object, type = "interaction") {
  type <- match.arg(type, c("matrix", "interaction"))

  distance <- object$X - object$Yrot
  rownames(distance) <- paste(rownames(object$X), rownames(object$Yrot), sep="-") #colnames identify the H-P link

  if (type == "matrix") {
    return (distance)
  } else if (type == "interaction") {
    resid <- apply(distance^2, 1, sum)
    resid <- sqrt(resid)
    return (resid)
  } else {
    stop("Invalid residual type")
  }
}