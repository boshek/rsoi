#' @export
#' @title Download Southern Oscillation Index data
#' 
#' @inheritParams download_oni
#' 
#' @description The Southern Oscillation Index is defined as the standardized difference between barometric readings at Darwin, Australia and Tahiti. 
#' 
#' @return 
#' \itemize{
#' \item Date: Date object that uses the first of the month as a placeholder. Date formatted as date on the first of the month because R only supports one partial of date time
#' \item Month: Month of record
#' \item Year: Year of record
#' \item SOI: Southern Oscillation Index
#' \item SOI_3MON_AVG: 3 Month Average Southern Oscillation Index
#' }

#' @examples
#' \dontrun{
#' soi <- download_soi()
#' }
#'
#' @references \url{https://www.ncdc.noaa.gov/teleconnections/enso/indicators/soi/} 
download_soi <- function(use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_soi_memoised, 
             unmemoised = download_soi_unmemoised, 
             read_function = read_soi)
}

## Function to bring in SOI data
download_soi_unmemoised <- function(){
  soi_link = "https://www.ncdc.noaa.gov/teleconnections/enso/indicators/soi/data.csv"
  
  res = tryCatch(
    check_response(soi_link),
    error = function(e) {
      message(e)
      return(invisible(NULL))
    }
  )
  
  
  soi = read.csv(
    res,
    skip = 2,
    stringsAsFactors = FALSE,
    col.names = c("Date","SOI")
  )
  ## Create Date formatted as date
  soi$Date = as.Date(paste0(soi$Date, "01"),"%Y%m%d")
  
  ## Create Year and Month columns
  soi$Month = abbr_month(soi$Date)
  soi$Year = as.integer(format(soi$Date, "%Y"))
  
  ## Create 3 month average window. Each row is a month
  soi$SOI_3MON_AVG = as.numeric(stats::filter(soi$SOI,rep(1/3,3), sides=2))
  
  class(soi) <- c("tbl_df", "tbl", "data.frame") 
  
  soi[,c("Year", "Month", "Date", "SOI", "SOI_3MON_AVG")]

}

download_soi_memoised <- memoise::memoise(download_soi_unmemoised)

read_soi <- function(file) {
  data <- read.csv(file)
  data$Date <- as.Date(data$Date)
  data$Month <- abbr_month(data$Date)
  data$Year <- as.integer(data$Year)
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}