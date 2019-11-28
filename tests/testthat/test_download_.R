indexes <- c("oni", "ao", "nao", "soi", "mei", "npgo")

context("Testing download")

test_download <- function(index) {
  function_name <- paste0("download_", index)
  fun <- match.fun(function_name)
  
  test_that(paste0("Does ", function_name, " download a data.frame?"), {
    skip_if_no_internet()
    skip_if_shutdown()
    expect_is( fun, "data.frame" )
  })
}


sink <- lapply(indexes, test_download)


context("Read functions recover identical object")

test_read <- function(index) {
  file <- tempfile()
  download_fun <- match.fun(paste0("download_", index))
  read_fun <- match.fun(paste0("read_", index))
  
  test_that(paste0("read_", index, " recovers data"), {
    skip_if_no_internet()
    skip_if_shutdown()
    
    data <- download_fun()
    write.csv(data, file, row.names = FALSE)
    expect_equal(read_fun(file), data)
  })
}


sink <- lapply(indexes, test_read)

