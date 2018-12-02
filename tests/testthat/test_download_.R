context("Testing download_soi")

test_that("Does download_soi download a data.frame?", {
  expect_is( download_soi(), "data.frame" )
})


context("Testing download_oni")

test_that("Does download_oni download a data.frame?", {
  expect_is( download_oni(), "data.frame" )
})


context("Testing download_npgo")

test_that("Does download_npgo download a data.frame?", {
  expect_is( download_npgo(), "data.frame" )
})

context("Testing download_nao")

test_that("Does download_nao download a data.frame?", {
  expect_is( download_nao(), "data.frame" )
})


context("Testing download_ao")

test_that("Does download_ao download a data.frame?", {
  expect_is( download_ao(), "data.frame" )
})