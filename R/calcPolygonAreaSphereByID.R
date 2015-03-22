#' Calculate surface of multiple triangular polygons on the earth sphere
#' 
#' Calculates surface of polygons based on spherical coordinates. 
#' 
#' @param spatial_polygon a Spatial polygon* in a spherical coordinate system
#' 
#' @return Data frame containing the area of each sub-polygons.
calcPolygonAreaSphereByID <- function(spatial_polygon){
  area <- lapply(
    seq(length(spatial_polygon@polygons[[1]]@Polygons)), function(x){
      act_polygon <- spatial_polygon@polygons[[1]]@Polygons[[x]]
      act_polygon <- SpatialPolygons(list(Polygons(list(act_polygon), 
                                                   as.character(x))))
      sp::proj4string(act_polygon) <- sp::proj4string(spatial_polygon)
      act_area <- geosphere::areaPolygon(act_polygon)
      data.frame(ID = x,
                 AREA = act_area)
    })
  do.call("rbind", area)
}