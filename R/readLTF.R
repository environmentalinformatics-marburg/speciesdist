#' Read large structure text file
#'
#' @description
#' Read large structure text file from chunks or as a whole.
#' 
#' @param filename Name(s) of the data file
#' @param sep Separator of the text file columns
#' @param header Does the first line contains a header (TRUE/FALSE)
#' @param rlvt_cols Include only given columns in the output data.table.
#'
#' @return data.table object
#'
#' @export readLTF
#' 
readLTF <- function(infile, sep=",", header=TRUE, rlvt_cols=NULL){
  input <- lapply(infile, function(x){
    print(x)
    fread(x, sep = sep, header = header, select=rlvt_cols)
  })
  return(input)
  input <- do.call("rbind", input)  
}
