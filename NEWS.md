# rsoi NEWS
## rsoi v0.4.1
* Checks if internet is installed
* Fixes El Nino/ La Nina mixup. 
* Removed internal indices data as we do not have them licenced properly and they serve little value.
* Makes test condition upon having internet and resilient to a government shutdown


## rsoi v0.4
* Removed readr, dplyr, lubridate dependency
* Optional tibble printing
* Adding functions to import North Atlantic Oscillation and Arctic Oscillation


## rsoi v0.3.1
* Patch: Removed utils from Imports field because it was no longer being used.


## rsoi v0.3.0
* Adding Northern Pacific Gyre Oscillation
* Added readr dependencies
* Made soi and oni data download with readr tools
* Streamlined download_enso such that each idx is individually called from a separate function.
* Updated README

## rsoi v0.2.2

* Added some tolerance to download_enso() tests to accommodate rounding errors from different sources
* Modified output to be a tibble which then includes the tibble package

## rsoi v0.1.0

* SOI and ONI from Jan 1950 to Feb 2017.

