## Extract an ordered factor of months from a date object

abbr_month <- function(date){
  if(class(date) != "Date") stop("Not a date object", call. = FALSE)
  
  factor(format(date, "%b"),
         ordered = TRUE,
         levels = c("Jan", "Feb", "Mar", "Apr", "May", 
                    "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))
}

## Check the response from server.
#' @source https://github.com/ropensci/rnoaa/blob/f65d92420e9bb6f4b8d09cbea32c0132638843ce/R/zzz.r#L89-L94
check_response <- function(response){
  browser()
  
  if(response$status_code == 200){
    stop(paste0("Non successful http request. Target server returning a ", response$status_code, " error code"),
        call. = FALSE)
  }
  
  if(grepl("shutdown", response$url)){
    stop("Data source is currently down due to a government shutdown",
         call. = FALSE)
  }
  
  invisible(TRUE)
}