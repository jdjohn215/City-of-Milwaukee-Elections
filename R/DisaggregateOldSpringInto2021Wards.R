rm(list = ls())

library(tidyverse)

old.elections <- read_csv("election-data/SpringElectionsIn2011Wards.csv")
crosswalk <- read_csv("census-data/Ward2011_to_Ward2021_ByVAP.csv")

old.elections.in.2021.wards <- old.elections %>%
  rename(ward2011 = ward) %>%
  inner_join(crosswalk) %>%
  mutate(adj_ballots = ballots * prop_of_2011) %>%
  group_by(ward2021, year, race, office, preference) %>%
  summarise(ballots = sum(adj_ballots)) %>%
  ungroup()

# verify that totals match
compare <- full_join(
  old.elections %>%
    group_by(year, race, office, preference) %>%
    summarise(original = sum(ballots)),
  old.elections.in.2021.wards %>%
    group_by(year, race, office, preference) %>%
    summarise(crosswalked = sum(ballots))
) %>%
  mutate(match = original == crosswalked)
table(compare$match)

write_csv(old.elections.in.2021.wards, "election-data/SpringElectionsIn2021Wards.csv")
