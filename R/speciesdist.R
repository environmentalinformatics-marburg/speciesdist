#' Species distribution
#'
#' @description
#' Methods for analysing species distributions on a global scale
#' 
#' @details The package provides usefull functions for species analysis on a
#' global scale.
#' 
#' @name speciesdist
#' 
NULL

# Function for processing data (just as test) ----------------------------------
#' 
#' @export speciesdist
#' @rdname speciesdist
#' 
speciesdist <- function(){
  library(data.table)

  inpath <- "D:/active/juergen/"
  datapath <- paste0(inpath, "data/")
  datapath_gbif <- paste0(datapath, "gbif/")
  datapath_rdata <- paste0(datapath, "rdata/")
  
# Read GBIF for the first time -------------------------------------------------
# Split GBIF into chunks and load them into a data.table afterwards.
# Splitting is done because there was an error once regarding the correct column
# numbers.
infile <- paste0(datapath_gbif, "gbif_PTERIDOPHYTA.txt")
  splitLTF(infile, sep = "\t")
  
  infiles <- list.files(datapath_gbif, pattern = glob2rx("gbif_chunk*.txt"),
                        full.names = TRUE)
  relevant_cols <- c(1, 63, 70, 71, 72, 78, 79, 93, 100, 157, 164, 173, 182, 
                     210, 213, 214, 215, 216, 217, 218, 219, 220)
  gbif <- readLTF(infiles, sep = "\t", rlvt_cols = relevant_cols)  
  
  for(i in seq(40)){
    print(dim(gbif[[i]]))
  }
  
  save(gbif, file = paste0(datapath_rdata, "gibf_01_initial_input.Rdata"))


# Clean data set ---------------------------------------------------------------

  
  preprocess <- FALSE
  
  modulepath <- paste0(inpath, "scripts/specdist/src/")
  # datapath_processed <- paste0(datapath, "processed/")
  # datapath_climate <- paste0(datapath, "climate/")
  # datapath_world <- paste0(datapath, "world/")
  
  src <- list.files(modulepath, full.name = TRUE)
  src <- src[-grep("src/specdist.R", src)]
  sapply(src, function(x){source(x)})
  

  library(countrycode)
  library(maps)
  library(maptools)
  library(geosphere)
  library(raster)
  library(rgdal)
  library(rgeos)
  library(sp)
  
  
  # Preprocessing of GBIF and other data -----------------------------------------
}

