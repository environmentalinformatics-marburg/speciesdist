#' Split large structure text file
#'
#' @description
#' Divide large structure text file into chunks of 100,000 lines and check if
#' each line has the same amount of lines.
#' 
#' @param filename Name of the data file
#' @param sep Separator of the text file columns
#' @param sep Does the first line contains a header (TRUE/FALSE)
#' @param outpath Name of the output directory where the individual chunks are
#' stored.
#'
#' @return List object containing some meta information on the processing.
#'
#' @export splitLTF
#' 
splitLTF <- function(infile, sep, header=TRUE, outpath){
  
  inpath <- paste0(dirname(infile), "/")
  if(missing(outpath)){
    outpath <- paste0(dirname(infile), "/")
  }
  
  f <- file(infile, "r")
  l <- readLines(f, n = 1, warn = FALSE)
  seek(f, where = 1, origin = "start")
  hline <- unlist(strsplit(l, sep))
  nrows <- length(hline)
  
  i <- 0
  while(length(l <- readLines(f, n = 100000, warn = FALSE)) > 0) {
    i <- i+1
    print(i)
    out <- do.call("rbind", lapply(l, function(x){
      act <- unlist(strsplit(x, sep))
      if(length(act) < nrows){
        act[length(act):nrows] <- "cmissing"
        print(paste0("Missing cells in ", as.character(i)))
      }
      act[grep(glob2rx(""), act)] <- "cempty"
      return(act)
    }))
    if(header == TRUE){
      colnames(out) <- hline
    }
    write.table(out, paste0(outpath, sprintf("gbif_chunk_%02d", i), ".txt"),
                sep = "\t", row.names = FALSE)
  }
  close(f)
}