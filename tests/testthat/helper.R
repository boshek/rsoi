### Skip all the CI's and CRAN if there is no internet or a gov shutdown

skip_if_no_internet <- function(){
  curl::has_internet()
  skip_on_appveyor()
  skip_on_cran()
  skip_on_travis()
}

skip_if_shutdown <- function(){
  res <- curl::curl_fetch_memory("https://www.ncdc.noaa.gov/teleconnections/nao/data.csv")
  
  if(grepl("shutdown", res$url)){
    skip_on_appveyor()
    skip_on_cran()
    skip_on_travis()
  }
}
