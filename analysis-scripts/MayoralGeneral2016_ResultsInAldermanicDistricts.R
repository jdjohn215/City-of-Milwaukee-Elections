rm(list = ls())

library(tidyverse)
library(sf)

orig <- read_csv("election-data/SpringElectionsIn2012Wards.csv")
wards.to.alds <- st_read("boundaries/CityOfMilwaukeeWards2012.geojson") %>%
  st_set_geometry(NULL)

totals <- orig %>%
  filter(office == "MAYOR",
         race == "GENERAL",
         year == 2016) %>%
  inner_join(wards.to.alds, by = c("ward" = "ward_2012")) %>%
  group_by(preference, aldermanic_2012) %>%
  summarise(votes = sum(ballots)) %>%
  ungroup() %>%
  group_by(aldermanic_2012) %>%
  mutate(ald_total = sum(votes)) %>%
  mutate(pct = round((votes/ald_total)*100))

totals %>%
  select(-votes) %>%
  pivot_wider(names_from = preference, values_from = pct)
totals.count <- totals %>%
  select(-pct) %>%
  pivot_wider(names_from = preference, values_from = votes)

sum(totals.count$ald_total)
sum(totals.count$`BOB DONOVAN`)
sum(totals.count$`TOM BARRETT`)
sum(totals.count$`WRITE-IN`)

write_csv("analysis-files/MayoralGeneral2016InAldermanicDistricts.csv")
