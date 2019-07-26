# rsoi NEWS
## rsoi v0.5.1
* Reverts El Nino/ La Nina mixup (Thanks to Arthur Chapman for the email submitted patch)
* Remove rpdo and devtools from Suggests

## rsoi v0.5.0
* Checks if internet is installed
* Fixes El Nino/ La Nina mixup. 
* Removed internal indices data as we do not have them licenced properly and they serve little value.
* Makes test conditional upon having internet access and resilient to a government shutdown

## v0.4.0
* Removed readr, dplyr, lubridate dependency
* Optional tibble printing
* Adding functions to import North Atlantic Oscillation and Arctic Oscillation

## v0.3.1
* Removed utils from Imports field because it was no longer being used. 

## v0.3.0
* Adding Northern Pacific Gyre Oscillation
* Added readr dependencies
* Made soi and oni data download with readr tools
* Streamlined download_enso such that each idx is individually called from a separate function.
* Updated README

## v0.2.3
* Added some tolerance to ALL download_enso() tests to accommodate rounding errors from different sources

## v0.2.2
* Added some tolerance to download_enso() tests to accommodate rounding errors from different sources
* Modified output to be a tibble which then includes the tibble package

## Test environments

* local Windows 10, R 3.5.01
* ubuntu, os x, R 3.5.1 (travis-ci)
* win-builder (devel and release)
* Windows, R 3.5.1 (on appveyor)

## R CMD check results

There were no ERRORs or WARNINGs.

## Downstream dependencies

There are currently no downstream dependencies.