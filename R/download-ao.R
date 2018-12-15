#' @export
#' @title Download North Atlantic Oscillation data
#' 
#' 
#' @description surface sea-level pressure difference between the Subtropical (Azores) High and the Subpolar Low. 
#' @return 
#' \itemize{
#' \item Month: Month of record
#' \item Year: Year of record
#' \item NAO: North Atlantic Oscillation
#' }

#' @examples
#' nao <- download_nao()
#'
#' @references \url{https://www.ncdc.noaa.gov/teleconnections/nao}



## Function to download ONI data
download_ao <- function(){
  
  if(!curl::has_internet()){
    return(message("A working internet connection is required to download and import the climate indices."))
  }
  
  ao_link ="https://www.ncdc.noaa.gov/teleconnections/ao/data.csv"
  
  ao = read.csv(ao_link, 
                   col.names = c("Date","AO"),
                   skip = 1,
                   stringsAsFactors = FALSE)
  
  ao$Date = as.Date(paste0(ao$Date,"01"), "%Y%m%d")
  
  ##Month label to collapse
  ao$Month = abbr_month(ao$Date)
  ao$Year = format(ao$Date, "%Y")
  

  class(ao) <- c("tbl_df", "tbl", "data.frame") 
  
  ao[,c("Year","Month", "AO")]
  
}