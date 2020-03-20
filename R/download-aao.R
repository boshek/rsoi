#' @export
#' @title Download Antarctic Oscillation data
#' 
#' @inheritParams download_oni
#' 
#' @description Projection of the monthly 700 hPa anomaly height field south of 20°S on the first EOF obtained
#' from the monthly 700 hPa height anomaly.
#' @return 
#' \itemize{
#' \item Date: Date object that uses the first of the month as a placeholder. Date formatted as date on the first of the month because R only supports one partial of date time
#' \item Month: Month of record
#' \item Year: Year of record
#' \item AAO: Antarctic Oscillation
#' }
#' @examples
#' \dontrun{
#' aao <- download_aao()
#' }
#'
#' @references \url{https://www.cpc.ncep.noaa.gov/products/precip/CWlink/daily_ao_index/aao/aao.shtml}
download_aao <- function(use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_aao_memoised, 
             unmemoised = download_aao_unmemoised, 
             read_function = read_aao)
}


## Function to download ONI data
download_aao_unmemoised <- function(){
  aao_link ="https://www.cpc.ncep.noaa.gov/products/precip/CWlink/daily_ao_index/aao/monthly.aao.index.b79.current.ascii"
  
  res = check_response(aao_link)
  
  aao = utils::read.fwf(aao_link, 
                c(5, 5,14), 
                sep = ",",
                col.names = c("Date","Month", "AAO"),
                stringsAsFactors = FALSE)
  
  aao$Month <- sprintf("%02d", aao$Month)
  aao$Date = as.Date(paste0(aao$Date,aao$Month,"01"), "%Y%m%d")
  
  ##Month label to collapse
  aao$Month = abbr_month(aao$Date)
  aao$Year = as.integer(format(aao$Date, "%Y"))
  

  class(aao) <- c("tbl_df", "tbl", "data.frame") 
  
  aao[,c("Year", "Month", "Date", "AAO")]
  
}

download_aao_memoised <- memoise::memoise(download_aao_unmemoised)


# Function to read oni data from file. 
read_aao <- function(file) {
  data <- read.csv(file)
  data$Year <- as.integer(data$Year)
  levels <- format(seq(as.Date("2018-01-01"), as.Date("2018-12-01"), "1 month"), "%b")
  data$Month <- factor(data$Month, levels = levels, ordered = TRUE)
  data$Date <- as.Date(data$Date)
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}

