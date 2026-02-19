# Download Southern Oscillation Index data

The Southern Oscillation Index is defined as the standardized difference
between barometric readings at Darwin, Australia and Tahiti.

## Usage

``` r
download_soi(use_cache = FALSE, file = NULL)
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

- Date: Date object that uses the first of the month as a placeholder.
  Date formatted as date on the first of the month because R only
  supports one partial of date time

- Month: Month of record

- Year: Year of record

- SOI: Southern Oscillation Index

- SOI_3MON_AVG: 3 Month Average Southern Oscillation Index

## References

<https://www.cpc.ncep.noaa.gov/data/indices/soi>

## Examples

``` r
if (FALSE) { # \dontrun{
soi <- download_soi()
} # }
```
