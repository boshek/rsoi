#' @export
#' @title Download Southern Oscillation Index and Oceanic Nino Index data
#' 
#' @param climate_idx Choose which ENSO related climate index to output. Current arguments supported are soi (the Southern Oscillation Index), oni (the Oceanic Nino Index), npgo (the North Pacific Gyre Oscillation) and all. all outputs each supported index variable as a slimmer dataset than each individual cliamte index call.   
#' 
#' @param create_csv Logical option to create a local copy of the data. Defaults to FALSE.
#' 
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
#' \item ONI: Oneanic Oscillation Index
#' \item phase: ENSO phase 
#' \item SOI: Southern Oscillation Index
#' \item NPGO: North Pacific Gyre Oscillation
#' }

#' @examples
#' enso <- download_enso()
#' plot(x = enso$Date, y = enso$SOI, type = "l")
#'
#' @references \url{https://www.ncdc.noaa.gov/teleconnections/enso/indicators/soi/} and \url{http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt}


download_enso <- function(climate_idx = c("all", "soi", "oni","npgo"), create_csv = FALSE) {
  
  match.arg(climate_idx)
  
  if(climate_idx == "soi") {
    soi_df = download_soi()
    return(soi_df)
  } 
  
  if(climate_idx == "oni") {
    oni_df = download_oni()
    return(oni_df)
  } 
  
  if(climate_idx == "npgo") {
    npgo_df = download_npgo()
    return(npgo_df)
  }
  
  if(create_csv==TRUE){
    write.csv(enso, "ENSO_Index.csv")
  }
  
  
  if(climate_idx == "all"){
  ## Join index data
    oni_df = download_oni()
    soi_df = download_soi()
    npgo_df = download_npgo()
    enso <- merge(oni_df, soi_df)
    enso <- merge(enso, npgo_df)
    enso <- enso[,c("Date", "Year", "Month", "ONI", "phase", "SOI", "NPGO")]
    return(enso)
  }
  
  
  


}




