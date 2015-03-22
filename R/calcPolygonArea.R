#' Calculate surface of polygons on a cartographic grid
#' 
#' Calculates surface of polygons based on non-spherical coordinates. 
#' 
#' @param spatial_polygon a Spatial polygon* in a metric coordinate system
#' 
#' @return Data frame containing the overall area, the area without holes, 
#' the area of the holes (each information absolute and relative)
#' 
#'
calcPolygonArea <- function(spatial_polygon){
  area_by_id <- calcPolygonAreaByID(spatial_polygon)
  area <- data.frame(SUM = sum(area_by_id$AREA),
                     SUM_AREA = sum(area_by_id$AREA[area_by_id$HOLE == FALSE]),
                     SUM_AREA_REL = 
                       sum(area_by_id$AREA_REL[area_by_id$HOLE == FALSE]),
                     SUM_HOLES = sum(area_by_id$AREA[area_by_id$HOLE == TRUE]),
                     SUM_HOLES_REL = 
                       sum(area_by_id$AREA_REL[area_by_id$HOLE == TRUE]))
}