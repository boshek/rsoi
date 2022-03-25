# rsoi NEWS

## Resubmission note
Removed quotes from URL markup

## rsoi v0.5.5
* Adds Dipole Mode Index. #42
* Fix a row numbering error

## rsoi v0.5.4
This is a re-submission after rsoi was archived. I believe I have fixed all problems. 

* Removed links causing this failures:

> Check process probably crashed or hung up for 20 minutes ... killed

* Catch network errors gracefully and return informative error
* Skip some tests on CRAN and use CI services to catch errors.

## Test environments

* local Windows 10, R 4.0.2
* local Ubuntu 16.04, R 4.0.1
* ubuntu, os x, R 4.0.0 (travis-ci)
* ubuntu 16.04 (on github actions), 4.0.2, R 3.5, R 3.4, R 3.3
* Windows Server 2019 (on github actions), R 4.0.2
* macOS Catalina 10.15 (on github actions), R 4.0.2
* win-builder (deve, release and old release)
* Windows, R 4.0.2 (on appveyor)

## R CMD check results

* This warning about incorrect words is a false positive:

   Possibly mis-spelled words in DESCRIPTION:
     Gyre (15:26)
     Indices (3:64)
     README (16:63)

## Downstream dependencies

There are currently no downstream dependencies.