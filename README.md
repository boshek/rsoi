[![Travis-CI Build Status](https://travis-ci.org/boshek/rsoi.svg?branch=master)](https://travis-ci.org/boshek/rsoi) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/boshek/rsoi?branch=master&svg=true)](https://ci.appveyor.com/project/boshek/rsoi)

rsoi
------------------
An R package to download Southern Oscillation Index and Oceanic Nino Index data

Installation
------------------
To install and load the development version from GitHub

    devtools::install_github("rsoi")
    library(rsoi)

Inspired by
------------------

The idea for this package borrows heavily from the rpdo package. The initial efforts by these authors are gratefully acknowledged. The rpdo github page can be found here: [rpdo](https://github.com/poissonconsulting/rpdo)


Helpful References
------------------

[In Watching for El Niño and La Niña, NOAA Adapts to Global Warming](https://www.climate.gov/news-features/understanding-climate/watching-el-ni%C3%B1o-and-la-ni%C3%B1a-noaa-adapts-global-warming)

[L’Heureux, M. L., Collins, D. C., & Hu, Z.-Z. (2012, March.). Linear trends in sea surface temperature of the tropical Pacific Ocean and implications for the El Niño-Southern Oscillation. Climate Dynamics, 1–14. doi:10.1007/s00382-012-1331-2](https://link.springer.com/article/10.1007%2Fs00382-012-1331-2)


Data Sources
------------------
All data for this package are source from the National Oceanographic and Atmospheric Administration's [National Climatic Data Centre](https://www.ncdc.noaa.gov/)

SOI data: https://www.ncdc.noaa.gov/teleconnections/enso/indicators/soi/

ONI data: http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt