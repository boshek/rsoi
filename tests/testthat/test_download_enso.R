context("Testing download_enso")

test_that("Does download_enso() download a data.frame?", {
  skip_if_no_internet()
  skip_if_shutdown()
  expect_is( download_enso(), "data.frame" )
})


test_that("Does download_enso() save to a file?", {
  skip_if_no_internet()
  skip_if_shutdown()
  
  old <- setwd(tempdir())
  on.exit(setwd(old))
  expect_is(download_enso(create_csv = TRUE), "data.frame" )
  expect_true(file.exists("ENSO_Index.csv"))
  setwd(old)
})