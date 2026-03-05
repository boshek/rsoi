#' @export
#' @title Download Relative Oceanic Nino Index data
#' 
#' @param use_cache logical option to save and load from cache. If `TRUE`, results will be cached in memory
#' if `file` is `NULL` or on disk if `file` is not `NULL`.
#' @param file optional character with the full path of a file to save the data. If `cache` is `FALSE` but
#' `file` is not `NULL`, the results will be downloaded from the internet and saved on disk. 
#' 
#' @description El Niño–Southern Oscillation (ENSO) is often characterized through the use of sea surface temperature (SST) departures from their climatological values, as in the Niño-3.4 index. However, this approach is problematic in a changing climate when the climatology itself is varying. To address this issue, van Oldenborgh et al. proposed a relative Niño-3.4 SST index, which subtracts the tropical mean SST anomaly from the Niño-3.4 index and multiplies by a scaling factor.
#' \itemize{
#' \item The cold phase was defined as periods in which the RONI values within a sliding five-season window were all below −0.5 degC
#' \item The warm phase was defined as periods in which the RONI values within a sliding five-season window were all above 0.5 degC
#' \item The neutral phase was defined as the situation outside the definitions of warm phase and cold phase
#' }
#' 
#' @return 
#' \itemize{
#' \item Year: Year of record
#' \item Season: Season of record
#' \item roni: Relative Oceanic Niño Index, using the 1991–2020 base period "3 month running mean of ERSST.v5 SST anomalies in the Niño 3.4 region (5°N–5°S, 120°–170°W) with average tropical mean (20°N–20°S) SST anomalies subtracted. The difference is then adjusted so the variance equals the original Niño 3.4 index".
#' \item Start_Month: Start month of record
#' \item End_Month: End month of record
#' \item phase: ENSO phase  
#' }

#' @examples
#' \dontrun{
#' roni <- download_roni()
#' }
#'
#' @references \url{https://www.cpc.ncep.noaa.gov/products/analysis_monitoring/enso/roni/#latest-data}
#' \url{https://journals.ametsoc.org/view/journals/clim/37/4/JCLI-D-23-0406.1.xml}

download_roni <-  function(use_cache = FALSE, file = NULL) {
  with_cache(use_cache = use_cache, file = file, 
             memoised = download_roni_memoised, 
             unmemoised = download_roni_unmemoised, 
             read_function = read_roni)
}



## Function to download roni data
download_roni_unmemoised <- function() {
  roni_link ="https://www.cpc.ncep.noaa.gov/data/indices/RONI.ascii.txt"
  
  res = tryCatch(
    check_response(roni_link),
    error = function(e) {
      message(e)
      return(invisible(NULL))
    }
  )

  roni = read.table(res, 
                   col.names = c("Season","Year","RONI"),
                   skip = 1,
                   stringsAsFactors = FALSE)
  
  roni = roni[,c("Year","Season","RONI")]
  

  roni$Start_Month = c(
    "12","01","02","03","04","05","06",
    "07","08","09","10","11"
  )
  
  roni$End_Month= c(
    "02","03","04","05","06","07","08",
    "09","10","11","12","01"
  )
  
  ## Assign phase 
  
  roni$Phase=c("Neutral Phase")  #All records were first classified as neutral, and then assessed for La Niña or El Niño conditions

  #If the RONI values for any sliding five-season window all exceeded the threshold, 
  #the first through fifth seasons were classified as a La Niña or El Niño event; 
  #otherwise, conditions were classified as neutral.
  for (i in 1:(n - 4)) {
    if(all(roni$RONI[i:(i + 4)] >= 0.5)){  
      roni$Phase[i:(i + 4)] = "Warm Phase/El Nino"
    } else if (all(roni$RONI[i:(i + 4)] <= -0.5)){
      roni$Phase[i:(i + 4)] = "Cool Phase/La Nina"
    }
  }
  
  class(roni) <- c("tbl_df", "tbl", "data.frame") 
  
  roni[,c("Year","Season","RONI", "Start_Month", "End_Month", "Phase")]
}

# Memoised function
download_roni_memoised <- memoise::memoise(download_roni_unmemoised)

# Function to read roni data from file. 
read_roni <- function(file) {
  data <- read.csv(file)
  data$Start_Month = c(
    "12","01","02","03","04","05","06",
    "07","08","09","10","11"
  )
  data$End_Month= c(
    "02","03","04","05","06","07","08",
    "09","10","11","12","01"
  )
  
  data$phase <- c("Neutral Phase")  
  for (i in 1:(n - 4)) {
    if(all(data$RONI[i:(i + 4)] >= 0.5)){  
      data$Phase[i:(i + 4)] = "Warm Phase/El Nino"
    } else if (all(data$RONI[i:(i + 4)] <= -0.5)){
      data$Phase[i:(i + 4)] = "Cool Phase/La Nina"
    }
  }

  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}                         
