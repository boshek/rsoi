#' @export
#' @title Download North Atlantic Oscillation data
#' 
#' @inheritParams download_oni
#' 
#' @description surface sea-level pressure difference between the Subtropical (Azores) High and the Subpolar Low. 
#' @return 
#' \itemize{
#' \item Month: Month of record
#' \item Year: Year of record
#' \item NAO: North Atlantic Oscillation
#' }

#' @examples
#' \dontrun{
#' nao <- download_nao()
#' }
#'
#' @references \url{https://www.ncdc.noaa.gov/teleconnections/nao}

download_nao <- function(use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_nao_memoised, 
             unmemoised = download_nao_unmemoised, 
             read_function = read_nao)
}

## Function to download ONI data
download_nao_unmemoised <- function(){
  nao_link ="https://www.ncdc.noaa.gov/teleconnections/nao/data.csv"
  
  res <- check_response(nao_link)
  
  nao = read.csv(res, 
                   col.names = c("Date","NAO"),
                   skip = 1,
                   stringsAsFactors = FALSE)
  
  nao$Date = as.Date(paste0(nao$Date,"01"), "%Y%m%d")
  
  ##Month label to collapse
  nao$Month = abbr_month(nao$Date)
  nao$Year = format(nao$Date, "%Y")
  

  class(nao) <- c("tbl_df", "tbl", "data.frame") 
  
  nao[,c("Year","Month", "NAO")]
  
  
}

download_nao_memoised <- memoise::memoise(download_nao_unmemoised)


read_nao <- function(file) {
  data <- read.csv(file)
  data$Date <- as.Date(data$Date)
  data$Month <- abbr_month(data$Date)
  
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}