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
#' @references \url{https://www.ncdc.noaa.gov/teleconnections/nao/}

download_nao <- function(use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_nao_memoised, 
             unmemoised = download_nao_unmemoised, 
             read_function = read_nao)
}

## Function to download ONI data
download_nao_unmemoised <- function(){
  nao_link ="https://www.cpc.ncep.noaa.gov/products/precip/CWlink/pna/norm.nao.monthly.b5001.current.ascii.table"
  
  res <- tryCatch(
    check_response(nao_link),
    error = function(e) {
      message(e)
      return(invisible(NULL))
    }
  )
  
  nao = read.fwf(nao_link, 
                widths = c(4, rep(7, 12)),
                header = FALSE, 
                col.names = c("Year", month.abb))
  
  reshaped_list <- lapply(
    month.abb, 
    function(x) {
      d <- nao[,c("Year",x)]
      d$Date <- grep(x, month.abb)
      d$Date <- as.Date(paste(d$Year, d$Date,"01", sep = "-"))
      colnames(d) <- c("Year", "NAO", "Date")
      d
    }
  )
  
  nao_long <- do.call(rbind, reshaped_list)
  nao_long <- nao_long[order(nao_long$Date),]
  
  ##Month label to collapse
  nao_long$Month = abbr_month(nao_long$Date)
  
  row.names(nao_long) <- NULL

  class(nao_long) <- c("tbl_df", "tbl", "data.frame") 
  
  nao_long[,c("Year","Month", "NAO")]
  
  
}

download_nao_memoised <- memoise::memoise(download_nao_unmemoised)


read_nao <- function(file) {
  data <- read.csv(file)
  data$Year <- as.integer(data$Year)
  levels <- format(seq(as.Date("2018-01-01"), as.Date("2018-12-01"), "1 month"), "%b")
  data$Month <- factor(data$Month, levels = levels, ordered = TRUE)
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}