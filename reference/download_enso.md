# Download Southern Oscillation Index and Oceanic Nino Index data

The Southern Oscillation Index is defined as the standardized difference
between barometric readings at Darwin, Australia and Tahiti. The Oceanic
Nino Index is average sea surface temperature in the Nino 3.4 region
(120W to 170W) averaged over three months. Phases are categorized by
Oceanic Nino Index:

- Warm phase of El Nino/ Southern Oscillation when 3-month average
  sea-surface temperature departure of positive 0.5 degC

- Cool phase of La Nina/ Southern Oscillation when 3-month average
  sea-surface temperature departure of negative 0.5 degC

- Neutral phase is defined as when the three month temperature average
  is between +0.5 and -0.5 degC

## Usage

``` r
download_enso(climate_idx = c("all", "soi", "oni", "npgo"), create_csv = FALSE)
```

## Arguments

- climate_idx:

  Choose which ENSO related climate index to output. Current arguments
  supported are soi (the Southern Oscillation Index), oni (the Oceanic
  Nino Index), npgo (the North Pacific Gyre Oscillation) and all. all
  outputs each supported index variable as a slimmer dataset than each
  individual climate index call.

- create_csv:

  Logical option to create a local copy of the data. Defaults to FALSE.

## Value

- Date: Date object that uses the first of the month as a placeholder.
  Date formatted as date on the first of the month because R only
  supports one partial of date time

- Month: Month of record

- Year: Year of record

- ONI: Oceanic Oscillation Index

- phase: ENSO phase

- SOI: Southern Oscillation Index

- NPGO: North Pacific Gyre Oscillation

## Examples

``` r
if (FALSE) { # \dontrun{
enso <- download_enso()
} # }
```
