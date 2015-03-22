#' Geocode dataset by country code
#'
#' @description
#' Assign centroid coordinates by country code
#' 
#' @param data Dataset to be updated
#' @param col Column containing the country code information
#' @param country Dataset containing country codes and centroid coordinates
#'
#' @return data.table object
#'
#' @export geocodeByCountry
#' 
geocodeByCountry <- function(data, col = "countryCode", country){
  input <- lapply(infile, function(x){
    print(x)
    fread(x, sep = sep, header = header, select=rlvt_cols)
  })
  return(input)
  input <- do.call("rbind", input)  
}
