##April 07, 2017 Patch
* Apologies I submitted the wrong version a few minutes. Sorry to waste your time. Please disregard previous submission and again sorry.
* Change DESCRIPTION to state v0.2.1 as it previously stated v0.2.0 which was incorrect. 
* skipping a test on cran because it was taking too long and failing on debian. Test still passes.
* proper referencing of url in download_soi documentation 

## Resubmission
As requested I have re-submitted. This version:

* Changed title to title case
* Removed redundant "An R package to" and simply started Description with "Downloads"
* Added web references to the Description.

## Test environments

* local Windows 10, R 3.3.3
* ubuntu, os x, R 3.3.3 (travis-ci)
* win-builder (devel and release)
* Windows, R 3.3.3 (on appveyor)

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