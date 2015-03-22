#' Calculate individual surface of multiple polygons on a cartographic grid
#' 
#' Calculates surface of polygons based on non-spherical coordinates. 
#' 
#' @param spatial_polygon a Spatial polygon* in a metric coordinate system
#' 
#' @return Data frame containing the area of each sub-polygon and information if
#' this area is for a hole or not.
#' 
calcPolygonAreaByID <- function(spatial_polygon){
  area <- lapply(
    seq(length(spatial_polygon@polygons[[1]]@Polygons)), function(x){
      act_polygon <- spatial_polygon@polygons[[1]]@Polygons[[x]]
      act_polygon <- SpatialPolygons(list(Polygons(list(act_polygon), 
                                                   as.character(x))))
      sp::proj4string(act_polygon) <- sp::proj4string(spatial_polygon)
      areas <- rgeos::gArea(act_polygon)
      data.frame(ID = x,
                 AREA = areas,
                 AREA_REL = areas / (4*pi*6371000**2),
                 HOLE = spatial_polygon@polygons[[1]]@Polygons[[x]]@hole)
    })
  do.call("rbind", area)
}

