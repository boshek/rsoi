#' @export
#' @title Download Southern Oscillation index data
#' 
#' @description Temperature anomalies:
#' \itemize{
#' \item Warm phase of El Nino/ Southern Oscillation when 3-month average sea-surface temperature departure of positive 0.5 degC
#' \item Cool phase of La Nina/ Southern Oscillation when 3-month average sea-surface temperature departure of negative 0.5 degC
#' \item Neutral phase is defined as the three month temperature average is between +0.5 and -0.5 degC
#' }

#' @examples
#' soi_df <- download_soi()
#'


download_soi <- function() {
  message("YrMon formatted as date on the first of the month because R only supports one partial date time")
    enso = utils::read.table("http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt", header = TRUE)
    enso = dplyr::tbl_df(enso)
    enso$YrMon = lubridate::ymd(paste0(enso$YR,"-",enso$MON,"-1"))
    enso$phase = ifelse(enso$ANOM >= 0.5,"Warm Phase", ifelse(enso$ANOM <= 0.5, "Cool Phase", "Neutral Phase"))
    return(enso)
}




