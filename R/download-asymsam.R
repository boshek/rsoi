#' @export
#' @title Download Asymmetric and Symmetric SAM indices
#' 
#' @description The Asymmetric and Symmetric SAM indices are computed as the 
#' projection of geopotential height anomalies onto the zonally asymmetric and 
#' zonally symmetric parts of the SAM field. 
#' The detailed methodology can be found in Campitelli et al. (2022).
#' The source of the data is \url{https://www.cima.fcen.uba.ar/~elio.campitelli/asymsam/}
#' 
#' @inheritParams download_oni
#' @param levels atmospheric levels in hPa to download. 
#' If \code{"all"} download all available levels. 
#' Available levels are: 1, 2, 3, 5, 7, 10, 20, 30, 50, 70, 100, 125, 150, 175,
#'  200, 225, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 775, 800,
#'  825, 850, 875, 900, 925, 950, 975 and 1000.
#' 
#' @return 
#' \itemize{
#' \item Lev: Atmospheric level in hPa
#' \item Date: Date object that uses the first of the month as a placeholder. Date formatted as date on the first of the month because R only supports one partial of date time
#' \item Index: Type of index. Either "sam", "ssam" or "asam".
#' \item Value: Value of the index
#' \item Value_normalized: Value of the index normalized by the standard deviation of the index
#' \item R.squared: The variance explained by the index (only in the daily version)
#' }
#' 
#' @examples
#' \dontrun{
#' asymsam <- download_asymsam_monthly()
#' }
#'
#' @references Campitelli, E., Díaz, L. B., & Vera, C. (2022). Assessment of zonally symmetric and asymmetric components of the Southern Annular Mode using a novel approach. Climate Dynamics, 58(1), 161–178. \url{https://doi.org/10.1007/s00382-021-05896-5}
download_asymsam_monthly <- function(use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_asymsam_monthly_memoised, 
             unmemoised = download_asymsam_monthly_unmemoised, 
             read_function = read_asymsam_monthly)
}

download_asymsam_monthly_unmemoised = function() {
  asymsam_monthly_link = "https://www.cima.fcen.uba.ar/~elio.campitelli/asymsam/data/sam_monthly.csv"
  
  data <- read.csv(asymsam_monthly_link, colClasses = c("integer", "character", "Date", "numeric", "numeric"),
                   col.names = c("Lev", "Index", "Date", "Value", "Value_normalized"))
  data$Index <- factor(data$Index, levels = c("sam", "ssam", "asam"))
  
  class(data) = c("tbl_df", "tbl", "data.frame") 
  data
}

download_asymsam_monthly_memoised <- memoise::memoise(download_asymsam_monthly_unmemoised)

read_asymsam_monthly <- function(file) {
  data <- read.csv(file)
  data$Date <- as.Date(data$Date)
  data$Index <- factor(data$Index, levels = c("sam", "ssam", "asam"))
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}


#' @export
#' @rdname download_asymsam_monthly
download_asymsam_daily <- function(levels = 700, use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_asymsam_monthly_memoised, 
             unmemoised = download_asymsam_daily_unmemoised, 
             read_function = read_asymsam_monthly, 
             levels = levels)
}


download_asymsam_daily_unmemoised = function(levels = 700)  {
    available_levels <- c(1L, 2L, 3L, 5L, 7L, 10L, 20L, 30L, 50L, 70L, 100L, 125L, 150L, 
                          175L, 200L, 225L, 250L, 300L, 350L, 400L, 450L, 500L, 550L, 600L, 
                          650L, 700L, 750L, 775L, 800L, 825L, 850L, 875L, 900L, 925L, 950L, 
                          975L, 1000L)
    if (levels[1] == "all") {
      levels <- available_levels
    } 
    
    bad_levels <- !(levels %in% available_levels)
    if (any(bad_levels)) {
      stop(paste("Invalid levels:", paste(levels[bad_levels], collapse = ", "),
                 "\nValid levels are:", paste(available_levels, collapse = ", ")))
    }
    
    root_link = "https://www.cima.fcen.uba.ar/~elio.campitelli/asymsam/data/sam_level/"
    
    all_data <- list()
    for (level in levels) {
      message("Downloading level: ", level)
      link <- paste0(root_link, "sam_", level, "hPa.csv")
      data <- read.csv(link, colClasses = c("integer", "character", "Date", "numeric", "numeric", "numeric"),
                       col.names = c("Lev", "Index", "Date", "Value", "R.squared", "dump"))
      data$dump <- NULL
      all_data <- append(all_data, list(data))
    }
    all_data <- do.call(rbind, all_data)
    
    all_data$Index <- factor(all_data$Index, levels = c("sam", "ssam", "asam"))
    
    class(all_data) = c("tbl_df", "tbl", "data.frame") 
    all_data
  }


download_asymsam_monthly_memoised <- download_asymsam_monthly_unmemoised

read_asymsam_daily <- function(file) {
  data <- read.csv(file)
  data$Date <- as.Date(data$Date)
  data$Lev <- as.integer(data$Lev)
  data$Index <- factor(data$Index, levels = c("sam", "ssam", "asam"))
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}
