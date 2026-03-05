# Download Relative Oceanic Nino Index data

El Niño–Southern Oscillation (ENSO) is often characterized through the
use of sea surface temperature (SST) departures from their
climatological values, as in the Niño-3.4 index. However, this approach
is problematic in a changing climate when the climatology itself is
varying. To address this issue, van Oldenborgh et al. proposed a
relative Niño-3.4 SST index, which subtracts the tropical mean SST
anomaly from the Niño-3.4 index and multiplies by a scaling factor.

- The cold phase was defined as periods in which the RONI values within
  a sliding five-season window were all below −0.5 degC

- The warm phase was defined as periods in which the RONI values within
  a sliding five-season window were all above 0.5 degC

- The neutral phase was defined as the situation outside the definitions
  of warm phase and cold phase

## Usage

``` r
download_roni(use_cache = FALSE, file = NULL)
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

- Season: Season of record

- roni: Relative Oceanic Niño Index, using the 1991–2020 base period "3
  month running mean of ERSST.v5 SST anomalies in the Niño 3.4 region
  (5°N–5°S, 120°–170°W) with average tropical mean (20°N–20°S) SST
  anomalies subtracted. The difference is then adjusted so the variance
  equals the original Niño 3.4 index".

- Start_Month: Start month of record

- End_Month: End month of record

- phase: ENSO phase

## References

<https://www.cpc.ncep.noaa.gov/products/analysis_monitoring/enso/roni/#latest-data>
<https://journals.ametsoc.org/view/journals/clim/37/4/JCLI-D-23-0406.1.xml>

## Examples

``` r
if (FALSE) { # \dontrun{
roni <- download_roni()
} # }
```
