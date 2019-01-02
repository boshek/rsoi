context("Testing download_enso")

test_that("Does download_enso() download a data.frame?", {
  expect_is( download_enso(), "data.frame" )
})