# Download North Pacific Gyre Oscillation data

North Pacific Gyre Oscillation data also known as the Victoria mode

## Usage

``` r
download_npgo(use_cache = FALSE, file = NULL)
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

- Year: Year of Record

- Month: Month of record

- NPGO: North Pacific Gyre Oscillation

## References

<https://www.oces.us/npgo/>

## Examples

``` r
if (FALSE) { # \dontrun{
npgo <- download_npgo()
} # }
```
