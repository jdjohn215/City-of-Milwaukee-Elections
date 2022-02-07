rm(list = ls())

library(tidyverse)
library(sf)

ward.shp <- st_read("boundaries/CityofMilwaukeeWards2021.geojson") %>%
  mutate(ward_2021 = as.numeric(ward_2021))
reg.voters <- read_csv("reg-voters/CityOfMilwaukee_RegisteredVoters_01-01-2022.csv") %>%
  rename(ward_2021 = ward)
demographics <- read_csv("census-data/MilwaukeeWards2021_Demographics.csv")

ward.stats <- ward.shp %>%
  inner_join(demographics) %>%
  inner_join(reg.voters) %>%
  mutate(rv_vap = (reg_voters/vap)*100)
summary(ward.stats$rv_vap)

# candidate wards
dimitrijevic.area <- ward.shp %>%
  filter(ward_2021 %in% read_rds("misc/DimitrijevicWards.rds")) %>%
  summarise()
johnson.area <- ward.shp %>%
  filter(ward_2021 %in% read_rds("misc/JohnsonWards.rds")) %>%
  summarise()
donovan.area <- ward.shp %>%
  filter(ward_2021 %in% read_rds("misc/DonovanWards.rds")) %>%
  summarise()
taylor.area <- ward.shp %>%
  filter(ward_2021 %in% read_rds("misc/TaylorWards.rds")) %>%
  summarise()

# old election results
old.elections <- read_csv("election-data/SpringElectionsIn2021Wards.csv")
mayor.primary.2020 <- old.elections %>%
  filter(race == "PRIMARY",
         office == "MAYOR",
         year == 2020) %>%
  group_by(ward2021) %>%
  mutate(pct = (ballots/sum(ballots))*100) %>%
  ungroup() %>%
  mutate(preference = str_to_title(word(preference, -1))) %>%
  filter(preference %in% c("Taylor", "Zielinski", "Barrett")) %>%
  select(ward2021, preference, pct) %>%
  pivot_wider(names_from = preference, values_from = pct) %>%
  rename(ward_2021 = ward2021) %>%
  inner_join(ward.shp) %>%
  st_as_sf()

 tm_shape(mayor.primary.2020) +
  tm_fill(col = "Taylor", palette = "Greens", style = "cont",
          breaks = c(0, 20, 40, 60, 80)) +
  tm_shape(taylor.area) +
  tm_borders(lwd = 2, col = "black")
 tm_shape(mayor.primary.2020) +
   tm_fill(col = "Barrett", palette = "Greens", style = "cont",
           breaks = c(0, 20, 40, 60, 80))
 tm_shape(mayor.primary.2020) +
   tm_fill(col = "Zielinski", palette = "Greens", style = "cont",
           breaks = c(0, 20, 40, 60, 80)) +
   tm_shape(dimitrijevic.area) +
   tm_borders(lwd = 2, col = "black")


tm_shape(ward.stats) +
  tm_fill(col = "rv_vap", style = "cont") +
  tm_shape(dimitrijevic.area) +
  tm_borders(lwd = 2, col = "black") +
  tm_shape(johnson.area) +
  tm_borders(lwd = 2, col = "black") +
  tm_shape(donovan.area) +
  tm_borders(lwd = 2, col = "black") +
  tm_shape(taylor.area) +
  tm_borders(lwd = 2, col = "black")
