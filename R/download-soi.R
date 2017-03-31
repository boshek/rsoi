#' @export
#' @title Download Southern Oscillation index data
#' 
#' @description Temperature anomalies:
#' \itemize{
#' \item Warm phase of El Nino/ Southern Oscillation when 3-month average sea-surface temperature departure of positive 0.5 degC
#' \item Cool phase of La Nina/ Southern Oscillation when 3-month average sea-surface temperature departure of negative 0.5 degC
#' \item Neutral phase is defined as the three month temperature average is between +0.5 and -0.5 degC
#' }
#' 
#' @return 
#' \itemize{
#' \item Date: Date object that uses the first of the month as a placeholder
#' \item Month: Month of record
#' \item Year: Year of record
#' \item SOI: Southern Oscillation Index
#' \item SOI_3MON_AVG: 3 Month Average Southern Oscillation Index
#' \item phase: ENSO phase  
#' }

#' @examples
#' soi_df <- download_soi()
#' plot(x = soi_df$Date, y = soi_df$SOI, type = "l")
#'


download_soi <- function() {
  message(
    "YrMon formatted as date on the first of the month because R only supports one partial of date time"
  )
  

  ## Bring in data
  soi = utils::read.csv(
    "https://www.ncdc.noaa.gov/teleconnections/enso/indicators/soi/data.csv",
    header = TRUE, skip = 1, col.names = c("Date","SOI")
  )
  
  
  
  ## Create YrMon formatted as date
  soi$Date = lubridate::ymd(paste0(soi$Date, "01"))
  
  ## Create Year and Month columns
  soi$Month = lubridate::month(soi$Date, abbr = TRUE, label = TRUE)
  soi$Year = lubridate::year(soi$Date)
  
  ## Create 3 month average window. Each row is a month
  soi$SOI_3MON_AVG = as.numeric(stats::filter(soi$SOI,rep(1/3,3), sides=2))
  
  ## Assign phase 
  soi$phase = factor(ifelse(soi$SOI_3MON_AVG >= 0.5,"Warm Phase/La Nina",
                             ifelse(soi$SOI_3MON_AVG <= -0.5, "Cool Phase/El Nino", "Neutral Phase")))
  
  return(soi[,c("Date","Month","Year","SOI","SOI_3MON_AVG","phase")])
}




