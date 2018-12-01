library(rsoi)

enso <- download_enso(climate_idx = "all")

usethis::use_data(enso, overwrite = TRUE)
