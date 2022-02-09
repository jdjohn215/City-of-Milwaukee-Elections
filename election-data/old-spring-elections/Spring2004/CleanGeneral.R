rm(list = ls())

library(pdftools)
library(tidyverse)
library(tesseract)
options(dplyr.print_max = 30)

general2004 <- pdf_text("election-data/old-spring-elections/Spring2004/Mayor - 2004 General.pdf")
cat(general2004[1])

dist1 <- read_table(general2004[1], skip = 6, col_names = F, n_max = 21) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "marvin_pratt", "tom_barrett",
                    "write_in")) %>%
  mutate(district = 1) %>%
  select(district, ward, everything())

dist2 <- read_table(general2004[2], skip = 6, col_names = F, n_max = 21) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "marvin_pratt", "tom_barrett",
                    "write_in")) %>%
  mutate(district = 2) %>%
  select(district, ward, everything())

dist3 <- read_table(general2004[3], skip = 6, col_names = F, n_max = 21) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "marvin_pratt", "tom_barrett",
                    "write_in")) %>%
  mutate(district = 3) %>%
  select(district, ward, everything())

dist4 <- read_table(general2004[4], skip = 6, col_names = F, n_max = 19) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "marvin_pratt", "tom_barrett",
                    "write_in")) %>%
  mutate(district = 4) %>%
  select(district, ward, everything())

dist5 <- read_table(general2004[5], skip = 6, col_names = F, n_max = 25) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "marvin_pratt", "tom_barrett",
                    "write_in")) %>%
  mutate(district = 5) %>%
  select(district, ward, everything())

dist6 <- read_table(general2004[6], skip = 6, col_names = F, n_max = 24) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "marvin_pratt", "tom_barrett",
                    "write_in")) %>%
  mutate(district = 6) %>%
  select(district, ward, everything())

dist7 <- read_table(general2004[7], skip = 6, col_names = F, n_max = 20) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "marvin_pratt", "tom_barrett",
                    "write_in")) %>%
  mutate(district = 7) %>%
  select(district, ward, everything())

dist8 <- read_table(general2004[8], skip = 6, col_names = F, n_max = 18) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "marvin_pratt", "tom_barrett",
                    "write_in")) %>%
  mutate(district = 8) %>%
  select(district, ward, everything())

dist9 <- read_table(general2004[9], skip = 7, col_names = F, n_max = 19) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "marvin_pratt", "tom_barrett",
                    "write_in")) %>%
  mutate(district = 9) %>%
  select(district, ward, everything())

dist10 <- read_table(general2004[10], skip = 6, col_names = F, n_max = 23) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'|,"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "marvin_pratt", "tom_barrett",
                    "write_in")) %>%
  mutate(district = 10) %>%
  select(district, ward, everything())

dist11 <- read_table(general2004[11], skip = 6, col_names = F, n_max = 21) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'|,|[:)]"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "marvin_pratt", "tom_barrett",
                    "write_in")) %>%
  mutate(district = 11) %>%
  select(district, ward, everything())

dist12 <- read_table(general2004[12], skip = 6, col_names = F, n_max = 18) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'|,|[:)]"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "marvin_pratt", "tom_barrett",
                    "write_in")) %>%
  mutate(district = 12) %>%
  select(district, ward, everything())

dist13 <- read_table(general2004[13], skip = 6, col_names = F, n_max = 21) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'|,|[:)]"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "marvin_pratt", "tom_barrett",
                    "write_in")) %>%
  mutate(district = 13) %>%
  select(district, ward, everything())

dist14 <- read_table(general2004[14], skip = 7, col_names = F, n_max = 23) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'|,|[:)]"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "marvin_pratt", "tom_barrett",
                    "write_in")) %>%
  mutate(district = 14) %>%
  select(district, ward, everything())

dist15 <- read_table(general2004[15], skip = 6, col_names = F, n_max = 20) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'|,|[:)]"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "marvin_pratt", "tom_barrett",
                    "write_in")) %>%
  mutate(district = 15) %>%
  select(district, ward, everything())

all.pages <- bind_rows(dist1, dist2, dist3, dist4, dist5, dist6, dist7,
                       dist8, dist9, dist10, dist11, dist12, dist13,
                       dist14, dist15) %>%
  mutate_all(as.numeric)

# it matches
# https://city.milwaukee.gov/April620041718.htm#.XN29rOtKg_V
all.pages %>%
  summarise(across(where(is.numeric), sum)) %>%
  glimpse()

write_csv(all.pages, "election-data/old-spring-elections/mayor-city-of-milwaukee_2004general.csv")

