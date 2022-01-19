library(tidyverse)
library(sf)
library(leaflet)

wards2012 <- readRDS("boundaries/CityOfMilwaukeeWards2012.rds")
wards2021 <- readRDS("boundaries/CityOfMilwaukeeWards2021.rds")
city.limits <- read_rds("boundaries/CityLimits.rds")

leaflet(city.limits) %>% 
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(fillOpacity = 0.1, color = "black", fillColor = "black") %>%
  addPolygons(data = wards2012, fill = F, color = "blue", weight = 1,
              group = "2012") %>%
  addPolygons(data = wards2021, fill = F, color = "purple", weight = 1,
              group = "2021") %>%
  addLayersControl(baseGroups = c("2012", "2021"),
                   options = layersControlOptions(collapsed = F))
