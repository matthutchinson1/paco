#' Principle Coordinate analysis of phylogenies
#'
#' 
#' @param D A list with objects H, P, and HP, as returned by prepare_paco_data.
#' @param correction In some cases, phylogenetic distance matrices are non-Euclidean which generates negative eigenvalues when those matrices are translated into Principle Coordinates. There are several methods to correct negative eigenvalues. Correction options available here are ``cailliez'', ``lingoes'', and ``none''. The ``cailliez'' and ``lingoes'' corrections add a constant to the eigenvalues to make them non-negative. Default is 'none'. 
#' @return The list that was input as the argument `D' with two new elements; the Principle Coordinates of the `host' phylogeny and the Principle Coordinates of the `parasite' phylogeny.
#' @note To find the Principle Coordinates of each distance matrix, we internally use a function, coordpcoa, that is a modified version of ape::pcoa, using vegan::eigenvals.
#' @export
#' @examples
#' data(gopherlice)
#' library(ape)
#' gdist <- cophenetic(gophertree)
#' ldist <- cophenetic(licetree)
#' D <- prepare_paco_data(gdist, ldist, gl_links)
#' D <- add_pcoord(D, correction='none')
add_pcoord <- function(D, correction='none')
{
HP_bin <- which(D$HP >0, arr.ind=TRUE)
H_PCo <- coordpcoa(D$H, correction)$vectors #Performs PCo of Host distances
P_PCo <- coordpcoa(D$P, correction)$vectors #Performs PCo of Parasite distances
D$H_PCo <- H_PCo[HP_bin[,1],] #Adjust Host PCo vectors
D$P_PCo <- P_PCo[HP_bin[,2],] #Adjust Parasite PCo vectors
D$correction <- correction
return(D)
}
