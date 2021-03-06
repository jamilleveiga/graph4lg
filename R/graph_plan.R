#' Create a graph with a minimum planar graph topology
#'
#' @description The function constructs a graph with a minimum planar
#' graph topology
#'
#' @param crds A \code{data.frame} with the spatial
#' coordinates of the point set (the graph nodes). It must have three columns:
#' \itemize{
#' \item{ID: A character string indicating the name of the points(graph nodes).}
#' \item{x: A numeric or integer indicating the longitude of the graph nodes.}
#' \item{y: A numeric or integer indicating the latitude of the graph nodes.}
#' }
#' @param ID A character string indicating the name of the column
#' of \code{crds} with the point IDs
#' @param x A character string indicating the name of the column
#' of \code{crds} with the point longitude
#' @param y A character string indicating the name of the column
#' of \code{crds} with the point latitude
#' @return A planar graph of class \code{igraph}
#' @export
#' @author P. Savary
#' @details A delaunay triangulation is performed in order to get the
#' planar graph.
#' @examples
#' data(pts_pop_simul)
#' g_plan <- graph_plan(crds = pts_pop_simul,
#'              ID = "ID",
#'              x = "x",
#'              y = "y")



graph_plan <- function(crds, ID = NULL, x = NULL, y = NULL){

  # Check whether 'crds' is a 'data.frame'
  if (inherits(crds, "data.frame")){

    # Check whether 'x' is specified
    if(is.null(x) ) {
      stop("You must specify the name of the 'x' column,
             as an input 'x'")
    }

    # Check whether 'y' is specified
    if(is.null(y) ) {
      stop("You must specify the name of the 'y' column,
             as an input 'y'")
    }

    # Check whether the 'ID' column is specified
    if(is.null(ID) ) {
      stop("You have to specify the name of the ID column of the points in the
           data.frame, as an input 'ID'")
    }

    message("Coordinates were treated as projected coordinates. Check whether
              it is the case.")
  } else {
    stop("'crds' must be of class 'data.frame'.")
  }

  if(!inherits(crds[, x], c("numeric", "integer"))){
    stop("'x' must be of class 'numeric' or 'integer'")
  } else if(!inherits(crds[, y], c("numeric", "integer"))){
    stop("'y' must be of class 'numeric' or 'integer'")
  } else {
    crds$ID <- as.character(crds$ID)
  }

  # Reorder and rename columns of crds
  crds <- crds[, c(ID, x, y)]
  colnames(crds) <- c("ID", "x", "y")

  # Compute the delaunay network with spatstat package
  pts_ppp <- spatstat::ppp(x = crds$x, y = crds$y, marks = crds$ID,
                           xrange = c(min(crds$x), max(crds$x)),
                           yrange = c(min(crds$y), max(crds$y)))

  res_plan <- spatstat::delaunayNetwork(pts_ppp)

  # Get the adjacency matrix
  mat_plan <- as.matrix(res_plan$m)
  mat_plan <- ifelse(mat_plan, 1, 0)
  row.names(mat_plan) <- colnames(mat_plan) <- crds$ID

  # Compute the planar graph
  g <- gen_graph_topo(mat_w = mat_plan,
                      mat_topo = mat_plan,
                      topo = "comp")

  return(g)
}
