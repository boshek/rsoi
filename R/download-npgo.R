#' @export
#' @title Download North Pacific Gyre Oscillation data
#' 
#' @param 
#' create_csv Logical option to create a local copy of the data. Defaults to FALSE.
#' 
#' @description North Pacific Gyre Oscillation data
#' 
#' @return 
#' \itemize{
#' \item Year
#' \item Month: Month of record
#' \item North Pacific Gyre Oscillation
#' }

#' @examples
#' npgo <- download_npgo()
#'
#' @references \url{http://www.o3d.org/npgo/} 


download_npgo <- function(create_csv = FALSE) {
  npgo <- readr::read_table("http://www.o3d.org/npgo/data/NPGO.txt", comment = "#", col_names = c("Year","Month","NPGO"))
  
  if(create_csv==TRUE){
    readr::write_csv(npgo, paste0("NPGO_",min(npgo$Year),"-",max(npgo$Year),".csv"))
  }
  print(npgo)
}
