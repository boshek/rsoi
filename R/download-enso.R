#' @export
#' @title Download Southern Oscillation Index and Oceanic Nino Index data
#' 
#' @param 
#' create_csv Logical option to create a local copy of the data. Defaults to FALSE.
#' 
#' @description The Southern Oscillation Index is defined as the standardized difference between barometric readings at Darwin, Australia and Tahiti. The Oceanic Nino Index is average sea surface temperature in the Nino 3.4 region (120W to 170W) averaged over three months. Phases are categorized by Oceanic Nino Index:
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
#' \item dSST3.4: Monthly change in sea surface temperature at Nino region 3.4
#' \item ONI: Oneanic Oscillation Index
#' \item month_window: 3 month period over which ONI is calculated
#' \item phase: ENSO phase  
#' \item SOI: Southern Oscillation Index
#' \item SOI_3MON_AVG: 3 Month Average Southern Oscillation Index
#' }

#' @examples
#' enso <- download_enso()
#' plot(x = enso$Date, y = enso$SOI, type = "l")
#'
#' @references \url{https://www.ncdc.noaa.gov/teleconnections/enso/indicators/soi/} and \url{http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt}


download_enso <- function(create_csv = FALSE) {

  ## Bring in SOI data
  soi = utils::read.csv(
    "https://www.ncdc.noaa.gov/teleconnections/enso/indicators/soi/data.csv",
    header = TRUE, skip = 1, col.names = c("Date","SOI")
  )
  
  ## Create Date formatted as date
  soi$Date = lubridate::ymd(paste0(soi$Date, "01"))
  
  ## Create Year and Month columns
  soi$Month = lubridate::month(soi$Date, abbr = TRUE, label = TRUE)
  soi$Year = lubridate::year(soi$Date)
  
  ## Create 3 month average window. Each row is a month
  soi$SOI_3MON_AVG = as.numeric(stats::filter(soi$SOI,rep(1/3,3), sides=2))
  
  ## Bring in ONI data
  oni = utils::read.table(
    "http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt",
    header = TRUE, col.names = c("Year","Month","TOTAL","ClimAdjust","dSST3.4")
  )[,c("Year","Month","dSST3.4")]
  
  ## Create Date formatted as date
  oni$Date = lubridate::ymd(paste0(oni$Year,"-",oni$Month,"-01"))
  
  ##Month label to collapse
  oni$Month = lubridate::month(oni$Date, abbr = TRUE, label = TRUE)

  ## Create 3 month average window. Each row is a month
  oni$ONI = as.numeric(stats::filter(oni$dSST3.4,rep(1/3,3), sides=2))
  
  oni$month_window <- sapply(1:nrow(oni),function(x) paste(substr(oni$Month[x-1],1,1),
                                                           substr(oni$Month[x],1,1),
                                                           substr(oni$Month[x+1],1,1),
                                                           sep=""))
  
  ## Assign phase 
  oni$phase = factor(ifelse(oni$ONI >= 0.5,"Warm Phase/La Nina",
                             ifelse(oni$ONI<= -0.5, "Cool Phase/El Nino", "Neutral Phase")))
  
  
  ## Merge two data frames
  enso <- merge(oni, soi,  by = c("Date","Month","Year"), all = TRUE)
  
  
  if(create_csv==TRUE){
    utils::write.csv(enso, file = paste0("SOI_ONI_Index_",max(soi$Date),".csv"), row.names = FALSE)
  }
  
  return(enso)
  

}




