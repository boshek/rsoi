
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![License: GPL
v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Travis-CI Build
Status](https://travis-ci.org/boshek/rsoi.svg?branch=master)](https://travis-ci.org/boshek/rsoi)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/boshek/rsoi?branch=master&svg=true)](https://ci.appveyor.com/project/boshek/rsoi)
[![R build
status](https://github.com/boshek/rsoi/workflows/R-CMD-check/badge.svg)](https://github.com/boshek/rsoi)

[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/rsoi)](https://cran.r-project.org/package=rsoi)
[![CRAN
Downloads](https://cranlogs.r-pkg.org/badges/rsoi?color=brightgreen)](https://CRAN.R-project.org/package=rsoi)
[![cran
checks](https://cranchecks.info/badges/worst/rsoi)](https://cran.r-project.org/web/checks/check_results_rsoi.html)

# rsoi

An R package to download the most up to date of these climate indices:

  - Southern Oscillation Index
  - Oceanic Nino Index
  - North Pacific Gyre Oscillation
  - North Atlantic Oscillation
  - Arctic Oscillation
  - Antarctic Oscillation
  - Multivariate ENSO Index Version 2
  - Pacific Decadal Oscillation

## Installation

For the development version

``` r
install.packages("rsoi")

library(rsoi)
library(tibble)
```

## Usage

Download Oceanic Nino Index data

``` r
oni <- download_oni()
head(oni)
#> # A tibble: 6 x 7
#>    Year Month Date       dSST3.4   ONI ONI_month_window phase             
#>   <int> <ord> <date>       <dbl> <dbl> <chr>            <fct>             
#> 1  1950 Jan   1950-01-01   -1.62 NA    <NA>             <NA>              
#> 2  1950 Feb   1950-02-01   -1.32 -1.34 JFM              Cool Phase/La Nina
#> 3  1950 Mar   1950-03-01   -1.07 -1.17 FMA              Cool Phase/La Nina
#> 4  1950 Apr   1950-04-01   -1.11 -1.18 MAM              Cool Phase/La Nina
#> 5  1950 May   1950-05-01   -1.37 -1.07 AMJ              Cool Phase/La Nina
#> 6  1950 Jun   1950-06-01   -0.74 -0.85 MJJ              Cool Phase/La Nina
```

And a quick plot to illustrate the data:

``` r
barcols <- c('#edf8b1','#7fcdbb','#2c7fb8')

barplot(oni$ONI, names.arg = oni$Date, ylab = "Oceanic Nino Index" , 
    col = barcols[oni$phase], border = NA, space = 0,
    xaxt = "n")
```

![](man/figures/plot-1.png)<!-- -->

## Inspired by

The idea for this package borrows heavily from the `rpdo` package.
`rsoi` now supercedes `rpdo` as a source of data in R for Pacific
Decadal Oscillation.
