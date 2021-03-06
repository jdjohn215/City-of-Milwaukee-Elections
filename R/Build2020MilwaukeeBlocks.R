rm(list = ls())

library(tidyverse)
library(PL94171)

# available locally
pl_raw <- pl_read("~/Dropbox/Projects/2021/August/WI_Census/wi2020.pl")

pl.vtd <- pl_subset(pl_raw, "700")

mke.vtd <- pl.vtd %>%
  filter(str_sub(NAME, 1, 13) == "Milwaukee - C") %>%
  mutate(ward_2012 = word(NAME, -1)) %>%
  select(vtd = VTD, ward_2012)

pl.blocks <- pl_subset(pl_raw, sumlev = "750")

mke.blocks <- pl.blocks %>%
  filter(COUSUB == "53000") %>%
  pl_select_standard() %>%
  inner_join(mke.vtd) %>%
  inner_join(pl.blocks %>% select(GEOID, SLDL = SLDL18, SLDU = SLDU18)) %>%
  select(GEOID, SLDL, SLDU, vtd, ward_2012, starts_with("pop"), starts_with("vap"))

# add aldermanic districts
aldermanic.2012 <- sf::st_read("boundaries/CityofMilwaukeeWards2012.geojson") %>%
  sf::st_set_geometry(NULL) %>%
  mutate(ward_2012 = str_pad(ward_2012, width = 4, side = "left", pad = "0"))

# add wards 2021
wards.2021 <- readxl::read_excel("census-data/2021 Blocks Assigned to Voting Wards - Plan B.xlsx",
                                 skip = 2, col_names = c("GEOID", "ward_2021"),
                                 col_types = c("text","numeric"))

mke.blocks <- mke.blocks <- mke.blocks %>%
  inner_join(aldermanic.2012) %>%
  left_join(wards.2021) %>%
  mutate(SLDL = as.numeric(SLDL),
         SLDU = as.numeric(SLDU)) %>%
  select(GEOID, SLDL, SLDU, vtd, aldermanic_2012, ward_2012, ward_2021, everything())

write_csv(mke.blocks, "census-data/MilwaukeeBlocks2020.csv")
