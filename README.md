
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

# rsoi

An R package to download the most up to date of these climate indices: -
Southern Oscillation Index - Oceanic Nino Index - North Pacific Gyre
Oscillation data - North Atlantic Oscillation - Arctic Oscillation -
Multivariate ENSO Index Version 2

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
#> [90m# A tibble: 838 x 7[39m
#>    Date       Month  Year dSST3.4    ONI ONI_month_window phase            
#>    [3m[90m<date>[39m[23m     [3m[90m<ord>[39m[23m [3m[90m<int>[39m[23m   [3m[90m<dbl>[39m[23m  [3m[90m<dbl>[39m[23m [3m[90m<chr>[39m[23m            [3m[90m<fct>[39m[23m            
#> [90m 1[39m 1950-01-01 Jan    [4m1[24m950   -[31m1[39m[31m.[39m[31m62[39m [31mNA[39m     JF               [31mNA[39m               
#> [90m 2[39m 1950-02-01 Feb    [4m1[24m950   -[31m1[39m[31m.[39m[31m32[39m -[31m1[39m[31m.[39m[31m34[39m  JFM              Warm Phase/El Ni…
#> [90m 3[39m 1950-03-01 Mar    [4m1[24m950   -[31m1[39m[31m.[39m[31m0[39m[31m7[39m -[31m1[39m[31m.[39m[31m17[39m  FMA              Warm Phase/El Ni…
#> [90m 4[39m 1950-04-01 Apr    [4m1[24m950   -[31m1[39m[31m.[39m[31m11[39m -[31m1[39m[31m.[39m[31m18[39m  MAM              Warm Phase/El Ni…
#> [90m 5[39m 1950-05-01 May    [4m1[24m950   -[31m1[39m[31m.[39m[31m37[39m -[31m1[39m[31m.[39m[31m0[39m[31m7[39m  AMJ              Warm Phase/El Ni…
#> [90m 6[39m 1950-06-01 Jun    [4m1[24m950   -[31m0[39m[31m.[39m[31m74[39m -[31m0[39m[31m.[39m[31m85[39m  MJJ              Warm Phase/El Ni…
#> [90m 7[39m 1950-07-01 Jul    [4m1[24m950   -[31m0[39m[31m.[39m[31m44[39m -[31m0[39m[31m.[39m[31m533[39m JJA              Warm Phase/El Ni…
#> [90m 8[39m 1950-08-01 Aug    [4m1[24m950   -[31m0[39m[31m.[39m[31m42[39m -[31m0[39m[31m.[39m[31m423[39m JAS              Neutral Phase    
#> [90m 9[39m 1950-09-01 Sep    [4m1[24m950   -[31m0[39m[31m.[39m[31m41[39m -[31m0[39m[31m.[39m[31m383[39m ASO              Neutral Phase    
#> [90m10[39m 1950-10-01 Oct    [4m1[24m950   -[31m0[39m[31m.[39m[31m32[39m -[31m0[39m[31m.[39m[31m443[39m SON              Neutral Phase    
#> [90m# … with 828 more rows[39m
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

The idea for this package borrows heavily from the rpdo package. The
initial efforts by these authors are gratefully acknowledged. The rpdo
github page can be found here:
[rpdo](https://github.com/poissonconsulting/rpdo)

## Data Sources

  - Southern Oscillation Index:
    <https://www.ncdc.noaa.gov/teleconnections/enso/indicators/soi/>
  - Oceanic Nino Index data:
    <http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt>
  - Northern Pacific Gyre Oscillation:
    <http://www.o3d.org/npgo/data/NPGO.txt>
  - North Atlantic Oscillation:
    <https://www.ncdc.noaa.gov/teleconnections/nao/data.csv>
  - Arctic Oscillation:
    <https://www.ncdc.noaa.gov/teleconnections/ao/data.csv>
  - Multivariate ENSO Index Version 2 (MEI.v2):
    <https://www.esrl.noaa.gov/psd/enso/mei/>

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
