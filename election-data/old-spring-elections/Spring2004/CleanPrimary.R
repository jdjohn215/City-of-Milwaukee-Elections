rm(list = ls())

library(pdftools)
library(tidyverse)
library(tesseract)
options(dplyr.print_max = 30)

primary2004 <- pdf_text("election-data/old-spring-elections/Spring2004/Mayor - 2004 Primary.pdf")
cat(primary2004[1])

dist1 <- read_table(primary2004[1], skip = 10, col_names = F, n_max = 21) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 3, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "sandy_folaron", "frank_cumberbatch",
                    "thomas_g_nardelli", "vince_bobot", "marvin_pratt",
                    "tom_barrett", "leon_todd", "david_clarke", "john_v_pitta",
                    "arthur_l_jones", "write_in")) %>%
  mutate(district = 1) %>%
  select(district, ward, everything())

dist2 <- read_table(primary2004[2], skip = 11, col_names = F, n_max = 21) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "sandy_folaron", "frank_cumberbatch",
                    "thomas_g_nardelli", "vince_bobot", "marvin_pratt",
                    "tom_barrett", "leon_todd", "david_clarke", "john_v_pitta",
                    "arthur_l_jones", "write_in")) %>%
  mutate(district = 2) %>%
  select(district, ward, everything())

dist3 <- read_table(primary2004[3], skip = 11, col_names = F, n_max = 21) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "sandy_folaron", "frank_cumberbatch",
                    "thomas_g_nardelli", "vince_bobot", "marvin_pratt",
                    "tom_barrett", "leon_todd", "david_clarke", "john_v_pitta",
                    "arthur_l_jones", "write_in")) %>%
  mutate(district = 3) %>%
  select(district, ward, everything()) %>%
  # munge
  mutate(sandy_folaron = str_replace(sandy_folaron, "3G", "36"),
         thomas_g_nardelli = str_replace(thomas_g_nardelli, "G", "6"))

dist4 <- read_table(primary2004[4], skip = 9, col_names = F, n_max = 19) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "sandy_folaron", "frank_cumberbatch",
                    "thomas_g_nardelli", "vince_bobot", "marvin_pratt",
                    "tom_barrett", "leon_todd", "david_clarke", "john_v_pitta",
                    "arthur_l_jones", "write_in")) %>%
  mutate(district = 4) %>%
  select(district, ward, everything())

dist5 <- read_table(primary2004[5], skip = 12, col_names = F, n_max = 25) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 3, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~"),
         string = str_squish(string)) %>%
  # munge
  mutate(string = str_replace(string, "7&", "75")) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "sandy_folaron", "frank_cumberbatch",
                    "thomas_g_nardelli", "vince_bobot", "marvin_pratt",
                    "tom_barrett", "leon_todd", "david_clarke", "john_v_pitta",
                    "arthur_l_jones", "write_in")) %>%
  mutate(district = 5) %>%
  select(district, ward, everything())

dist6 <- read_table(primary2004[6], skip = 11, col_names = F, n_max = 24) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "sandy_folaron", "frank_cumberbatch",
                    "thomas_g_nardelli", "vince_bobot", "marvin_pratt",
                    "tom_barrett", "leon_todd", "david_clarke", "john_v_pitta",
                    "arthur_l_jones", "write_in")) %>%
  mutate(district = 6) %>%
  select(district, ward, everything())

dist7 <- read_table(primary2004[7], skip = 11, col_names = F, n_max = 20) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 3, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "sandy_folaron", "frank_cumberbatch",
                    "thomas_g_nardelli", "vince_bobot", "marvin_pratt",
                    "tom_barrett", "leon_todd", "david_clarke", "john_v_pitta",
                    "arthur_l_jones", "write_in")) %>%
  mutate(district = 7) %>%
  select(district, ward, everything()) %>%
  # munge
  mutate(tom_barrett = str_replace(tom_barrett, coll("7?"), "78"))

dist8 <- read_table(primary2004[8], skip = 11, col_names = F, n_max = 18) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "sandy_folaron", "frank_cumberbatch",
                    "thomas_g_nardelli", "vince_bobot", "marvin_pratt",
                    "tom_barrett", "leon_todd", "david_clarke", "john_v_pitta",
                    "arthur_l_jones", "write_in")) %>%
  mutate(district = 8) %>%
  select(district, ward, everything()) %>%
  # munge
  mutate(tom_barrett = str_replace(tom_barrett, "us", "118"))

dist9 <- read_table(primary2004[9], skip = 10, col_names = F, n_max = 19) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 3, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'"),
         string = str_squish(string)) %>%
  # munge
  mutate(string = str_replace(string, coll("26^"), "264")) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "sandy_folaron", "frank_cumberbatch",
                    "thomas_g_nardelli", "vince_bobot", "marvin_pratt",
                    "tom_barrett", "leon_todd", "david_clarke", "john_v_pitta",
                    "arthur_l_jones", "write_in")) %>%
  mutate(district = 9) %>%
  select(district, ward, everything())

dist10 <- read_table(primary2004[10], skip = 11, col_names = F, n_max = 23) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'|,"),
         string = str_squish(string)) %>%
  # munge
  mutate(string = str_replace(string, "i2i", "121")) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "sandy_folaron", "frank_cumberbatch",
                    "thomas_g_nardelli", "vince_bobot", "marvin_pratt",
                    "tom_barrett", "leon_todd", "david_clarke", "john_v_pitta",
                    "arthur_l_jones", "write_in")) %>%
  mutate(district = 10) %>%
  select(district, ward, everything())

dist11 <- read_table(primary2004[11], skip = 11, col_names = F, n_max = 21) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 3, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'|,|[:)]"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "sandy_folaron", "frank_cumberbatch",
                    "thomas_g_nardelli", "vince_bobot", "marvin_pratt",
                    "tom_barrett", "leon_todd", "david_clarke", "john_v_pitta",
                    "arthur_l_jones", "write_in")) %>%
  mutate(district = 11) %>%
  select(district, ward, everything())

dist12 <- read_table(primary2004[12], skip = 11, col_names = F, n_max = 18) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'|,|[:)]"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "sandy_folaron", "frank_cumberbatch",
                    "thomas_g_nardelli", "vince_bobot", "marvin_pratt",
                    "tom_barrett", "leon_todd", "david_clarke", "john_v_pitta",
                    "arthur_l_jones", "write_in")) %>%
  mutate(district = 12) %>%
  select(district, ward, everything())

dist13 <- read_table(primary2004[13], skip = 10, col_names = F, n_max = 21) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'|,|[:)]"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "sandy_folaron", "frank_cumberbatch",
                    "thomas_g_nardelli", "vince_bobot", "marvin_pratt",
                    "tom_barrett", "leon_todd", "david_clarke", "john_v_pitta",
                    "arthur_l_jones", "write_in")) %>%
  mutate(district = 13) %>%
  select(district, ward, everything())

dist14 <- read_table(primary2004[14], skip = 11, col_names = F, n_max = 25) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 2, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'|,|[:)]"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "sandy_folaron", "frank_cumberbatch",
                    "thomas_g_nardelli", "vince_bobot", "marvin_pratt",
                    "tom_barrett", "leon_todd", "david_clarke", "john_v_pitta",
                    "arthur_l_jones", "write_in")) %>%
  # munge
  mutate(john_v_pitta = replace(john_v_pitta, ward == "250", 1),
         arthur_l_jones = replace(arthur_l_jones, ward == "250", 2),
         arthur_l_jones = replace(arthur_l_jones, ward == "253", 1),
         write_in = replace(write_in, ward == "250", 0),
         last_num = str_replace(last_num, "612f", "612")) %>%
  filter(! ward %in% c("11", "2")) %>%
  mutate(district = 14) %>%
  select(district, ward, everything())

dist15 <- read_table(primary2004[15], skip = 11, col_names = F, n_max = 20) %>%
  unite(col = "string", sep = " ") %>%
  mutate(string = ifelse(row_number() == 1, word(string, 3, -1), string),
         string = str_remove_all(string, "\\bNA\\b"),
         string = str_remove_all(string, "-|[.]|~|'|,|[:)]"),
         string = str_squish(string)) %>%
  separate(string, sep = " ",
           into = c("ward", "last_num", "sandy_folaron", "frank_cumberbatch",
                    "thomas_g_nardelli", "vince_bobot", "marvin_pratt",
                    "tom_barrett", "leon_todd", "david_clarke", "john_v_pitta",
                    "arthur_l_jones", "write_in")) %>%
  mutate(district = 15) %>%
  # munge
  mutate(ward = str_replace(ward, "3CQ", "300"),
         ward = str_replace(ward, "3G3", "303"),
         last_num = replace(last_num, ward == "305", "281")) %>%
  select(district, ward, everything())

all.pages <- bind_rows(dist1, dist2, dist3, dist4, dist5, dist6, dist7,
                       dist8, dist9, dist10, dist11, dist12, dist13,
                       dist14, dist15) %>%
  mutate_all(as.numeric)

# it matches
# https://city.milwaukee.gov/February1720041719.htm#.XN29CetKg_U
all.pages %>%
  summarise(across(where(is.numeric), sum)) %>%
  glimpse()

write_csv(all.pages, "election-data/old-spring-elections/mayor-city-of-milwaukee_2004primary.csv")
