#' @export
#' @title Download Dipole Mode Index (DMI)
#' 
#' @description Intensity of the IOD is represented by anomalous SST gradient 
#' between the western equatorial Indian Ocean (50E-70E and 10S-10N) and the 
#' south eastern equatorial Indian Ocean (90E-110E and 10S-0N). 
#' This gradient is named as Dipole Mode Index (DMI). 
#' When the DMI is positive then, the phenomenon is refereed as the positive
#' IOD and when it is negative, it is refereed as negative IOD.
#'
#' 
#' @inheritParams download_oni
#' 
#' @return 
#' \itemize{
#' \item Year: Year of record
#' \item Month: Month of record
#' \item Date: Date object that uses the first of the month as a placeholder. Date formatted as date on the first of the month because R only supports one partial of date time
#' \item DMI: Dipole Mode Index
#' }
#' 
#' @examples
#' \dontrun{
#' dmi <- download_dmi()
#' }
#'
#' @references \url{https://psl.noaa.gov/gcos_wgsp/Timeseries/DMI/}
download_dmi <- function(use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_dmi_memoised, 
             unmemoised = download_dmi_unmemoised, 
             read_function = read_dmi)
}

download_dmi_unmemoised = function() {
  dmi_link = "https://psl.noaa.gov/gcos_wgsp/Timeseries/Data/dmi.had.long.data"
  
  res = tryCatch(
    check_response(dmi_link),
    error = function(e) {
      message(e)
      return(invisible(NULL))
    }
  )
  
  years = strsplit(trimws(readLines(res, n = 1)), " ")[[1]]
  rows = diff(as.numeric(years)) + 1
  months = month.abb
  
  dmi =  read.csv(check_response(dmi_link),    # reset connection
                  header = FALSE, 
                  col.names = c("Year", months),
                  nrows = rows,
                  skip = 1, 
                  na.strings = "-9999.000",
                  sep = "",
                  stringsAsFactors = FALSE)
  
  grid = expand.grid(Year = dmi$Year, Month = months)
  grid$DMI = c(as.matrix(dmi[, months]))
  grid$Month = factor(grid$Month, levels = months)
  grid$Date = as.Date(paste0(grid$Year, "-", as.numeric(grid$Month) ,"-01"), "%Y-%m-%d")
  
  grid <- grid[, c("Year", "Month", "Date", "DMI")]
  class(grid) = c("tbl_df", "tbl", "data.frame") 
  
  return(grid)
}

download_dmi_memoised <- memoise::memoise(download_dmi_unmemoised)


read_dmi <- function(file) {
  data <- read.csv(file)
  data$Date <- as.Date(data$Date)
  data$Month <- factor(data$Month, 
                       levels = month.abb)
  
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}
