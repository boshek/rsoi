#' @export
#' @title Download Oceanic Nino Index data
#' 
#' @param use_cache logical option to save and load from cache. If `TRUE`, results will be cached in memory
#' if `file` is `NULL` or on disk if `file` is not `NULL`.
#' @param file optional character with the full path of a file to save the data. If `cache` is `FALSE` but
#' `file` is not `NULL`, the results will be downloaded from the internet and saved on disk. 
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
#' \dontrun{
#' oni <- download_oni()
#' }
#'
#' @references \url{http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt}

download_oni <-  function(use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_oni_memoised, 
             unmemoised = download_oni_unmemoised, 
             read_function = read_oni)
}



## Function to download ONI data
download_oni_unmemoised <- function() {
  oni_link ="http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt"
  
  res = tryCatch(
    check_response(oni_link),
    error = function(e) {
      message(e)
      return(invisible(NULL))
    }
  )

  oni = read.table(res, 
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
  oni$ONI_month_window[c(1, nrow(oni))] <- NA
  
  ## Assign phase 
  oni$phase = factor(ifelse(oni$ONI <= -0.5,"Cool Phase/La Nina",
                            ifelse(oni$ONI >= 0.5, "Warm Phase/El Nino", "Neutral Phase")))
  
  class(oni) <- c("tbl_df", "tbl", "data.frame") 
  
  oni[,c("Year", "Month", "Date", "dSST3.4", "ONI", "ONI_month_window", "phase")]
}

# Memoised function
download_oni_memoised <- memoise::memoise(download_oni_unmemoised)

# Function to read oni data from file. 
read_oni <- function(file) {
  data <- read.csv(file)
  data$Date <- as.Date(data$Date)
  data$Month <- abbr_month(data$Date)
  data$ONI_month_window <- as.character(data$ONI_month_window)
  data$phase <- factor(ifelse(data$ONI <= -0.5,"Cool Phase/La Nina",
                              ifelse(data$ONI >= 0.5, "Warm Phase/El Nino", 
                                     "Neutral Phase")))
  
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}