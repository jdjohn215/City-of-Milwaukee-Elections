rm(list = ls())

library(tidyverse)

wards.crosswalk <- read_csv("census-data/Ward2011_to_Ward2021_ByVAP.csv")

# available here: https://data-ltsb.opendata.arcgis.com/datasets/LTSB::2012-2020-election-data-with-2020-wards/about
ltsb.orig <- sf::st_read("~/Dropbox/Projects/SHPfiles/2012-2020_Election_Data_with_2020_Wards/_2012_2020_Election_Datawith2020_Wards.shp") %>%
  sf::st_set_geometry(NULL) %>%
  # filter for City of Milwauke
  filter(COUSUBFP == "53000") %>%
  tibble()
write_csv(ltsb.orig, "election-data/LTSB_2012-20-election-data-with-2011-wards.csv")

# Disaggregate LTBS ward statistics into new wards based on VAP overlap
ltsb.wards2021 <- ltsb.orig %>%
  select(-c(1:15, 17:34), - starts_with("shape")) %>%
  rename(ward2011 = STR_WARDS) %>%
  mutate(ward2011 = as.numeric(ward2011)) %>%
  pivot_longer(cols = -ward2011, values_to = "votes") %>%
  inner_join(wards.crosswalk) %>%
  mutate(adj_votes = votes * prop_of_2011) %>%
  group_by(ward2021, name) %>%
  summarise(votes = sum(adj_votes)) %>%
  ungroup() %>%
  pivot_wider(names_from = name, values_from = votes)

# make sure the totals match
compare <- full_join(
  ltsb.orig %>%
    select(any_of(names(ltsb.wards2021))) %>%
    pivot_longer(cols = everything()) %>%
    group_by(name) %>%
    summarise(original = sum(value)),
  ltsb.wards2021 %>%
    select(-ward2021) %>%
    pivot_longer(cols = everything()) %>%
    group_by(name) %>%
    summarise(crosswalked = sum(value))
) %>%
  mutate(match = original == crosswalked)
table(compare$match)

write_csv(ltsb.wards2021, "election-data/LTSB_2012-20-election-data-with-2021-wards.csv")
