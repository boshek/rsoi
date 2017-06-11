#' @export
#' @title Download Southern Oscillation Index data
#' 
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
#' soi <- download_soi()
#' plot(x = enso$Date, y = enso$SOI, type = "l")
#'
#' @references \url{https://www.ncdc.noaa.gov/teleconnections/enso/indicators/soi/} 


## Function to bring in SOI data
download_soi <- function(){
  soi = readr::read_csv(
    "https://www.ncdc.noaa.gov/teleconnections/enso/indicators/soi/data.csv",
    skip = 2, col_names = c("Date","SOI")
  )
  ## Create Date formatted as date
  soi$Date = lubridate::ymd(paste0(soi$Date, "01"))
  
  ## Create Year and Month columns
  soi$Month = lubridate::month(soi$Date, abbr = TRUE, label = TRUE)
  soi$Year = lubridate::year(soi$Date)
  
  ## Create 3 month average window. Each row is a month
  soi$SOI_3MON_AVG = as.numeric(stats::filter(soi$SOI,rep(1/3,3), sides=2))
  
  soi <- dplyr::select(soi, Date, Month, Year, SOI, SOI_3MON_AVG)
  soi
}