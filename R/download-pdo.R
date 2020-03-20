#' @export
#' @title Download Pacific Decadal Oscillation Data
#' 
#' @param use_cache logical option to save and load from cache. If `TRUE`, results will be cached in memory
#' if `file` is `NULL` or on disk if `file` is not `NULL`.
#' @param file optional character with the full path of a file to save the data. If `cache` is `FALSE` but
#' `file` is not `NULL`, the results will be downloaded from the internet and saved on disk. 
#' 
#' @description The PDO index is derived as the leading PC of monthly SST anomalies in the North Pacific Ocean, poleward of 20N. The monthly mean global average SST anomalies are removed to separate this pattern of variability from any "global warming" signal that may be present in the data.
#' 
#' @return 
#' \itemize{
#' \item Date: Date object that uses the first of the month as a placeholder. Date formatted as date on the first of the month because R only supports one partial of date time
#' \item Month: Month of record
#' \item Year: Year of record
#' \item PDO: Pacific Decadal Oscillation index
#' }

#' @examples
#' \dontrun{
#' pdo <- download_pdo()
#' }
#'
#' @references \url{http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt}

download_pdo <-  function(use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_pdo_memoised, 
             unmemoised = download_pdo_unmemoised, 
             read_function = read_oni)
}



## Function to download ONI data
download_pdo_unmemoised <- function() {
  pdo_link = paste0("https://oceanview.pfeg.noaa.gov/erddap/tabledap/cciea_OC_PDO.csv?time%2CPDO&time%3E=1900-01-01&time%3C=", 
                    Sys.Date())
  
  
  res = check_response(pdo_link)
  
  pdo = read.table(res, 
                   col.names = c("Date", "PDO"),
                   skip = 2, 
                   sep = ",",
                   stringsAsFactors = FALSE)
  pdo$Year = as.numeric(substr(pdo$Date, 1, 4))
  pdo$Date = as.Date(pdo$Date)
  pdo$Month = abbr_month(pdo$Date)
  
  class(pdo) <- c("tbl_df", "tbl", "data.frame") 
  pdo[, c("Year", "Month", "Date", "PDO")]
}

# Memoised function
download_pdo_memoised <- memoise::memoise(download_pdo_unmemoised)

# Function to read oni data from file. 
read_pdo <- function(file) {
  data <- read.csv(file)
  data$Date <- as.Date(data$Date)
  data$Month <- abbr_month(data$Date)
  
  
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}