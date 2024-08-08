<<<<<<< HEAD
################### BIEN occurrence data downloads ###########


# download 
# BIEN_occurrence_state, extracts species occurrence records by state
# BIEN_Occurrence_county, same but by county
# Political division (or political division code) spelling needs to be exact and case-sensitive, see
# BIEN_metadata_list_political_names for a list of political divisions and associated codes.
# US FIA coordinates have been fuzzed and swapped, for more details see: https://www.fia.fs.fed.us/toolsdata/spatial/Policy/index.php
# This function requires you supply either 1) a single country with one or more states, or 2) vectors
# of equal length for each political level.
# BIEN_plot_state
# BIEN_ranges_box, extracts range maps for a specified bounding box

library(BIEN)
library(knitr) 
library(maps)
library(ape)
library(sf)

# we can download species occurrence for counties, states, or by a vector of species
# read the csv of species names from the Targeting DB of approved, non-restricted species
#create the vector of species from the csv downloaded from the Targeting DB
taxa_list <- read.csv("SouthernAppalachia_taxaList.csv", stringsAsFactors = FALSE)
species_vector <- taxa_list$Taxon
species_vector <- as.character(species_vector)
head(species_vector)

#might be too big
#species_occ <- BIEN_occurrence_species(species = species_vector, observation.type = TRUE,
 #                                      political.boundaries = TRUE, 
  #                                     collection.info = TRUE)

# download by county name

TN_county_vector <- c('Polk', 'Monroe', 'Blount', 'Graham', 'Mcminn', 'Fannin',
                      'Loudin', 'Cocke', 'Sevier', 'Greene', 'Johnson', 
                      'Carter', 'Unicoi', 'Washington', 'Hamblen',
                      'Hawkins', 'Jefferson', 'Knox')
TN_state_vector <- c('Tennessee', 'Tennessee','Tennessee','Tennessee','Tennessee',
                     'Tennessee','Tennessee','Tennessee','Tennessee','Tennessee',
                     'Tennessee','Tennessee','Tennessee','Tennessee','Tennessee',
                     'Tennessee','Tennessee','Tennessee')
TN_country_vector <- c('United States', 'United States','United States','United States','United States',
                       'United States','United States','United States','United States','United States',
                       'United States','United States','United States','United States','United States',
                       'United States','United States','United States')
TN_species_by_county <- BIEN_occurrence_county(country = TN_country_vector, state = TN_state_vector, county = TN_county_vector, 
                       observation.type = TRUE, political.boundaries = TRUE, collection.info = TRUE)
write.csv(TN_species_by_county, file = "bienTN_speciesByCounty.csv")
head(TN_species_by_county)

# read the species list downloaded from the ArcGIS map of Targeted species

arcgisTNspeciesList <- read.csv("arcgis_tennessee_exportCSV.csv")
bienTN_speciesByCounty <- read.csv("bienTN_speciesByCounty.csv")
=======
################### BIEN occurrence data downloads ###########


# download 
# BIEN_occurrence_state, extracts species occurrence records by state
# BIEN_Occurrence_county, same but by county
# Political division (or political division code) spelling needs to be exact and case-sensitive, see
# BIEN_metadata_list_political_names for a list of political divisions and associated codes.
# US FIA coordinates have been fuzzed and swapped, for more details see: https://www.fia.fs.fed.us/toolsdata/spatial/Policy/index.php
# This function requires you supply either 1) a single country with one or more states, or 2) vectors
# of equal length for each political level.
# BIEN_plot_state
# BIEN_ranges_box, extracts range maps for a specified bounding box

library(BIEN)
library(knitr) 
library(maps)
library(ape)
library(sf)

# we can download species occurrence for counties, states, or by a vector of species
# read the csv of species names from the Targeting DB of approved, non-restricted species
#create the vector of species from the csv downloaded from the Targeting DB
taxa_list <- read.csv("SouthernAppalachia_taxaList.csv", stringsAsFactors = FALSE)
species_vector <- taxa_list$Taxon
species_vector <- as.character(species_vector)
head(species_vector)

#might be too big
#species_occ <- BIEN_occurrence_species(species = species_vector, observation.type = TRUE,
 #                                      political.boundaries = TRUE, 
  #                                     collection.info = TRUE)

# download by county name

TN_county_vector <- c('Polk', 'Monroe', 'Blount', 'Graham', 'Mcminn', 'Fannin',
                      'Loudin', 'Cocke', 'Sevier', 'Greene', 'Johnson', 
                      'Carter', 'Unicoi', 'Washington', 'Hamblen',
                      'Hawkins', 'Jefferson', 'Knox')
TN_state_vector <- c('Tennessee', 'Tennessee','Tennessee','Tennessee','Tennessee',
                     'Tennessee','Tennessee','Tennessee','Tennessee','Tennessee',
                     'Tennessee','Tennessee','Tennessee','Tennessee','Tennessee',
                     'Tennessee','Tennessee','Tennessee')
TN_country_vector <- c('United States', 'United States','United States','United States','United States',
                       'United States','United States','United States','United States','United States',
                       'United States','United States','United States','United States','United States',
                       'United States','United States','United States')
TN_species_by_county <- BIEN_occurrence_county(country = TN_country_vector, state = TN_state_vector, county = TN_county_vector, 
                       observation.type = TRUE, political.boundaries = TRUE, collection.info = TRUE)

arcgisTNspeciesList <- read.csv("arcgis_tennessee_exportCSV.csv")
view(arcgisTNspeciesList)
bienTN_speciesByCounty <- read.csv("bienTN_speciesByCounty.csv")
view(bienTN_speciesByCounty)
View(arcgisTNspeciesList)
view(bienTN_speciesByCounty)


