rm(list = ls())

library(pdftools)
library(tidyverse)
library(tesseract)
options(dplyr.print_max = 60)

general2004 <- pdf_text("election-data/old-spring-elections/Spring2008/GeneralMayor.pdf")
cat(general2004[1])

page1 <- read_delim(general2004[1], skip = 14, col_names = F, n_max = 55, delim = ";") %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = str_squish(string)) %>%
  mutate(ward = word(string, 1),
         votes = word(string, -3, -1)) %>%
  select(-string) %>%
  separate(votes, into = c("tom_barrett", "andrew_j_shaw", "write_in"),
           sep = " ", convert = T)
page2 <- read_delim(general2004[2], skip = 17, col_names = F, n_max = 55, delim = ";") %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = str_squish(string)) %>%
  mutate(ward = str_sub(string, 1, 4),
         votes = word(string, -3, -1)) %>%
  select(-string) %>%
  separate(votes, into = c("tom_barrett", "andrew_j_shaw", "write_in"),
           sep = " ", convert = T) %>%
  # munge
  mutate(ward = str_replace(ward, "OllO", "0110"),
         tom_barrett = replace(tom_barrett, ward == "0059", "296"),
         tom_barrett = replace(tom_barrett, ward == "0060", "138"),
         andrew_j_shaw = replace(andrew_j_shaw, ward %in% c("0056", "0080"), "58"),
         andrew_j_shaw = replace(andrew_j_shaw, ward %in% c("0063"), "8"),
         write_in = str_replace_all(write_in, "I|i", "1"),
         write_in = str_replace(write_in, "·J", "1")) %>%
  mutate(tom_barrett = as.numeric(tom_barrett),
         andrew_j_shaw = as.numeric(andrew_j_shaw),
         write_in = as.numeric(write_in))
page3 <- read_delim(general2004[3], skip = 14, col_names = F, n_max = 55, delim = ";") %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = str_squish(string)) %>%
  mutate(ward = str_sub(string, 1, 4),
         votes = word(string, -3, -1)) %>%
  select(-string) %>%
  separate(votes, into = c("tom_barrett", "andrew_j_shaw", "write_in"),
           sep = " ", convert = T) %>%
  # munge
  mutate(andrew_j_shaw = as.numeric(str_replace(andrew_j_shaw, "Bl", "81")))
page4 <- read_delim(general2004[4], skip = 15, col_names = F, n_max = 55, delim = ";") %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = str_squish(string)) %>%
  mutate(ward = str_sub(string, 1, 4),
         votes = word(string, -3, -1)) %>%
  select(-string) %>%
  separate(votes, into = c("tom_barrett", "andrew_j_shaw", "write_in"),
           sep = " ", convert = T) %>%
  # munge
  mutate(write_in = as.numeric(str_replace_all(write_in, "l", "1")))
page5 <- read_delim(general2004[5], skip = 19, col_names = F, n_max = 55, delim = ";") %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = str_squish(string)) %>%
  mutate(ward = str_sub(string, 1, 4),
         votes = word(string, -3, -1)) %>%
  select(-string) %>%
  separate(votes, into = c("tom_barrett", "andrew_j_shaw", "write_in"),
           sep = " ", convert = T) %>%
  # munge
  mutate(write_in = as.numeric(str_replace_all(write_in, "I", "1")))
page6 <- read_delim(general2004[6], skip = 16, col_names = F, n_max = 37, delim = ";") %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = str_squish(string)) %>%
  mutate(ward = str_sub(string, 1, 4),
         votes = word(string, -3, -1)) %>%
  select(-string) %>%
  separate(votes, into = c("tom_barrett", "andrew_j_shaw", "write_in"),
           sep = " ", convert = T)

all.pages <- bind_rows(page1, page2, page3, page4, page5, page6)

# it matches
all.pages %>%
  summarise(across(where(is.numeric), sum))

write_csv(all.pages, "election-data/old-spring-elections/mayor-city-of-milwaukee_2008general.csv")
