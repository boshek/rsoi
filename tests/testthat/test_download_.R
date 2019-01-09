context("Testing download")

test_that("Does download_soi download a data.frame?", {
  skip_if_no_internet()
  skip_if_shutdown()
  expect_is( download_soi(), "data.frame" )
})


test_that("Does download_oni download a data.frame?", {
  skip_if_no_internet()
  skip_if_shutdown()
  expect_is( download_oni(), "data.frame" )
})


test_that("Does download_npgo download a data.frame?", {
  skip_if_no_internet()
  skip_if_shutdown()
  expect_is( download_npgo(), "data.frame" )
})


test_that("Does download_nao download a data.frame?", {
  skip_if_no_internet()
  skip_if_shutdown()
  expect_is( download_nao(), "data.frame" )
})


test_that("Does download_ao download a data.frame?", {
  skip_if_no_internet()
  skip_if_shutdown()
  expect_is( download_ao(), "data.frame" )
})