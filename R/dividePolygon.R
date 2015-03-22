#' Divide spatial polygon into triangles
#'
#' @description
#' Divide spatial polygon into triangles.
#' 
#' @param spatial_polygon SpatialPolygon* object
#'
#' @return SpatialPolygon* object
#'
#' @export dividePolygon
#'
dividePolygon <- function(spatial_polygon){
  coords <- spatial_polygon@polygons[[1]]@Polygons[[1]]@coords
  
  coords_new <- lapply(seq(nrow(coords)-3), function(x){
    sp::Polygons(list(Polygon(coords[c(1, x+1, x+2, nrow(coords)), ])), 
             as.character(x))
  })
  spatial_polygon_mp <- sp::SpatialPolygons(coords_new)
  sp::proj4string(spatial_polygon_mp) <- sp::proj4string(spatial_polygon)
  return(spatial_polygon_mp)
}