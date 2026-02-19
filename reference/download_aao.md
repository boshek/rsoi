# Download Antarctic Oscillation data

Projection of the monthly 700 hPa anomaly height field south of 20°S on
the first EOF obtained from the monthly 700 hPa height anomaly.

## Usage

``` r
download_aao(use_cache = FALSE, file = NULL)
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

- AAO: Antarctic Oscillation

## References

<https://www.cpc.ncep.noaa.gov/products/precip/CWlink/daily_ao_index/aao/aao.shtml>

## Examples

``` r
if (FALSE) { # \dontrun{
aao <- download_aao()
} # }
```
