rm(list = ls())

library(tidyverse)

block.stats <- read_csv("census-data/MilwaukeeBlocks2020.csv")

ward.demographics.2021 <- block.stats %>%
  select(ward_2021, starts_with("pop"), starts_with("vap")) %>%
  filter(!is.na(ward_2021)) %>%
  group_by(ward_2021) %>%
  summarise(across(where(is.numeric), sum)) %>%
  ungroup()
write_csv(ward.demographics.2021, "census-data/MilwaukeeWards2021_Demographics.csv")
