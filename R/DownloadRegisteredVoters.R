rm(list = ls())

library(tidyverse)

# Download the registered voters file
tmpfile <- tempfile()
download.file("https://elections.wi.gov/sites/elections/files/2022-01/RegisteredVotersByWard_01-01-2022.xlsx",
              tmpfile)
wi.regvoters <- readxl::read_excel(tmpfile)
unlink(tmpfile)

mke.regvoters <- wi.regvoters %>%
  filter(str_detect(Muni, "CITY OF MILWAUKEE")) %>%
  mutate(ward = word(ward, -1)) %>%
  select(ward, reg_voters = `Voter Count`) %>%
  mutate(date = "2022-01-01",
         ward = as.numeric(ward)) %>%
  arrange(ward)
write_csv(mke.regvoters, "reg-voters/CityOfMilwaukee_RegisteredVoters_01-01-2022.csv")
