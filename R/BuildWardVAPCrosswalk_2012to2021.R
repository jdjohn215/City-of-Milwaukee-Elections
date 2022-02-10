rm(list = ls())

library(tidyverse)

# 2020 Census blocks with 2012 ward assignment, plus POP and VAP
blocks <- read_csv("census-data/MilwaukeeBlocks2020With2012WardAssignments.csv",
                   col_types = "cccnnnnnnnnnnnnnnnnnn") %>%
  mutate(ward2012 = as.numeric(ward)) %>%
  select(-ward)

# assignment of 2020 blocks to 2021 wards
block.assignment.2021 <- readxl::read_excel("census-data/2021 Blocks Assigned to Voting Wards - Plan B.xlsx",
                                       skip = 1, col_types = c("text", "numeric")) %>%
  janitor::clean_names() %>%
  rename(GEOID = 1, ward2021 = voting_ward)

# which blocks are unassigned?
# they all have 0 pop
blocks %>% filter(! GEOID %in% block.assignment.2021$GEOID) %>% select(GEOID, pop)

# What proportion of the 2012 ward's VAP is in each 2021 ward?
ward.vap.crosswalk <- blocks %>%
  filter(vap > 0) %>%
  inner_join(block.assignment.2021) %>%
  group_by(ward2012, ward2021) %>%
  summarise(vap = sum(vap)) %>%
  group_by(ward2012) %>%
  mutate(prop_of_2012 = vap/sum(vap)) %>%
  ungroup()
write_csv(ward.vap.crosswalk, "census-data/Ward2012_to_Ward2021_ByVAP.csv")
