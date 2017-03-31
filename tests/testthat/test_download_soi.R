context("Testing download_soi")

test_that("Does download_soi download a data.frame?", {
  expect_is( download_soi(), "data.frame" )
})


test_that("Test whether SOI values have changed from February 2017", {
  data("soi_df")
  
  soi_df_current <- download_soi()
  soi_df_current <- soi_df_current[soi_df_current$Date<=max(soi_df$Date),]

  expect_equal( soi_df_current$SOI, 
                soi_df$SOI
                )
})

