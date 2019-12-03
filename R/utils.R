## Extract an ordered factor of months from a date object

abbr_month <- function(date){
  if(class(date) != "Date") stop("Not a date object", call. = FALSE)
  
  levels <- format(seq(as.Date("2018-01-01"), as.Date("2018-12-01"), "1 month"), "%b")
  
  factor(format(date, "%b"),
         ordered = TRUE,
         levels = levels)
}

## Check the response from server.tes
check_response <- function(link){
  #browser()
  
  response <- curl::curl_fetch_memory(link)
  
  if(!response$status_code == 200){
    stop(paste0("Non successful http request. Target server returning a ", response$status_code, " error code"),
        call. = FALSE)
  }
  
  if(grepl("shutdown", response$url)){
    stop("Data source is currently unavailable due to a US government shutdown",
         call. = FALSE)
  }
  
  
  textConnection(rawToChar(response$content))
}



with_cache <- function(use_cache, file, memoised, unmemoised, 
                       read_function = read.csv, 
                       write_function = function(data, file) write.csv(data, file, row.names = FALSE), 
                       ...) {
  # cache in memory
  if (use_cache && is.null(file)) {
    return(memoised(...))
  }
  
  # cache in file  
  if (use_cache && file.exists(file)) {
    return(read_function(file))
  }
  
  if(!curl::has_internet()){
    message("A working internet connection is required to download and import the climate indices.")
    return(NULL)
  }
  data <- unmemoised(...)
  
  if (!is.null(file)) { 
    write_function(data, file)
  }
  
  if (!use_cache) {
    memoise::forget(memoised)
  } 
  
  return(data)
}


