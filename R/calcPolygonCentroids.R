#' Calculate centroids of polygons
#'
#' @description
#' Calculate centroids of polygons.
#' 
#' @param spatial_polygon Spatial polygon
#'
#' @return Spatial.Polygon* object
#'
#' @export calcPolygonCentroids
#' 
calcPolygonCentroids <- function(spatial_polygon){
  if(class(spatial_polygon) == "SpatialPolygonsDataFrame"){
    return(rgeos::gCentroid(spatial_polygon, byid =TRUE, 
                     id =as.character(spatial_polygon@data[,1])))
  } else {
    np <- length(spatial_polygon@polygons[[1]]@Polygons)
    centroids <- lapply(seq(np), function(x){
      act_polygon <- spatial_polygon@polygons[[1]]@Polygons[[x]]
      act_polygon <- sp::SpatialPolygons(list(Polygons(list(act_polygon), 
                                                   as.character(x))))
      sp::proj4string(act_polygon) <- sp::proj4string(spatial_polygon)
      data.frame(ID = x,
                 HOLE = spatial_polygon@polygons[[1]]@Polygons[[x]]@hole,
                 Centroid = rgeos::gCentroid(act_polygon))
    })
    centroids <- do.call("rbind", centroids)
    return(SpatialPointsDataFrame(centroids[, 3:4], 
                                  data.frame(centroids[, -(3:4)]),
                                  proj4string = 
                                    CRS(proj4string(spatial_polygon))))
  }
}