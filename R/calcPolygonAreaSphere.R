#' Calculate surface of triangular polygons on the earth sphere
#' 
#' Calculates surface of polygons based on spherical coordinates. 
#' 
#' @param spatial_polygon a Spatial polygon* in a spherical coordinate system
#' 
#' @return Data frame containing the area of all sub-polygons.
#' 
calcPolygonAreaSphere <- function(spatial_polygon){
  area_by_id <- calcPolygonAreaSphereByID(spatial_polygon)
  sum(area_by_id$AREA)
}