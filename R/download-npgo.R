#' @export
#' @title Download North Pacific Gyre Oscillation data
#' 
#' 
#' @description North Pacific Gyre Oscillation data
#' 
#' @return 
#' \itemize{
#' \item Date: Date object that uses the first of the month as a placeholder. Date formatted as date on the first of the month because R only supports one partial of date time
#' \item Year: Year of Record
#' \item Month: Month of record
#' \item NPGO: North Pacific Gyre Oscillation
#' }

#' @examples
#' npgo <- download_npgo()
#'
#' @references \url{http://www.o3d.org/npgo/} 


download_npgo <- function() {
  npgo <- readr::read_table("http://www.o3d.org/npgo/data/NPGO.txt", comment = "#", col_names = c("Year","Month","NPGO"))
  
  npgo$Date = lubridate::ymd(paste0(npgo$Year,"-",npgo$Month,"-01"))
  
  ##Month label to collapse
  npgo$Month = lubridate::month(npgo$Date, abbr = TRUE, label = TRUE)
  
  npgo = npgo[,c("Date","Year", "Month", "NPGO")]
  
  npgo
}
