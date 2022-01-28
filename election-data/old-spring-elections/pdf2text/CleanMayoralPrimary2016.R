rm(list = ls())

library(pdftools)
library(tidyverse)
library(tesseract)


page28.raw <- pdf_text("election-data/old-spring-elections/pdf2text/Election54thBiennialReport 28OCR.pdf")
cat(page28.raw)
page28 <- read_table(page28.raw, skip = 15, col_names = F) %>%
  unite(col = "string", sep = " ") %>%
  separate(string, into = c("ward", "string"), sep = 4) %>%
  mutate(string = str_squish(string),
         ward_name = word(string, 1, 3)) %>%
  mutate(string = str_squish(str_remove(string, ward_name))) %>%
  select(ward, ward_name, string) %>%
  separate(string, into = c("joe davis, sr.", "tom barrett", "james methu",
                            "bob donovan", "write-in", "extra"), convert = T) %>%
  select(-extra)

page29.raw <- pdf_text("election-data/old-spring-elections/pdf2text/Election54thBiennialReport 29OCR.pdf")
cat(page29.raw)
page29 <- read_table(page29.raw, skip = 17, col_names = F) %>%
  unite(col = "string", sep = " ") %>%
  separate(string, into = c("ward", "string"), sep = 4) %>%
  mutate(string = str_squish(string),
         ward_name = word(string, 1, 3)) %>%
  mutate(string = str_squish(str_remove(string, ward_name))) %>%
  select(ward, ward_name, string) %>%
  separate(string, into = c("joe davis, sr.", "tom barrett", "james methu",
                            "bob donovan", "write-in", "extra"), convert = T) %>%
  select(-extra)

page30.raw <- pdf_text("election-data/old-spring-elections/pdf2text/Election54thBiennialReport 30OCR.pdf")
cat(page30.raw)
page30 <- read_table(page30.raw, skip = 18, col_names = F) %>%
  unite(col = "string", sep = " ") %>%
  separate(string, into = c("ward", "string"), sep = 4) %>%
  mutate(string = str_squish(string),
         ward_name = word(string, 1, 3)) %>%
  mutate(string = str_squish(str_remove(string, ward_name))) %>%
  select(ward, ward_name, string) %>%
  separate(string, into = c("joe davis, sr.", "tom barrett", "james methu",
                            "bob donovan", "write-in", "extra"), convert = T) %>%
  select(-extra)

page31.raw <- pdf_text("election-data/old-spring-elections/pdf2text/Election54thBiennialReport 31OCR.pdf")
cat(page31.raw)
page31 <- read_table(page31.raw, skip = 17, col_names = F) %>%
  unite(col = "string", sep = " ") %>%
  separate(string, into = c("ward", "string"), sep = 4) %>%
  mutate(string = str_squish(string),
         ward_name = word(string, 1, 3)) %>%
  mutate(string = str_squish(str_remove(string, ward_name))) %>%
  select(ward, ward_name, string) %>%
  separate(string, into = c("joe davis, sr.", "tom barrett", "james methu",
                            "bob donovan", "write-in", "extra"), convert = T) %>%
  select(-extra)

page32.raw <- pdf_text("election-data/old-spring-elections/pdf2text/Election54thBiennialReport 32OCR.pdf")
cat(page32.raw)
page32 <- read_table(page32.raw, skip = 18, col_names = F) %>%
  unite(col = "string", sep = " ") %>%
  separate(string, into = c("ward", "string"), sep = 4) %>%
  mutate(string = str_squish(string),
         ward_name = word(string, 1, 3)) %>%
  mutate(string = str_squish(str_remove(string, ward_name))) %>%
  select(ward, ward_name, string) %>%
  separate(string, into = c("joe davis, sr.", "tom barrett", "james methu",
                            "bob donovan", "write-in", "extra"), convert = T) %>%
  select(-extra)

page33.raw <- pdf_text("election-data/old-spring-elections/pdf2text/Election54thBiennialReport 33OCR.pdf")
cat(page33.raw)
page33 <- read_table(page33.raw, skip = 16, col_names = F) %>%
  unite(col = "string", sep = " ") %>%
  mutate(next_string = lead(string, 1)) %>%
  mutate(string = str_squish(str_remove_all(string, "NA")),
         next_string = str_squish(str_remove_all(next_string, "NA"))) %>%
  mutate(full_string = case_when(
    str_sub(next_string, 1, 4) == "Ward" ~ paste0(string, next_string),
    str_sub(next_string, 1, 9) == "Milwaukee" ~ paste(string, word(next_string, 2, -1)),
    TRUE ~ string
  )) %>%
  filter(str_sub(full_string, 1, 1) == "0") %>%
  select(string = full_string) %>%
  separate(string, into = c("ward", "string"), sep = 4) %>%
  mutate(string = str_squish(string),
         ward_name = word(string, 1, 3)) %>%
  mutate(string = str_squish(str_remove(string, ward_name))) %>%
  select(ward, ward_name, string) %>%
  separate(string, into = c("joe davis, sr.", "tom barrett", "james methu",
                            "bob donovan", "write-in", "extra"), convert = T) %>%
  select(-extra) %>%
  # munge
  mutate(`write-in` = ifelse(ward == "0306", 1, `write-in`),
         `write-in` = ifelse(ward == "0288", 1, `write-in`),
         `write-in` = ifelse(ward == "0294", 1, `write-in`),
         `write-in` = ifelse(is.na(`write-in`), 0, `write-in`))

page34.raw <- pdf_text("election-data/old-spring-elections/pdf2text/Election54thBiennialReport 34OCR.pdf")
cat(page34.raw)
page34 <- tibble(ward = c("0325", "0326", "0327"),
                 ward_name = c("City of MilwaukeeWard325", "City of MilwaukeeWard326", "City of MilwaukeeWard327"),
                 `joe davis, sr.` = c(7,0,0),
                 `tom barrett` = c(64, 0, 0),
                 `james methu` = c(2, 0, 0),
                 `bob donovan` = c(23, 0, 0),
                 `write-in` = c(0, 0, 0))

all.pages <- bind_rows(page28, page29, page30, page31, page32, page33, page34) %>%
  mutate(ward_name = str_replace(ward_name, "Ward", " Ward "))

all.pages %>%
  summarise(across(where(is.numeric), sum))

write_csv(all.pages, "election-data/old-spring-elections/milwaukee-mayor-primary-2016.csv")
