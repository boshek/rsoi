context("Testing download_enso")

test_that("Does download_soi download a data.frame?", {
  expect_is( download_enso(), "data.frame" )
})


test_that("Test whether SOI values have not changed from February 2017", {
  data("enso")
  
  enso_df_current <- download_enso()
  enso_df_current <- enso_df_current[enso_df_current$Date<=max(enso$Date),]

  expect_equal( enso_df_current$SOI, 
                enso$SOI
                )
})

test_that("Test whether ONI values have not changed from February 2017.", {
  
  ## To fix use 
  #enso <- download_enso()
  #devtools::use_data(enso)
  data("enso")
  
  enso_df_current <- download_enso()
  enso_df_current <- enso_df_current[enso_df_current$Date<=max(enso$Date),]
  
  expect_equal( enso_df_current$ONI, 
                enso$ONI
  )
})

test_that("Test that download_enso matches most recent value from alternate dataset - 3 months to account for slight data changes",{
  testthat::skip_on_cran()
  enso_df_current <- download_enso()
  
  ## Most recent from download_enso()
  recent_enso <- enso_df_current[length(na.omit(enso_df_current$ONI)) + 1 - 3,] #plus one to account for missing first value
  
  
  ## Alternative dataset
  ## Max year from download_enso -1949 gives last row number
    oni_df <- read.table("https://www.esrl.noaa.gov/psd/data/correlation/oni.data", nrows = max(enso_df_current$Year)-1949, skip = 1, col.names = c("Year","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"))
  
    
  expect_equal( recent_enso$ONI,
                oni_df[oni_df$Year==recent_enso$Year, paste0(recent_enso$Month)])
})

  


