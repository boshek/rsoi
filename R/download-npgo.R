#' @export
#' @title Download North Pacific Gyre Oscillation data
#' 
#' 
#' @description North Pacific Gyre Oscillation data also known as the Victoria mode
#' 
#' @inheritParams download_oni
#' 
#' @return 
#' \itemize{
#' \item Date: Date object that uses the first of the month as a placeholder. Date formatted as date on the first of the month because R only supports one partial of date time
#' \item Year: Year of Record
#' \item Month: Month of record
#' \item NPGO: North Pacific Gyre Oscillation
#' }
#' @examples
#' \dontrun{
#' npgo <- download_npgo()
#' }
#'
#' @references \url{http://www.oces.us/npgo} 
download_npgo <- function(use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_npgo_memoised, 
             unmemoised = download_npgo_unmemoised, 
             read_function = read_npgo)
}



download_npgo_unmemoised <- function() {
  npgo_link ="http://www.oces.us/npgo/data/NPGO.txt"
  
  res = tryCatch(
    check_response(npgo_link),
    error = function(e) {
      message(e)
      return(invisible(NULL))
    }
  )
  
  npgo <- read.table(res, 
                     comment.char = "#",
                     col.names = c("Year","Month","NPGO"),
                     stringsAsFactors = FALSE)
  
  npgo$Date = as.Date(paste0(npgo$Year,"-",npgo$Month,"-01"), "%Y-%m-%d")
  
  ##Month label to collapse
  npgo$Month = abbr_month(npgo$Date)
  npgo$Year = as.integer(npgo$Year)

  class(npgo) <- c("tbl_df", "tbl", "data.frame") 
  npgo[, c("Year", "Month", "Date", "NPGO")]
}

download_npgo_memoised <- memoise::memoise(download_npgo_unmemoised)


read_npgo <- function(file) {
  data <- read.csv(file)
  data$Date <- as.Date(data$Date)
  data$Month <- abbr_month(data$Date)
  data$Year <- as.double(data$Year)
  
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}