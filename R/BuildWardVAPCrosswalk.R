rm(list = ls())

library(tidyverse)

# 2020 Census blocks with 2011 ward assignment, plus POP and VAP
blocks <- read_csv("census-data/MilwaukeeBlocks2020With2011WardAssignments.csv",
                   col_types = "cccnnnnnnnnnnnnnnnnnn") %>%
  mutate(ward2011 = as.numeric(ward)) %>%
  select(-ward)

# assignment of 2020 blocks to 2021 wards
block.assignment.2021 <- readxl::read_excel("~/Dropbox/Projects/2022/January/spring-primary-2022/census-data/2021 Blocks Assigned to Voting Wards - Plan B.xlsx",
                                       skip = 1, col_types = c("text", "numeric")) %>%
  janitor::clean_names() %>%
  rename(GEOID = 1, ward2021 = voting_ward)

# which blocks are unassigned?
# they all have 0 pop
blocks %>% filter(! GEOID %in% block.assignment.2021$GEOID) %>% select(GEOID, pop)

# What proportion of the 2011 ward's VAP is in each 2021 ward?
ward.vap.crosswalk <- blocks %>%
  filter(vap > 0) %>%
  inner_join(block.assignment.2021) %>%
  group_by(ward2011, ward2021) %>%
  summarise(vap = sum(vap)) %>%
  group_by(ward2011) %>%
  mutate(prop_of_2011 = vap/sum(vap)) %>%
  ungroup()
write_csv(ward.vap.crosswalk, "census-data/Ward2011_to_Ward2021_ByVAP.csv")
