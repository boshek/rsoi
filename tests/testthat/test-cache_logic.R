test_function <- function() {
  data.frame(x = rnorm(100),
                 y = rnorm(100))
}


test_function_memoised <- memoise::memoise(test_function)


same <- function(x, y) {
  isTRUE(all.equal(x, y, check.attributes = FALSE))
}


context("cache logic")

test_that("doesn't cache by default", {
  res1 <- with_cache(cache = FALSE, file = NULL, test_function_memoised, test_function)
  res2 <- with_cache(cache = FALSE, file = NULL, test_function_memoised, test_function)
  
  expect_false(same(res1, res2))
  
  file <- tempfile()
  res1 <- with_cache(cache = FALSE, file = file, test_function_memoised, test_function)
  res2 <- with_cache(cache = FALSE, file = file, test_function_memoised, test_function)
  
  expect_false(same(res1, res2))
  
  res_file <- read.csv(file)
  expect_equal(res2, res_file, check.attributes = FALSE)
})



test_that("cache works", {
  res1 <- with_cache(cache = TRUE, file = NULL, test_function_memoised, test_function)
  res2 <- with_cache(cache = TRUE, file = NULL, test_function_memoised, test_function)
  
  expect_equal(res1, res2, check.attributes = FALSE)
  file <- tempfile()
  res3 <- with_cache(cache = TRUE, file = file, test_function_memoised, test_function)
  res4 <- with_cache(cache = TRUE, file = file, test_function_memoised, test_function)
  
  expect_equal(res3, res4, check.attributes = FALSE)
  
  expect_false(same(res1, res3))
  
})
