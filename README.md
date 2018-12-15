
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![License: GPL
v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Travis-CI Build
Status](http://travis-ci.org/boshek/rsoi.svg?branch=master)](https://travis-ci.org/boshek/rsoi)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/boshek/rsoi?branch=master&svg=true)](https://ci.appveyor.com/project/boshek/rsoi)

[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/rsoi)](https://cran.r-project.org/package=rsoi)
[![CRAN
Downloads](https://cranlogs.r-pkg.org/badges/rsoi?color=brightgreen)](https://CRAN.R-project.org/package=rsoi)
[![cran
checks](https://cranchecks.info/badges/worst/rsoi)](https://cran.rstudio.com/web/checks/check_results_rsoi.html)

## rsoi

An R package to download the most up to date - Southern Oscillation
Index - Oceanic Nino Index - North Pacific Gyre Oscillation data - North
Atlantic Oscillation - Arctic Oscillation

## Installation

``` r
install.packages("rsoi")

library(rsoi)
library(ggplot2)
library(tibble)
```

## Usage

``` r
enso <- download_enso()
enso
#> # A tibble: 814 x 7
#>    Date        Year Month    ONI phase                SOI   NPGO
#>    <date>     <int> <ord>  <dbl> <fct>              <dbl>  <dbl>
#>  1 1951-02-01  1951 Feb   -0.54  Warm Phase/El Nino   0.9 -0.414
#>  2 1951-03-01  1951 Mar   -0.167 Neutral Phase       -0.1 -0.570
#>  3 1951-04-01  1951 Apr    0.177 Neutral Phase       -0.3 -0.561
#>  4 1951-05-01  1951 May    0.363 Neutral Phase       -0.7 -1.07 
#>  5 1951-06-01  1951 Jun    0.587 Cool Phase/La Nina   0.2 -1.44 
#>  6 1951-07-01  1951 Jul    0.7   Cool Phase/La Nina  -1   -1.10 
#>  7 1951-08-01  1951 Aug    0.887 Cool Phase/La Nina  -0.2 -1.17 
#>  8 1951-09-01  1951 Sep    0.993 Cool Phase/La Nina  -1.1 -1.42 
#>  9 1951-10-01  1951 Oct    1.15  Cool Phase/La Nina  -1   -1.07 
#> 10 1951-11-01  1951 Nov    1.04  Cool Phase/La Nina  -0.8 -1.01 
#> # ... with 804 more rows
```

Or for index specific data use the  argument:

``` r
soi <- download_enso(climate_idx = "soi")
soi
#> # A tibble: 814 x 5
#>    Date       Month Year    SOI SOI_3MON_AVG
#>    <date>     <ord> <chr> <dbl>        <dbl>
#>  1 1951-02-01 Feb   1951    0.9       NA    
#>  2 1951-03-01 Mar   1951   -0.1        0.167
#>  3 1951-04-01 Apr   1951   -0.3       -0.367
#>  4 1951-05-01 May   1951   -0.7       -0.267
#>  5 1951-06-01 Jun   1951    0.2       -0.5  
#>  6 1951-07-01 Jul   1951   -1         -0.333
#>  7 1951-08-01 Aug   1951   -0.2       -0.767
#>  8 1951-09-01 Sep   1951   -1.1       -0.767
#>  9 1951-10-01 Oct   1951   -1         -0.967
#> 10 1951-11-01 Nov   1951   -0.8       -0.833
#> # ... with 804 more rows
```

And we can plot these values using `ggplot2` nicely

``` r
ggplot(enso, aes(x = Date, y = NPGO)) +
  geom_line() +
  theme_minimal() +
  labs(x = "Year", y = "North Pacific Gyre Oscillation")
```

![](man/figures/plot-1.png)<!-- -->

## Inspired by

The idea for this package borrows heavily from the rpdo package. The
initial efforts by these authors are gratefully acknowledged. The rpdo
github page can be found here:
[rpdo](https://github.com/poissonconsulting/rpdo)

## Data Sources

  - Southern Oscillation Index
    <https://www.ncdc.noaa.gov/teleconnections/enso/indicators/soi/>
  - Oceanic Nino Index data
    <http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt>
  - Northern Pacific Gyre Oscillation
    <http://www.o3d.org/npgo/data/NPGO.txt>
  - North Atlantic Oscillation
    <https://www.ncdc.noaa.gov/teleconnections/nao/data.csv>
  - Arctic Oscillation
    <https://www.ncdc.noaa.gov/teleconnections/ao/data.csv>

## Helpful References

[In Watching for El Niño and La Niña, NOAA Adapts to Global
Warming](https://www.climate.gov/news-features/understanding-climate/watching-el-ni%C3%B1o-and-la-ni%C3%B1a-noaa-adapts-global-warming)

[L’Heureux, M. L., Collins, D. C., & Hu, Z.-Z. (2012, March.). Linear
trends in sea surface temperature of the tropical Pacific Ocean and
implications for the El Niño-Southern Oscillation. Climate
Dynamics, 1–14.
doi:10.1007/s00382-012-1331-2](https://link.springer.com/article/10.1007%2Fs00382-012-1331-2)

[The Victoria mode in the North Pacific linking extratropical sea level
pressure variations to
ENSO](http://onlinelibrary.wiley.com/doi/10.1002/2014JD022221/pdf)

Please note that the ‘rsoi’ project is released with a [Contributor Code
of Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you
agree to abide by its terms.
