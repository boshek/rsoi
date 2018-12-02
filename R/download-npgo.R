#' @export
#' @title Download North Pacific Gyre Oscillation data
#' 
#' 
#' @description North Pacific Gyre Oscillation data also known as the Victoria mode
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
  npgo <- read.table("http://www.o3d.org/npgo/data/NPGO.txt", 
                     comment.char = "#",
                     col.names = c("Year","Month","NPGO"),
                     stringsAsFactors = FALSE)
  
  npgo$Date = as.Date(paste0(npgo$Year,"-",npgo$Month,"-01"), "%Y-%m-%d")
  
  ##Month label to collapse
  npgo$Month = abbr_month(npgo$Date)

  class(npgo) <- c("tbl_df", "tbl", "data.frame") 
  
  npgo[,c("Date","Year", "Month", "NPGO")]

}
