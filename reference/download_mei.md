# Download Multivariate ENSO Index Version 2 (MEI.v2)

MEI.v2 is based on EOF analysis of level pressure, sea surface
temperature, surface zonal winds, surface meridional winds, and Outgoing
Longwave Radiation. The analysis is conducted for 12 partially
overlapping 2-month "seasons".

Warm phase is defined as MEI index greater or equal to 0.5. Cold phase
is defined as MEI index lesser or equal to -0.5.

## Usage

``` r
download_mei(use_cache = FALSE, file = NULL)
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

- Month: Bi-moonthly season of record

- Year: Year of record

- MEI: Multivariate ENSO Index Version 2

- Phase: ENSO phase

## References

<https://psl.noaa.gov/enso/mei/>

## Examples

``` r
if (FALSE) { # \dontrun{
mei <- download_mei()
} # }
```
