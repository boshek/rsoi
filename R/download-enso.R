#' @export
#' @title Download ENSO data

#' @examples
#' enso_df <- download_enso()
#'


download_enso <- function() {
  message("YrMon formatted as date on the first of the month because R only supports one partial date time")
    enso = utils::read.table("http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt", header = TRUE)
    enso = dplyr::tbl_df(enso)
    enso$YrMon = lubridate::ymd(paste0(enso$YR,"-",enso$MON,"-1"))
    enso$phase = ifelse(enso$ANOM > 0,"Positive", ifelse(enso$ANOM < 0, "Negative", "Neutral"))
    return(enso)
}




