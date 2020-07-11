#' @export
#' @title Download Arctic Oscillation data
#' 
#' @inheritParams download_oni
#' 
#' @description Projection of the daily 1000 hPa anomaly height field north of 20°N on the first EOF obtained
#' from the monthly 1000 hPa height anomaly.
#' @return 
#' \itemize{
#' \item Date: Date object that uses the first of the month as a placeholder. Date formatted as date on the first of the month because R only supports one partial of date time
#' \item Month: Month of record
#' \item Year: Year of record
#' \item AO: Arctic Oscillation
#' }

#' @examples
#' \dontrun{
#' ao <- download_ao()
#' }
#'
#' @references \url{https://www.ncdc.noaa.gov/teleconnections/ao/}
download_ao <- function(use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_ao_memoised, 
             unmemoised = download_ao_unmemoised, 
             read_function = read_ao)
}


## Function to download ONI data
download_ao_unmemoised <- function(){
  ao_link ="https://www.ncdc.noaa.gov/teleconnections/ao/data.csv"
  
  res = tryCatch(
    check_response(ao_link),
    error = function(e) {
      message(e)
      return(invisible(NULL))
    }
  )
  
  ao = read.csv(res, 
                   col.names = c("Date","AO"),
                   skip = 1,
                   stringsAsFactors = FALSE)
  
  ao$Date = as.Date(paste0(ao$Date,"01"), "%Y%m%d")
  
  ##Month label to collapse
  ao$Month = abbr_month(ao$Date)
  ao$Year = as.integer(format(ao$Date, "%Y"))
  

  class(ao) <- c("tbl_df", "tbl", "data.frame") 
  
  ao[,c("Year","Month", "Date", "AO")]
  
}

download_ao_memoised <- memoise::memoise(download_ao_unmemoised)


# Function to read oni data from file. 
read_ao <- function(file) {
  data <- read.csv(file)
  data$Year <- as.integer(data$Year)
  levels <- format(seq(as.Date("2018-01-01"), as.Date("2018-12-01"), "1 month"), "%b")
  data$Month <- factor(data$Month, levels = levels, ordered = TRUE)
  data$Date <- as.Date(data$Date)
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}