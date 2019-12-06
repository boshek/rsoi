context('testing download_oni')

test_that('the first and last rows of ONI_month_window are NA',{
  oni <- download_oni()
  expect_true(is.na(oni$ONI_month_window[1]))
  expect_true(is.na(oni$ONI_month_window[nrow(oni)]))
})
