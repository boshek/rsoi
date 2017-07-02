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

* local Windows 7, R 3.4.0
* ubuntu, os x, R 3.4.0 (travis-ci)
* win-builder (devel and release)
* Windows, R 3.4.0 (on appveyor)

## R CMD check results

There were no ERRORs or WARNINGs.

There was 1 NOTE:
Possibly mis-spelled words in DESCRIPTION:
  ENSO (3:38)
  El (3:8)
  Nino (3:11, 7:133)
  
All words are correctly spelled. 

## Downstream dependencies

There are currently no downstream dependencies.