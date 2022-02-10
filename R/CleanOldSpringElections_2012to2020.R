rm(list = ls())

library(tidyverse)

################################################################################
# 2020 races
county.exec.2020 <- read_csv("election-data/old-spring-elections/county-executive_2020.csv") %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "county executive",
         race = "general",
         year = 2020) %>%
  rename(ward = Ward)
county.exec.2020.primary <- read_csv("election-data/old-spring-elections/county-executive_2020primary.csv") %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "county executive",
         race = "primary",
         year = 2020) %>%
  rename(ward = Ward)
mayor.2020 <- read_csv("election-data/old-spring-elections/mayor-city-of-milwaukee_2020.csv") %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "mayor",
         race = "general",
         year = 2020) %>%
  rename(ward = Ward)
mayor.2020.primary <- read_csv("election-data/old-spring-elections/mayor-city-of-milwaukee_2020primary.csv") %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "mayor",
         race = "primary",
         year = 2020) %>%
  rename(ward = Ward)
scowis.2020 <- read_csv("election-data/old-spring-elections/justice-of-the-supreme-court_2020.csv") %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "scowis",
         race = "general",
         year = 2020) %>%
  rename(ward = Ward)
scowis.2020.primary <- read_csv("election-data/old-spring-elections/justice-of-the-supreme-court_2020primary.csv") %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "scowis",
         race = "primary",
         year = 2020) %>%
  rename(ward = Ward)
dem.pres.2020 <- read_csv("election-data/old-spring-elections/democratic-president-of-the-united-states_2020.csv") %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "presidential candidate",
         race = "democratic primary",
         year = 2020) %>%
  rename(ward = Ward)
rep.pres.2020 <- read_csv("election-data/old-spring-elections/republican-president-of-the-united-states_2020.csv") %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "presidential candidate",
         race = "republican primary",
         year = 2020) %>%
  rename(ward = Ward)
mps.referendum.2020 <- read_csv("election-data/old-spring-elections/milwaukee-public-schools-referendum_2020.csv",
                                skip = 1) %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "referendum",
         race = "mps funding",
         year = 2020) %>%
  rename(ward = Ward)

################################################################################
# 2019 races
##  there was no primary for this SCOWIS election
scowis.2019 <- readxl::read_excel("election-data/old-spring-elections/2019_spring-election-results_master-file.xlsx",
                                  sheet = 2) %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "scowis",
         race = "general",
         year = 2019) %>%
  rename(ward = Ward)

################################################################################
# 2018 races
#   Don't have the file for this primary at this time
scowis.2018 <- readxl::read_excel("election-data/old-spring-elections/2018-spring-election-results-master.xls",
                             sheet = 27) %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "scowis",
         race = "general",
         year = 2018) %>%
  rename(ward = Ward)

################################################################################
# 2016 races
mayor.2016 <- read_csv("election-data/old-spring-elections/mayor-milwaukee_2016.csv") %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "mayor",
         race = "general",
         year = 2016) %>%
  rename(ward = Ward)
county.exec.2016 <- read_csv("election-data/old-spring-elections/county-executive_apr5_2016.csv") %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "county executive",
         race = "general",
         year = 2016) %>%
  rename(ward = Ward)
mayor.2016.primary <- read_csv("election-data/old-spring-elections/milwaukee-mayor-primary-2016.csv") %>%
  select(-ward_name) %>%
  pivot_longer(cols = -ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "mayor",
         race = "primary",
         year = 2016) %>%
  mutate(ward = as.numeric(ward))
dem.pres.2016 <- read_csv("election-data/old-spring-elections/president-of-the-united-states-democratic_apr052016_.csv") %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "presidential candidate",
         race = "democratic primary",
         year = 2016) %>%
  rename(ward = Ward)
rep.pres.2016 <- read_csv("election-data/old-spring-elections/president-of-the-united-states-republican_apr052016_.csv") %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "presidential candidate",
         race = "republican primary",
         year = 2016) %>%
  rename(ward = Ward)
scowis.2016 <- read_csv("election-data/old-spring-elections/justice-of-the-supreme-court_apr052016.csv") %>%
  pivot_longer(cols = -Ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "scowis",
         race = "general",
         year = 2016) %>%
  rename(ward = Ward)

################################################################################
# 2012 races
mayor.2012 <- read_csv("election-data/old-spring-elections/mayor-city-of-milwaukee_2012general.csv") %>%
  pivot_longer(cols = -ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "mayor",
         race = "general",
         year = 2012) %>%
  mutate(preference = str_to_upper(str_replace_all(preference, "_", " ")),
         ward = as.numeric(ward))
mayor.2012.primary <- read_csv("election-data/old-spring-elections/mayor-city-of-milwaukee_2012primary.csv") %>%
  pivot_longer(cols = -ward, names_to = "preference", values_to = "ballots") %>%
  mutate(office = "mayor",
         race = "primary",
         year = 2012) %>%
  mutate(preference = str_to_upper(str_replace_all(preference, "_", " ")),
         ward = as.numeric(ward))

# combine all races
all.races <- bind_rows(mget(ls())) %>%
  select(ward, year, race, office, preference, ballots) %>%
  mutate(across(where(is.character), str_to_upper)) %>%
  arrange(year, race, office, ward)

write_csv(all.races, "election-data/SpringElectionsIn2012Wards.csv")
