# Download Pacific Decadal Oscillation Data

The PDO index is derived as the leading principal of monthly SST
anomalies in the North Pacific Ocean, poleward of 20N. The monthly mean
global average SST anomalies are removed to separate this pattern of
variability from any "global warming" signal that may be present in the
data.

The NCEI PDO index is based on NOAA's extended reconstruction of SSTs
(ERSST Version 4). It is constructed by regressing the ERSST anomalies
against the Mantua PDO index for their overlap period, to compute a PDO
regression map for the North Pacific ERSST anomalies. The ERSST
anomalies are then projected onto that map to compute the NCEI index.
The NCEI PDO index closely follows the Mantua PDO index.

## Usage

``` r
download_pdo(use_cache = FALSE, file = NULL)
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

- PDO: Pacific Decadal Oscillation index

## References

Original PDO: <https://www.ncei.noaa.gov/access/monitoring/pdo/>

## Examples

``` r
if (FALSE) { # \dontrun{
pdo <- download_pdo()
} # }
```
