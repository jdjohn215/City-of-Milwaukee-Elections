# Documentation

For all files, the projected CRS is WGS 84 / Pseudo-Mercator (4326).

The files are retrieved from various sources. Conversion from shapefile to GeoJSON format was done using the R {{sf}} package.

* 2021 voting wards are from the [Legislative Technology Services Bureau (LTSB) Local Redistricting 2021 - Municipal Wards file](https://data-ltsb.opendata.arcgis.com/datasets/local-redistricting-2021-municipal-wards/explore?location=44.786342%2C-89.826710%2C7.54)
* 2012 voting wards are from the [City of Milwaukee Open Data Portal](https://data.milwaukee.gov/dataset/voting-wards)
* 2001 voting wards are from the LTSB's Election Data, Wisconsin 2002 file, retrieved from [*GeoData@Wisconsin*](https://geodata.wisc.edu/catalog/7A9AD151-70BA-41F0-92D3-9CF396EEAFF3) and held by the UW-Madison Robinson Map Library.
* Milwaukee City Limits are from the [City of Milwaukee Open Data Portal](https://data.milwaukee.gov/dataset/corporate-boundary).

To the best of my knowledge, the City of Milwaukee wards drawn in 2001 were not altered until 2012. Likewise, the wards drawn in 2012 were used without alteration until they were replaced with the wards drawn in 2021.