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
#' \dontrun{
#' nao <- download_nao()
#' }
#'
#' @references \url{https://www.ncdc.noaa.gov/teleconnections/nao}



## Function to download ONI data
download_nao <- function(){
  
  if(!curl::has_internet()){
    return(message("A working internet connection is required to download and import the climate indices."))
  }
  
  nao_link ="https://www.ncdc.noaa.gov/teleconnections/nao/data.csv"
  
  res <- check_response(nao_link)
  
  nao = read.csv(res, 
                   col.names = c("Date","NAO"),
                   skip = 1,
                   stringsAsFactors = FALSE)
  
  nao$Date = as.Date(paste0(nao$Date,"01"), "%Y%m%d")
  
  ##Month label to collapse
  nao$Month = abbr_month(nao$Date)
  nao$Year = format(nao$Date, "%Y")
  

  class(nao) <- c("tbl_df", "tbl", "data.frame") 
  
  nao[,c("Year","Month", "NAO")]
  
  
}