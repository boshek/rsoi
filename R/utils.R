## Extract an ordered factor of months from a date object

abbr_month <- function(date){
  if(class(date) != "Date") stop("Not a date object", call. = FALSE)
  
  factor(format(date, "%b"),
         ordered = TRUE,
         levels = c("Jan", "Feb", "Mar", "Apr", "May", 
                    "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))
}