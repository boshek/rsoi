# Download Arctic Oscillation data

Projection of the daily 1000 hPa anomaly height field north of 20°N on
the first EOF obtained from the monthly 1000 hPa height anomaly.

## Usage

``` r
download_ao(use_cache = FALSE, file = NULL)
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

- AO: Arctic Oscillation

## References

<https://www.ncdc.noaa.gov/teleconnections/ao/>

## Examples

``` r
if (FALSE) { # \dontrun{
ao <- download_ao()
} # }
```
