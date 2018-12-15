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
  
  if(!curl::has_internet()){
    return(message("A working internet connection is required to download and import the climate indices."))
  }

  oni_link ="http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt"

  oni = read.table(oni_link, 
                   col.names = c("Year","Month","TOTAL","ClimAdjust","dSST3.4"),
                   skip = 1,
                   stringsAsFactors = FALSE)
  
  oni = oni[,c("Year","Month","dSST3.4")]
  

  oni$Date = as.Date(paste0(oni$Year,"-",oni$Month,"-01"), "%Y-%m-%d")
  
  ##Month label to collapse
  oni$Month = abbr_month(oni$Date)
  
  ## Create 3 month average window. Each row is a month
  oni$ONI = as.numeric(stats::filter(oni$dSST3.4,rep(1/3,3), sides=2))
  
  oni$ONI_month_window <- sapply(1:nrow(oni), function(x) paste(substr(oni$Month[x-1],1,1),
                                                               substr(oni$Month[x],1,1),
                                                               substr(oni$Month[x+1],1,1),
                                                               sep=""))
  
  ## Assign phase 
  oni$phase = factor(ifelse(oni$ONI >= 0.5,"Warm Phase/La Nina",
                            ifelse(oni$ONI<= -0.5, "Cool Phase/El Nino", "Neutral Phase")))
  
  class(oni) <- c("tbl_df", "tbl", "data.frame") 
  
  oni[,c("Date", "Month", "Year","dSST3.4", "ONI", "ONI_month_window", "phase")]
  
  
  
}