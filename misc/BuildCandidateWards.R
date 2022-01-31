rm(list = ls())

library(tidyverse)

blocks <- read_csv("census-data/MilwaukeeBlocks2020.csv") %>%
  select(GEOID, ward_2021, SLDL, SLDU, aldermanic_2012, vap)

# Dimitrijevic  - 14th Aldermanic district
# Johnson       - 2nd Aldermanic district
# Donovan       - 8th Aldermanic district
# Taylor        - 4th State Senate District

# wards where they represent(ed) a majority of VAP
dimitrijevic.wards <- blocks %>%
  group_by(ward_2021) %>%
  summarise(vap_in_14th = sum(vap[aldermanic_2012 == 14])/sum(vap)) %>%
  filter(vap_in_14th > 0.5) %>% pull(ward_2021)
johnson.wards <- blocks %>%
  group_by(ward_2021) %>%
  summarise(vap_in_2nd = sum(vap[aldermanic_2012 == 2])/sum(vap)) %>%
  filter(vap_in_2nd > 0.5) %>% pull(ward_2021)
donovan.wards <- blocks %>%
  group_by(ward_2021) %>%
  summarise(vap_in_8th = sum(vap[aldermanic_2012 == 8])/sum(vap)) %>%
  filter(vap_in_8th > 0.5) %>% pull(ward_2021)
taylor.wards <- blocks %>%
  group_by(ward_2021) %>%
  summarise(vap_in_4th = sum(vap[SLDU == 4])/sum(vap)) %>%
  filter(vap_in_4th > 0.5) %>% pull(ward_2021)

saveRDS(dimitrijevic.wards, "misc/DimitrijevicWards.rds")
saveRDS(johnson.wards, "misc/JohnsonWards.rds")
saveRDS(donovan.wards, "misc/DonovanWards.rds")
saveRDS(taylor.wards, "misc/TaylorWards.rds")