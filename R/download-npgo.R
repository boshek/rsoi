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
#'
#' @references \url{http://www.oces.us/npgo} 


download_npgo <- function() {
  
  if(!curl::has_internet()){
    return(message("A working internet connection is required to download and import the climate indices."))
  }
  
  npgo_link ="http://www.oces.us/npgo/data/NPGO.txt"
  
  res = check_response(npgo_link)
  
  npgo <- read.table(res, 
                     comment.char = "#",
                     col.names = c("Year","Month","NPGO"),
                     stringsAsFactors = FALSE)
  
  npgo$Date = as.Date(paste0(npgo$Year,"-",npgo$Month,"-01"), "%Y-%m-%d")
  
  ##Month label to collapse
  npgo$Month = abbr_month(npgo$Date)

  class(npgo) <- c("tbl_df", "tbl", "data.frame") 
  
  npgo[,c("Date","Year", "Month", "NPGO")]

}
