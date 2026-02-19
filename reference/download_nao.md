# Download North Atlantic Oscillation data

surface sea-level pressure difference between the Subtropical (Azores)
High and the Subpolar Low.

## Usage

``` r
download_nao(use_cache = FALSE, file = NULL)
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

- Month: Month of record

- Year: Year of record

- NAO: North Atlantic Oscillation

## References

<https://www.ncdc.noaa.gov/teleconnections/nao/>

## Examples

``` r
if (FALSE) { # \dontrun{
nao <- download_nao()
} # }
```
