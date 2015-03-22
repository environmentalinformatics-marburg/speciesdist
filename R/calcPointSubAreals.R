#' Calculates sub areals
#' 
#' Calculates buffers around individual observations to create sub areals for 
#' the individual 
#' 
#' @param points a SpatialPointsDataFrame in a metric coordinate system
#' 
#' @return Spatial polygon containing the sub areals
#' 
#' @details The areals are based on multiple buffer computations to ensure
#' that the required vector length is still allocatable.
#' 
calcPointSubAreals <- function(points){
  buffer_mw <- rgeos::gBuffer(play_points_mw, width = 1000)
  buffer_mw_2 <- rgeos::gBuffer(buffer_mw, width = 10000)
  buffer_mw_3 <- rgeos::gBuffer(buffer_mw_2, width = 100000)
  buffer_mw_4 <- rgeos::gBuffer(buffer_mw_3, width = 100000)
  buffer_mw_union <- rgeos::gUnaryUnion(buffer_mw_4)
  return(list(buffer_mw = buffer_mw, buffer_mw_2 = buffer_mw_2,
              buffer_mw_3 = buffer_mw_3, buffer_mw_4 = buffer_mw_4,
              buffer_mw_union = buffer_mw_union))
}
