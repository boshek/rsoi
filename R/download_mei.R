#' @export
#' @title Download Multivariate ENSO Index Version 2 (MEI.v2)
#' 
#' @description MEI.v2 is based on EOF analysis of level pressure, 
#' sea surface temperature, surface zonal winds, surface meridional winds,
#' and Outgoing Longwave Radiation. The analysis is conducted for 12 partially 
#' overlapping 2-month "seasons".  
#' 
#' Warm phase is defined as MEI index greater or equal to 0.5. Cold phase is 
#' defined as MEI index lesser or equal to -0.5.
#' 
#' @inheritParams download_oni
#' 
#' @return 
#' \itemize{
#' \item Date: Date object that uses the first of the month as a placeholder. Date formatted as date on the first of the month because R only supports one partial of date time
#' \item Month: Bi-moonthly season of record
#' \item Year: Year of record
#' \item MEI: Multivariate ENSO Index Version 2
#' \item Phase: ENSO phase  
#' }

#' @examples
#' \dontrun{
#' mei <- download_mei()
#' }
#'
#' @references \url{https://www.esrl.noaa.gov/psd/enso/mei/}
download_mei <- function(use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_mei_memoised, 
             unmemoised = download_mei_unmemoised, 
             read_function = read_mei)
}

download_mei_unmemoised = function() {
  mei_link = "https://www.esrl.noaa.gov/psd/enso/mei/data/meiv2.data"
  
  res = check_response(mei_link)
  
  years = strsplit(readLines(res, n = 1), "     ", 2)[[1]]
  rows = diff(as.numeric(years)) + 1
  months = c("DJ", "JF", "FM", "MA", "AM", "MJ", "JJ", "JA", "AS", "SO", "ON", "ND")
  
  mei =  read.csv(check_response(mei_link),    # reset connection
                  header = FALSE, 
                  col.names = c("Year", months),
                  nrows = rows,
                  skip = 1, 
                  na.strings = "-999.00",
                  sep = "",
                  stringsAsFactors = FALSE)
  
  grid = expand.grid(Year = mei$Year, Month = months)
  grid$MEI = c(as.matrix(mei[, months]))
  grid$Month = factor(grid$Month, levels = months)
  grid$Date = as.Date(paste0(grid$Year, "-", as.numeric(grid$Month) ,"-01"), "%Y-%m-%d")
  grid$Phase = factor(ifelse(grid$MEI <= -0.5,"Cool Phase/La Nina",
                            ifelse(grid$MEI >= 0.5, "Warm Phase/El Nino", 
                                   "Neutral Phase")))
  grid$Phase = factor(grid$Phase, levels = c("Cool Phase/La Nina", 
                                             "Neutral Phase",
                                             "Warm Phase/El Nino"), ordered = TRUE)
  
  grid <- grid[, c("Year", "Month", "Date", "MEI", "Phase")]
  class(grid) = c("tbl_df", "tbl", "data.frame") 
  
  return(grid)
}

download_mei_memoised <- memoise::memoise(download_mei_unmemoised)


read_mei <- function(file) {
  data <- read.csv(file)
  data$Date <- as.Date(data$Date)
  data$Phase <- factor(data$Phase, levels = c("Cool Phase/La Nina", 
                                               "Neutral Phase",
                                               "Warm Phase/El Nino"), ordered = TRUE)
  data$Month <- factor(data$Month, 
                       levels =  c("DJ", "JF", "FM", "MA", "AM", "MJ", "JJ", "JA", "AS", "SO", "ON", "ND"))
  
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}