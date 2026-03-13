context("testing download_roni")

test_that("download_roni returns a data.frame", {
  skip_on_cran()
  skip_if_offline()
  skip_if_shutdown()
  expect_is(download_roni(), "data.frame")
})

test_that("Start_Month and End_Month are correctly mapped from Season for all rows", {
  skip_on_cran()
  skip_if_offline()
  skip_if_shutdown()

  roni <- download_roni()

  # Verify the data has more rows than the 12 season types, which would expose
  # any regression back to positional vector assignment.
  expect_gt(nrow(roni), 12)

  season_start <- c(
    DJF = "12", JFM = "01", FMA = "02", MAM = "03",
    AMJ = "04", MJJ = "05", JJA = "06", JAS = "07",
    ASO = "08", SON = "09", OND = "10", NDJ = "11"
  )
  season_end <- c(
    DJF = "02", JFM = "03", FMA = "04", MAM = "05",
    AMJ = "06", MJJ = "07", JJA = "08", JAS = "09",
    ASO = "10", SON = "11", OND = "12", NDJ = "01"
  )

  expect_equal(unname(roni$Start_Month), unname(season_start[roni$Season]))
  expect_equal(unname(roni$End_Month), unname(season_end[roni$Season]))
})