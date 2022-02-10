rm(list = ls())

library(tidyverse)

# tom_barret - ieshuh_griffin - edward_c_mcdonald - write_in
primary <- readxl::read_excel("election-data/old-spring-elections/Spring2012/PrimaryAndGeneralMayor.xlsx",
                              sheet = 1, skip = 1, col_names = "string") %>%
  mutate(ward = word(string, 1),
         votes = word(string, -4, -1)) %>%
  select(ward, votes) %>%
  separate(votes, into = c("tom_barrett", "ieshuh_griffin", "edward_c_mcdonald", "write_in"),
           sep = " ", convert = T)
primary %>% summarise(across(where(is.numeric), sum)) # matches
write_csv(primary, "election-data/old-spring-elections/mayor-city-of-milwaukee_2012primary.csv")

# tom_barret - edward_c_mcdonald - write_in
general <- readxl::read_excel("election-data/old-spring-elections/Spring2012/PrimaryAndGeneralMayor.xlsx",
                              sheet = 2, skip = 1, col_names = "string") %>%
  mutate(ward = word(string, 1),
         votes = word(string, -3, -1)) %>%
  select(ward, votes) %>%
  separate(votes, into = c("tom_barrett", "edward_c_mcdonald", "write_in"),
           sep = " ", convert = T)
general %>% summarise(across(where(is.numeric), sum)) # matches
write_csv(general, "election-data/old-spring-elections/mayor-city-of-milwaukee_2012general.csv")
