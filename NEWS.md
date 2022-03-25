# rsoi NEWS
## rsoi v0.5.5
* Adds Dipole Mode Index. #42
* Fix a row numbering error

## rsoi v0.5.4
* Catch network errors gracefully and return informative error
* Skip some tests on CRAN and use CI services to catch errors.
* Removed links causing this failures:
> Check process probably crashed or hung up for 20 minutes ... killed

## rsoi v0.5.3
* Remove Extended PDO because data is no longer available. 
* Fail more gracefully with data source issues

## rsoi v0.5.2
* Adding PDO after rpdo maintainers requested we start importing. Thanks @eliocamp (#33)

## rsoi v0.5.1
* Reverts El Nino/ La Nina mixup (Thanks to Arthur Chapman for the email submitted patch)
* Remove rpdo and devtools from Suggests
* Fix bug in `download_enso()`'s ability to save data to .csv
* Download functions respect machine locale. 
* Download functions can optionally cache data to memory or disk. 
* Standard data types and column order.
* Add Antarctic Oscillation. #27

## rsoi v0.5.0
* Checks if internet is installed
* Fixes El Nino/ La Nina mixup. 
* Removed internal indices data as we do not have them licenced properly and they serve little value.
* Makes test conditional upon having internet and resilient to a government shutdown


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

