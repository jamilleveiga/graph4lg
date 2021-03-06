% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/graphab_to_igraph.R
\name{graphab_to_igraph}
\alias{graphab_to_igraph}
\title{Import landscape graphs from GRAPHAB software}
\usage{
graphab_to_igraph(
  dir_path,
  nodes = "patches",
  links,
  weight = "cost",
  fig = FALSE,
  crds = FALSE
)
}
\arguments{
\item{dir_path}{A character string indicating the path of the GRAPHAB project
directory. This directory normally contains several spatial layer files
in format .shp:
\itemize{
\item{the spatial layer of the habitat patches corresponding to the
nodes of the graph (usually named 'patches.shp').}
\item{(alternatively) an exported spatial layer of
the nodes (faster option).}
\item{the link spatial layer file used to import the graph.}
}}

\item{nodes}{A character string indicating the names of the node spatial
layer in format .shp (without extension, ex.: "nodes"
refers to "nodes.shp" layer).
This layer has been created with GRAPHAB and has therefore coordinates
in a projected coordinates reference system.
Default: nodes = "patches", referring to the spatial polygon layer of the
habitat patches.}

\item{links}{A character string indicating the name of the link spatial layer
in format .shp (without extension, ex.: "link_graph" refers to
"link_graph.shp" layer).
This layer has been created with GRAPHAB and has therefore coordinates
in a projected coordinates reference system. It includes in the attribute
tables between patches Euclidean as well as cost-distance. These
distances are used to weight the link.}

\item{weight}{A character string ("euc" or "cost") indicating
whether to weight
the links with Euclidean distance or cost-distance (default) values.}

\item{fig}{Logical (default = FALSE) indicating whether to plot a figure of
the resulting spatial graph. The figure is plotted using function
\code{\link{plot_graph_lg}}. The plotting can be long if the graph has many
nodes and links.}

\item{crds}{Logical (default = FALSE) indicating whether to create an object
of class \code{data.frame} with the nodes spatial coordinates. Such a
\code{data.frame} has 3 columns: 'ID', 'x', 'y'.}
}
\value{
A graph object of class \code{igraph} (if crds = FALSE) or a
list of objects: a graph object of class \code{igraph} and a
\code{data.frame} with the nodes spatial coordinates (if crds = TRUE).
}
\description{
The function imports a landscape graph created with GRAPHAB
software and converts it into a graph object of class \code{igraph}.
The graph has weighted links and is undirected.
Nodes have spatial coordinates. Other nodes attributes can be included.
It takes shapefiles layers created with GRAPHAB as input.
}
\details{
Nodes attributes can be added to the graph using the
function \code{add_nodes_attr}.
}
\examples{
path <- system.file('extdata',package='graph4lg')
links <- "liens_rast2_1_11_01_19-links"
graph <- graphab_to_igraph(dir_path = path,
                           links = links,
                           fig = FALSE)
}
\references{
\insertRef{foltete2012software}{graph4lg}
}
\author{
P. Savary
}
