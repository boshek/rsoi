#' @export
#' @title Download Southern Oscillation Index data
#' 
#' @inheritParams download_oni
#' 
#' @description The Southern Oscillation Index is defined as the standardized difference between barometric readings at Darwin, Australia and Tahiti. 
#' 
#' @return 
#' \itemize{
#' \item Date: Date object that uses the first of the month as a placeholder. Date formatted as date on the first of the month because R only supports one partial of date time
#' \item Month: Month of record
#' \item Year: Year of record
#' \item SOI: Southern Oscillation Index
#' \item SOI_3MON_AVG: 3 Month Average Southern Oscillation Index
#' }

#' @examples
#' \dontrun{
#' soi <- download_soi()
#' }
#'
#' @references \url{"https://www.cpc.ncep.noaa.gov/data/indices/soi"} 
download_soi <- function(use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_soi_memoised, 
             unmemoised = download_soi_unmemoised, 
             read_function = read_soi)
}

## Function to bring in SOI data
download_soi_unmemoised <- function(){
  
  soi_link = "https://www.cpc.ncep.noaa.gov/data/indices/soi"
  
  res = tryCatch(
    check_response(soi_link),
    error = function(e) {
      message(e)
      return(invisible(NULL))
    }
  )
  

  raw <- readLines(soi_link)
  raw <- raw[grep("STANDARDIZED", raw):length(raw)]
  raw <- raw[grep("YEAR", raw):length(raw)]
  
  fwf_file <- tempfile(fileext = ".fwf")
  writeLines(raw, fwf_file)
  
  dat <- utils::read.fwf(fwf_file, skip = 1, 
                         widths = c(4, rep(6, 12)), 
                         col.names = c("YEAR", month.abb), 
                         na.strings = "-999.9")
  
  reshaped_list <- lapply(
    names(dat)[!names(dat) %in% "YEAR"], 
    function(x) {
      d <- dat[,c("YEAR",x)]
      d$Date <- grep(x, month.abb)
      d$Date <- as.Date(paste(d$YEAR, d$Date,"01", sep = "-"))
      d$YEAR <- NULL
      colnames(d) <- c("SOI", "Date")
      
      d
    }
  )
  
  soi <- do.call(rbind, reshaped_list)
  soi <- soi[order(soi$Date),]
  
  
  ## Create Year and Month columns
  soi$Month = abbr_month(soi$Date)
  soi$Year = as.integer(format(soi$Date, "%Y"))
  
  ## Create 3 month average window. Each row is a month
  soi$SOI_3MON_AVG = as.numeric(stats::filter(soi$SOI,rep(1/3,3), sides=2))
  
  row.names(soi) <- NULL
  
  class(soi) <- c("tbl_df", "tbl", "data.frame") 
  
  soi[,c("Year", "Month", "Date", "SOI", "SOI_3MON_AVG")]

}

download_soi_memoised <- memoise::memoise(download_soi_unmemoised)

read_soi <- function(file) {
  data <- read.csv(file)
  data$Date <- as.Date(data$Date)
  data$Month <- abbr_month(data$Date)
  data$Year <- as.integer(data$Year)
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}