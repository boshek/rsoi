
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

download_enso <- function() {
    enso <- read.table("http://www.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt", header = TRUE)
    enso <- dplyr::tbl_df(enso)
    enso
}


library(tidyverse)
library(lubridate)

download_enso() %>%
  mutate(Date = ymd(paste0(YR,"-",MON,"-1"))) %>%
  filter(YR >= 2003) %>%
  mutate(variance = ifelse(ANOM > 0,"POS", ifelse(ANOM < 0, "NEG", "NEUTRAL"))) %>%
  ggplot(aes(x = Date, y = ANOM)) +
  geom_bar(aes(fill = variance), stat = 'identity') +
  geom_path() +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y")


enso %>%
  mutate(Date = ymd(paste0(YR,"-",MON,"-1"))) %>%
  filter(YR >= 2003) %>%
  group_by(YR) %>%
  summarise(ANOM = mean(ANOM, na.rm = TRUE)) %>%
  mutate(variance = ifelse(ANOM > 0,"POS", ifelse(ANOM < 0, "NEG", "NEUTRAL"))) %>%
  ggplot(aes(x = YR, y = ANOM)) +
  geom_bar(aes(fill = variance), stat = 'identity') +
  scale_x_continuous(breaks = seq(2003, 2016, by = 1))

