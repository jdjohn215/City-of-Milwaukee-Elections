Ward-level Milwaukee election data
================
2022-01-28

This directory, `election-data` contains City of Milwaukee ward-level
election results from selected elections.

Two kinds of elections are available.

-   **November general elections** for statewide and state legislative
    offices are sourced from the
    [LTSB](https://data-ltsb.opendata.arcgis.com/). Wisconsin clerks
    publish election results in “reporting units,” which are
    combinations of wards. The LTSB disaggregates these into individual
    wards. In Milwaukee, this step is unnecessary because each reporting
    unit consists of a single ward.
-   **Spring general and primary elections.** These are nonpartisan with
    the exception of the Republican and Democratic presidential
    preference contests. I have collected these results from various
    source files available in `election-data/old-spring-elections`.

Each kind of election results are available in **two different kinds of
wards.**

-   The original wards used in each election through 2021 are the
    “**2011 wards.**”
-   New wards were drawn in 2021. I provide older election results
    disaggregated into **2021 wards** using a block-level adult
    population crosswalk. See `R/BuildWardVAPCrosswalk.R` for details.
    The crosswalk itself is at
    `census-data/Ward2011_to_Ward2021_ByVAP.csv`.

The four block-level files are available in this directory. They are:

-   `election-data/LTSB-2012-20-election-data-with-2011-wards.csv`
-   `election-data/LTSB-2012-20-election-data-with-2021-wards.csv`
-   `election-data/SpringElectionsIn2011Wards.csv`
-   `election-data/SpringElectionsIn2021Wards.csv`

Here are the spring general and primary elections currently included in
the dataset. I hope to add more in the future.

| year | office                 | race               |
|-----:|:-----------------------|:-------------------|
| 2016 | COUNTY EXECUTIVE       | GENERAL            |
| 2016 | MAYOR                  | GENERAL            |
| 2016 | MAYOR                  | PRIMARY            |
| 2016 | PRESIDENTIAL CANDIDATE | DEMOCRATIC PRIMARY |
| 2016 | PRESIDENTIAL CANDIDATE | REPUBLICAN PRIMARY |
| 2016 | SCOWIS                 | GENERAL            |
| 2018 | SCOWIS                 | GENERAL            |
| 2019 | SCOWIS                 | GENERAL            |
| 2020 | COUNTY EXECUTIVE       | GENERAL            |
| 2020 | COUNTY EXECUTIVE       | PRIMARY            |
| 2020 | MAYOR                  | GENERAL            |
| 2020 | MAYOR                  | PRIMARY            |
| 2020 | PRESIDENTIAL CANDIDATE | DEMOCRATIC PRIMARY |
| 2020 | PRESIDENTIAL CANDIDATE | REPUBLICAN PRIMARY |
| 2020 | REFERENDUM             | MPS FUNDING        |
| 2020 | SCOWIS                 | GENERAL            |
| 2020 | SCOWIS                 | PRIMARY            |
