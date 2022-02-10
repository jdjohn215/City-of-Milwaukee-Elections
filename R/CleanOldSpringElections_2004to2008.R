rm(list = ls())

library(tidyverse)

################################################################################
# 2004 races
mayor.2004 <- read_csv("election-data/old-spring-elections/mayor-city-of-milwaukee_2004general.csv") %>%
  pivot_longer(cols = -c(ward, district, last_num), names_to = "preference", values_to = "ballots") %>%
  mutate(office = "mayor",
         race = "general",
         year = 2004) %>%
  mutate(preference = str_to_upper(str_replace_all(preference, "_", " ")))
mayor.2004.primary <- read_csv("election-data/old-spring-elections/mayor-city-of-milwaukee_2004primary.csv") %>%
  pivot_longer(cols = -c(ward, district, last_num), names_to = "preference", values_to = "ballots") %>%
  mutate(office = "mayor",
         race = "primary",
         year = 2004) %>%
  mutate(preference = str_to_upper(str_replace_all(preference, "_", " ")))

################################################################################
# 2008 races
# There was no primary
mayor.2008 <- read_csv("election-data/old-spring-elections/mayor-city-of-milwaukee_2008general.csv") %>%
  pivot_longer(cols = -ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "mayor",
         race = "general",
         year = 2008) %>%
  mutate(preference = str_to_upper(str_replace_all(preference, "_", " ")),
         ward = as.numeric(ward))

all.races <- bind_rows(mget(ls())) %>%
  select(ward, year, race, office, preference, ballots) %>%
  mutate(across(where(is.character), str_to_upper)) %>%
  arrange(year, race, office, ward)
write_csv(all.races, "election-data/SpringElectionsIn2001Wards.csv")
