## ----, echo=FALSE--------------------------------------------------------
library(data.table)

inpath <- "D:/active/juergen/"
datapath <- paste0(inpath, "data/")
datapath_gbif <- paste0(datapath, "gbif/")
datapath_rdata <- paste0(datapath, "rdata/")

load(paste0(datapath_rdata, "gibf_01_initial_input.Rdata"))

## ----, eval=FALSE--------------------------------------------------------
#  # Read GBIF for the first time -------------------------------------------------
#  # Split GBIF into chunks and load them into a data.table afterwards.
#  # Splitting is done because there was an error once regarding the correct column
#  # numbers. Only columns given by relevant_cols will be processed during the
#  # final import.
#  infile <- paste0(datapath_gbif, "gbif_PTERIDOPHYTA.txt")
#    splitLTF(infile, sep = "\t")
#  
#    infiles <- list.files(datapath_gbif, pattern = glob2rx("gbif_chunk*.txt"),
#                          full.names = TRUE)
#    relevant_cols <- c(1, 63, 70, 71, 72, 78, 79, 93, 100, 157, 164, 173, 182,
#                       210, 213, 214, 215, 216, 217, 218, 219, 220)
#    gbif <- readLTF(infiles, sep = "\t", rlvt_cols = relevant_cols)
#  
#    for(i in seq(40)){
#      print(dim(gbif[[i]]))
#    }
#  
#    gbif <- gbif[-1,]
#    save(gbif, file = paste0(datapath_rdata, "gibf_01_initial_input.Rdata"))

## ------------------------------------------------------------------------
cell_empty <- sapply(names(gbif), function(x){
  gbif[, length(which(gbif[[x]] == "cempty"))]
  })
cell_empty

## ------------------------------------------------------------------------
cell_na <- sapply(names(gbif), function(x){
  gbif[, length(which(is.na(gbif[[x]])))]
  })
cell_na

## ------------------------------------------------------------------------
gbif[which(is.na(countryCode)), 1:7, with = FALSE]

## ------------------------------------------------------------------------
for (i in seq_len(ncol(gbif))){
  set(gbif, i = which(gbif[[i]]== "cempty"), j = i, value = NA)
  }
cell_na <- sapply(names(gbif), function(x){
  gbif[, length(which(is.na(gbif[[x]])))]
  })
cell_na

## ------------------------------------------------------------------------
head(gbif)

## ------------------------------------------------------------------------
for(i in c("gbifID", "decimalLatitude", "decimalLongitude")){
  set(gbif, j = i, value = as.numeric(gbif[[i]]))
  }
summary(gbif[, c("gbifID", "decimalLatitude", "decimalLongitude"), 
             with = FALSE])

## ----, eval=FALSE--------------------------------------------------------
#  save(gbif, file = paste0(datapath_rdata, "gibf_02_cleaned_input.Rdata"))

## ------------------------------------------------------------------------
total <- nrow(gbif)

either <- gbif[, length(which(!is.na(countryCode) | !is.na(decimalLatitude) |
                              !is.na(county)))]

ctry_only <- 
  gbif[, length(which(!is.na(countryCode) & is.na(decimalLatitude) & 
                        is.na(county)))]
  
coord_only <- 
  gbif[, length(which(is.na(countryCode) & !is.na(decimalLatitude) & 
                        is.na(county)))]

cnty_only <- 
  gbif[, length(which(is.na(countryCode) & is.na(decimalLatitude) & 
                        !is.na(county)))]

ctry_and_coord <- 
  gbif[, length(which(!is.na(countryCode) & !is.na(decimalLatitude)))]

cnty_and_coord <- 
  gbif[, length(which(is.na(countryCode) & !is.na(decimalLatitude) & 
                        !is.na(county)))]

ctry_and_cnty <- 
  gbif[, length(which(!is.na(countryCode) & is.na(decimalLatitude) & 
                        !is.na(county)))]

no_geoinfo <- 
  gbif[, length(which(is.na(countryCode) & is.na(decimalLatitude) &
                        is.na(county)))]

## ----, echo=FALSE--------------------------------------------------------
paste0("Total number of data lines:               ", total)
paste0("Country and/or county and/or coordinates: ", either)
paste0("Country only:                             ", ctry_only)
paste0("Coordinates only:                         ", coord_only)
paste0("County only:                              ", cnty_only)
paste0("Country and coordinates:                  ", ctry_and_coord)
paste0("Only county and coordinates:              ", cnty_and_coord)
paste0("Only country and county:                  ", ctry_and_cnty)
paste0("No information:                           ", no_geoinfo)

