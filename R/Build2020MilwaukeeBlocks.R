rm(list = ls())

library(tidyverse)
library(PL94171)

# available locally
pl_raw <- pl_read("~/Dropbox/Projects/2021/August/WI_Census/wi2020.pl")

pl.vtd <- pl_subset(pl_raw, "700")

mke.vtd <- pl.vtd %>%
  filter(str_sub(NAME, 1, 13) == "Milwaukee - C") %>%
  mutate(ward = word(NAME, -1)) %>%
  select(vtd = VTD, ward)

pl.blocks <- pl_subset(pl_raw, sumlev = "750")

mke.blocks <- pl.blocks %>%
  filter(COUSUB == "53000") %>%
  pl_select_standard() %>%
  inner_join(mke.vtd) %>%
  select(GEOID, vtd, ward, starts_with("pop"), starts_with("vap"))
write_csv(mke.blocks, "census-data/MilwaukeeBlocks2020With2012WardAssignments.csv")
