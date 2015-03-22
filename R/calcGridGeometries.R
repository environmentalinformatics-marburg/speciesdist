#' Calculates grid lat, lon and area
#'
#' @description
#' Generate three raster layers containing pixels longitude, latitude and
#' area information and save it to disk.
#' 
#' @param grid Raster grid including projection information
#'
#' @return nothing, just save the generated rasters as GeoTiff
#' 
#' @export calcOccurrenceMetrics
#' 
calcGridGeometries <- function(grid){
  lat <- grid
  lat_values <- matrix(rep(seq((raster::extent(lat)@ymax - 1/60*1.25), 
                               raster::extent(lat)@ymin, -1/60*2.5), ncol(lat)),
                       nrow = nrow(lat), ncol = ncol(lat))
  lat <- raster::setValues(lat, lat_values)
  #   plot(lat)
  
  lon <- grid
  lon_values <- matrix(rep(seq((raster::extent(lat)@xmin + 1/60*1.25), 
                               raster::extent(lat)@xmax, 1/60*2.5), nrow(lon)),
                       nrow = nrow(lon), ncol = ncol(lon), byrow = TRUE)
  lon <- raster::setValues(lon, lon_values)
  #   plot(lon)
  
  area_025 <- (2 * pi * 6371 / (360 * 60 / 2.5))**2
  
  area <- grid
  area_values <- area_025 * cos(getValues(lat) * pi / 180)
  area <- raster::setValues(area, area_values)
  #   plot(area)
  
  raster::writeRaster(lat, paste0(datapath_world, "grid_lat.tif"))
  raster::writeRaster(lon, paste0(datapath_world, "grid_lon.tif"))
  raster::writeRaster(area, paste0(datapath_world, "grid_area.tif"))
}
