context("Testing download_soi")

test_that("Does download_soi download a data.frame?", {
  expect_is( download_enso(climate_idx = "soi"), "data.frame" )
})


context("Testing download_oni")

test_that("Does download_oni download a data.frame?", {
  expect_is( download_enso(climate_idx = "oni"), "data.frame" )
})


context("Testing download_npgo")

test_that("Does download_npgo download a data.frame?", {
  expect_is( download_enso(climate_idx = "npgo"), "data.frame" )
})