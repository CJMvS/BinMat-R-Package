#' @title Creates a non-metric multidimensional scaling plot (nMDS).
#'
#' @description Creates an nMDS plot from a consolidated binary matrix with grouping information.
#'
#' @param x Consolidated binary matrix with grouping information in the second column.
#' @param dist_meth Distance method. Set to "binary" by default. Other options are "euclidean", "maximum", "manhattan", "canberra", or "minkowski".
#' @param k_val Number of dimensions for the nMDS plot.
#' @param pt_size Point size for symbols on the plot.
#' @param colours Vector containing colours to be assigned to groups.
#' @param shapes Vector containing pch values for shapes to be used for points.
#' @param labs Indicate whether labels should appear on the graph or not (T or F). Default = F.
#' @return nMDS plot.
#'
#' @examples  mat = BinMatInput_ordination
#' group_names(mat)
#' clrs = c("red", "green", "black")
#' shp = c(16,16,16)
#' nmds(mat, colours = clrs, shapes = shp, labs = TRUE)
#'
#' @export

nmds = function(x, dist_meth = "binary", k_val = 2, pt_size = 1, colours, shapes, labs = F){

  row.names(x) <- x[[1]] # make the sample names rownames,
  x[,1] <- NULL # and then remove the sample name column

  # make the names shorter (here, only 10 characters long)
  newnames =substring(row.names(x), 0, 50)
  row.names(x) = newnames
  x[x =="?"] <- NA

  x = as.data.frame(x)

  d = stats::dist((x[,2:ncol(x)]), method = dist_meth, diag = TRUE, upper = T)
  d = as.data.frame(as.matrix(d))
  d2 = stats::as.dist(d)
  d2 = d2 + 0.01 # adding 0.01 here to cover for cases where there are identical sequences, leading to zero distances. Zero distances give the error "Warning: Error in isoMDS: zero or negative distance between objects x and y"

  isoplot = MASS::isoMDS(d2, k = k_val)
  fac = as.factor(x[,1])

  nmds = MASS::eqscplot(isoplot$points, xlab = "Dimension 1", ylab = "Dimension 2", col = colours[fac], pch = shapes[fac], cex = pt_size)

  if(labs == T)
    graphics::text(isoplot$points, labels = row.names(x), cex = 1, pos= 4)

  return(nmds)

}