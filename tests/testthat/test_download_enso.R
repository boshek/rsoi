context("Testing download_enso")

test_that("Does download_enso() download a data.frame?", {
  skip_if_no_internet()
  skip_if_shutdown()
  expect_is( download_enso(), "data.frame" )
})