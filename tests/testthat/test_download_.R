indexes <- c("oni", "ao", "nao", "soi", "mei", "npgo", "aao", "pdo")

context("Testing download")


test_download <- function(index) {
  function_name <- paste0("download_", index)
  fun <- match.fun(function_name)
  
  test_that(paste0("Does ", function_name, " download a data.frame?"), {
    skip_if_offline()
    skip_if_shutdown()
    expect_is( fun(), "data.frame" )
  })
}


sink <- lapply(indexes, test_download)


context("Read functions recover identical object")

test_read <- function(index) {
  test_that(paste0("read_", index, " recovers data"), {
    file <- tempfile()
    
    download_fun <- match.fun(paste0("download_", index))
    # read_fun <- match.fun(paste0("read_", index))
    read_fun <- get(paste0("read_", index), asNamespace("rsoi"), mode = "function")
    
    skip_if_offline()
    skip_if_shutdown()
    
    data <- download_fun(use_cache = FALSE, file = file)
    data2 <- read_fun(file)
    
    # data2 <- download_fun(use_cache = TRUE, file = file)
    expect_equal(data, data2)
  })
}


sink <- lapply(indexes, test_read)
