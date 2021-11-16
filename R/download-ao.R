#' @export
#' @title Download Arctic Oscillation data
#' 
#' @inheritParams download_oni
#' 
#' @description Projection of the daily 1000 hPa anomaly height field north of 20°N on the first EOF obtained
#' from the monthly 1000 hPa height anomaly.
#' @return 
#' \itemize{
#' \item Date: Date object that uses the first of the month as a placeholder. Date formatted as date on the first of the month because R only supports one partial of date time
#' \item Month: Month of record
#' \item Year: Year of record
#' \item AO: Arctic Oscillation
#' }

#' @examples
#' \dontrun{
#' ao <- download_ao()
#' }
#'
#' @references \url{https://www.ncdc.noaa.gov/teleconnections/ao/}
download_ao <- function(use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_ao_memoised, 
             unmemoised = download_ao_unmemoised, 
             read_function = read_ao)
}


## Function to download ONI data
download_ao_unmemoised <- function(){
  ao_link ="https://www.cpc.ncep.noaa.gov/products/precip/CWlink/daily_ao_index/monthly.ao.index.b50.current.ascii.table"
  
  res = tryCatch(
    check_response(ao_link),
    error = function(e) {
      message(e)
      return(invisible(NULL))
    }
  )
  
  ao = read.fwf(ao_link, 
                widths = c(4, rep(7, 12)),
                skip = 1, 
                col.names = c("Year", month.abb))
  
  reshaped_list <- lapply(
    month.abb, 
    function(x) {
      d <- ao[,c("Year",x)]
      d$Date <- grep(x, month.abb)
      d$Date <- as.Date(paste(d$Year, d$Date,"01", sep = "-"))
      colnames(d) <- c("Year", "AO", "Date")
      d
    }
  )
  
  ao_long <- do.call(rbind, reshaped_list)
  ao_long <- ao_long[order(ao_long$Date),]
  
  
  ##Month label to collapse
  ao_long$Month = abbr_month(ao_long$Date)
  

  class(ao_long) <- c("tbl_df", "tbl", "data.frame") 
  
  ao_long[,c("Year","Month", "Date", "AO")]
  
}

download_ao_memoised <- memoise::memoise(download_ao_unmemoised)


# Function to read oni data from file. 
read_ao <- function(file) {
  data <- read.csv(file)
  data$Year <- as.integer(data$Year)
  levels <- format(seq(as.Date("2018-01-01"), as.Date("2018-12-01"), "1 month"), "%b")
  data$Month <- factor(data$Month, levels = levels, ordered = TRUE)
  data$Date <- as.Date(data$Date)
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}