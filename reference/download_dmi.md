# Download Dipole Mode Index (DMI)

Intensity of the IOD is represented by anomalous SST gradient between
the western equatorial Indian Ocean (50E-70E and 10S-10N) and the south
eastern equatorial Indian Ocean (90E-110E and 10S-0N). This gradient is
named as Dipole Mode Index (DMI). When the DMI is positive then, the
phenomenon is refereed as the positive IOD and when it is negative, it
is refereed as negative IOD.

## Usage

``` r
download_dmi(use_cache = FALSE, file = NULL)
```

## Arguments

- use_cache:

  logical option to save and load from cache. If \`TRUE\`, results will
  be cached in memory if \`file\` is \`NULL\` or on disk if \`file\` is
  not \`NULL\`.

- file:

  optional character with the full path of a file to save the data. If
  \`cache\` is \`FALSE\` but \`file\` is not \`NULL\`, the results will
  be downloaded from the internet and saved on disk.

## Value

- Year: Year of record

- Month: Month of record

- Date: Date object that uses the first of the month as a placeholder.
  Date formatted as date on the first of the month because R only
  supports one partial of date time

- DMI: Dipole Mode Index

## References

<https://psl.noaa.gov/gcos_wgsp/Timeseries/DMI/>

## Examples

``` r
if (FALSE) { # \dontrun{
dmi <- download_dmi()
} # }
```
