#' @export
#' @title Download North Atlantic Oscillation data
#' 
#' @inheritParams download_oni
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
download_ao <- function(use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_ao_memoised, 
             unmemoised = download_ao_unmemoised, 
             read_function = read_ao)
}


## Function to download ONI data
download_ao_unmemoised <- function(){
  ao_link ="https://www.ncdc.noaa.gov/teleconnections/ao/data.csv"
  
  res = check_response(ao_link)
  
  ao = read.csv(res, 
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

download_ao_memoised <- memoise::memoise(download_ao_unmemoised)



# Function to read oni data from file. 
read_ao <- function(file) {
  data <- read.csv(file)
  data$Date <- as.Date(data$Date)
  data$Month <- abbr_month(data$Date)
  
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}