#' Calculate metrics for species occurence
#'
#' @description
#' Calculate metrics for species occurence
#' 
#' @param species_polygon Spatial polygon containing information about a single
#' species
#'
#' @return List object containing subareals and centroids as spatial objects and
#' a variety of metrics.
#'
#' @export calcOccurrenceMetrics
#'
calcOccurrenceMetrics <- function(species_polygon){
  if(grepl("proj=moll", sp::proj4string(play_points_mw)) == FALSE){
    species_polygon <- spTransform(species_polygon, CRS("+init=EPSG:4326"))
  }
  subareals <- calcPointSubAreals(species_polygon)
  subareas <- calcPolygonAreaByID(subareals$buffer_mw_union)
  area <- calcPolygonArea(subareals$buffer_mw_union)
  centroids <- calcPolygonCentroids(subareals$buffer_mw_union)
  centroids_latlon <- sp::spTransform(centroids, CRS("+init=EPSG:4326"))
  centroids_dist <- calcPointDist(centroids_latlon[centroids_latlon$HOLE == 0,])
  
  subareals_metrics <- lapply(seq(length(subareals)), function(x){
    return(data.frame(ID = names(subareals[x]),
                      SUBAEREALS = 
                        length(subareals[[x]]@polygons[[1]]@Polygons),
                      SUBAEREALS_REL = 
                        length(subareals[[x]]@polygons[[1]]@Polygons) /
                        length(subareals[[1]]@polygons[[1]]@Polygons)))
  })
  
  list(data = list(subareals = subareals, centroids = centroids),
       metrics =   list(subareals_metrics = subareals_metrics,
                        subarea_metrics = subareas,
                        area_metrics = area,
                        centroids_metrics = centroids_dist))
}

