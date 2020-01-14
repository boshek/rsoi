# rsoi NEWS

## rsoi v0.5.1
* Reverts El Nino/ La Nina mixup (Thanks to Arthur Chapman for the email submitted patch)
* Remove rpdo and devtools from Suggests
* Fix bug in `download_enso()`'s ability to save data to .csv
* Download functions respect machine locale. 
* Download functions can optionally cache data to memory or disk. 
* Standard data types and column order.
* Add Antarctic Oscillation. #27

## Test environments

* local Windows 10, R 3.6.2
* ubuntu, os x, R 3.6.2 (travis-ci)
* ubuntu 16.04 (on github actions), R 3.6, R 3.5, R 3.4, R 3.3
* Windows Server 2019 (on github actions), R 3.6.2
* macOS Catalina 10.15 (on github actions), R 3.6.2
* win-builder (devel and release)
* Windows, R 3.5.1 (on appveyor)

## R CMD check results

There were no ERRORs or WARNINGs.

## Downstream dependencies

There are currently no downstream dependencies.