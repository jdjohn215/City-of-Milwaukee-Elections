library(tidyverse)
library(tmap)
library(sf)

ald.dist <- st_read("boundaries/CityofMilwaukeeAldermanicDistrict2022.geojson")

base1 <- tmaptools::read_osm(ald.dist, zoom = 13, type = "stamen-toner")

map1 <- tm_shape(base1, raster.downsample = F) +
  tm_rgb() +
  tm_shape(ald.dist) +
  tm_borders(col = "black", lwd = 2) +
  tm_fill(col = "MAP_COLORS", alpha = 0.5) +
  tm_text(text = "aldermanic_2022", size = 2)
tmap_save(map1, "reference-maps/AldermanicDistricts2022.pdf", height = 17)
