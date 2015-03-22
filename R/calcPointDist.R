#' Calculates distance between points on a sphere
#'
#' @description
#' Calculates distance between points using distVincentyEllipsoid method
#' 
#' @param points Spatial points object
#'
#' @return Table containing the distances between each points in meter.
#'
#' @export calcPointDist
#' 
calcPointDist <- function (points){
  points <- as.data.frame(points)
  id_pos <- grep("ID", names(points))
  lon_pos <- grep("x", names(points))
  lat_pos <- grep("y", names(points))
  dist <- table(points[ ,id_pos], points[ ,id_pos])
  for (i in 1:(nrow(points)-1)){
    for (k in i:nrow(points)){
      dist[i,k] <- geosphere::distVincentyEllipsoid(
        points[i,lon_pos:lat_pos], points[k,lon_pos:lat_pos])
      dist[k,i] <- dist[i,k]
    }
  }
  return (dist)
}
