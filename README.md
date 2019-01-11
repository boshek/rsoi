
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
library(tibble)
```

## Usage

Download Oceanic Nino Index data

``` r
oni <- download_oni()
oni
#> # A tibble: 827 x 7
#>    Date       Month  Year dSST3.4     ONI ONI_month_window phase           
#>    <date>     <ord> <int>   <dbl>   <dbl> <chr>            <fct>           
#>  1 1950-01-01 Jan    1950   -1.62  NA     JF               <NA>            
#>  2 1950-02-01 Feb    1950   -1.32  -1.34  JFM              Warm Phase/El N~
#>  3 1950-03-01 Mar    1950   -1.07  -1.17  FMA              Warm Phase/El N~
#>  4 1950-04-01 Apr    1950   -1.11  -1.18  MAM              Warm Phase/El N~
#>  5 1950-05-01 May    1950   -1.37  -1.07  AMJ              Warm Phase/El N~
#>  6 1950-06-01 Jun    1950   -0.74  -0.85  MJJ              Warm Phase/El N~
#>  7 1950-07-01 Jul    1950   -0.44  -0.533 JJA              Warm Phase/El N~
#>  8 1950-08-01 Aug    1950   -0.42  -0.423 JAS              Neutral Phase   
#>  9 1950-09-01 Sep    1950   -0.41  -0.383 ASO              Neutral Phase   
#> 10 1950-10-01 Oct    1950   -0.32  -0.443 SON              Neutral Phase   
#> # ... with 817 more rows
```

And a quick plot with base R to illustrate the type of data:

``` r
barcols <- c('#edf8b1','#7fcdbb','#2c7fb8')

barplot(oni$ONI, names.arg = oni$Date, ylab = "Oceanic Nino Index" , 
    col = barcols[oni$phase], border = NA, space = 0,
    xaxt = "n")
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
