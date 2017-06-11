#' @export
#' @title Download Oceanic Nino Index data
#' 
#' 
#' @description The Oceanic Nino Index is average sea surface temperature in the Nino 3.4 region (120W to 170W) averaged over three months. Phases are categorized by Oceanic Nino Index:
#' \itemize{
#' \item Warm phase of El Nino/ Southern Oscillation when 3-month average sea-surface temperature departure of positive 0.5 degC
#' \item Cool phase of La Nina/ Southern Oscillation when 3-month average sea-surface temperature departure of negative 0.5 degC
#' \item Neutral phase is defined as when the three month temperature average is between +0.5 and -0.5 degC
#' }
#' 
#' @return 
#' \itemize{
#' \item Date: Date object that uses the first of the month as a placeholder. Date formatted as date on the first of the month because R only supports one partial of date time
#' \item Month: Month of record
#' \item Year: Year of record
#' \item ONI: Oneanic Oscillation Index
#' \item ONI_month_window: 3 month period over which the Oneanic Oscillation Index is calculated
#' \item phase: ENSO phase  
#' }

#' @examples
#' oni <- download_oni()
#'
#' @references \url{http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt}



## Function to download ONI data
download_oni <- function(){
  oni = readr::read_table(
    "http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt", 
    skip = 1, col_names = c("Year","Month","TOTAL","ClimAdjust","dSST3.4"))[,c("Year","Month","dSST3.4")]
  ## Create Date formatted as date
  oni$Date = lubridate::ymd(paste0(oni$Year,"-",oni$Month,"-01"))
  
  ##Month label to collapse
  oni$Month = lubridate::month(oni$Date, abbr = TRUE, label = TRUE)
  
  ## Create 3 month average window. Each row is a month
  oni$ONI = as.numeric(stats::filter(oni$dSST3.4,rep(1/3,3), sides=2))
  
  oni$ONI_month_window <- sapply(1:nrow(oni),function(x) paste(substr(oni$Month[x-1],1,1),
                                                               substr(oni$Month[x],1,1),
                                                               substr(oni$Month[x+1],1,1),
                                                               sep=""))
  
  ## Assign phase 
  oni$phase = factor(ifelse(oni$ONI >= 0.5,"Warm Phase/La Nina",
                            ifelse(oni$ONI<= -0.5, "Cool Phase/El Nino", "Neutral Phase")))
  
  oni <- dplyr::select(oni, Date, Month, Year, ONI, ONI_month_window, phase)
  
  oni
}