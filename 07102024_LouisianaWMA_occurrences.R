### Occurrence data for August 12-16 Louisiana Wildlife Management Areas ###

# Joyce, Maurepas Swamp and Sandy Hollow WMAs 

# Matt would also like to check out the Quercus oglethorpensis points near Forest, Mississippi in Bienville National Forest on his way. 

# download GBIF (Darwin Core format) occurrence data for Q. oglethorpensis

# download occurrence data of species in the WMAs and near the Bienville National Forest in Mississippi

# pull the GBIF occurrence data downloaded from GBIF as the text file and read it as a table 
# filters for download
    # preserved specimen, occurrence, human observation
    # United States
    # has coordinate true
    # has geospatial issue false
    # after 1965
  
#date downloaded, species, state abbreviations MS and LA
#GBIF_07122024_qoglethorpensis_MSLA <- read.delim("07122024_qoglethorpensis_GBIF_occurrence.txt", header = TRUE, sep = "\t", quote = "\"", 
                                       #       dec = ".", fill = TRUE, comment.char = "")
  
#name has date downloaded, species, state abbreviations MS and LA
Q_oglethorpensis_MSLA_GBIF_07122024_ <- read.delim("07122024_qoglethorpensis_GBIF_occurrence.txt", header = TRUE, sep = "\t", quote = "\"", 
                                                   dec = ".", fill = TRUE, comment.char = "")
polygon_MSLA_GBIF_07122024 <-   read.delim("07122024_GBIF_MS_LA_polygon.txt", header = TRUE, sep = "\t", quote = "\"", 
                                           dec = ".", fill = TRUE, comment.char = "")

# Use the coordinatecleaner package to clean downloads and upload where documentation specifies

############ BIEN occurrences ##############
# documentation available on CRAN network https://cran.r-project.org/web/packages/BIEN/BIEN.pdf

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

# counties to search
    # Tangipahoa and Ponchatoula for Joyce WMA, Laplace and Ruddock for Maurepas Swamp, Kentwood and New Zion for Sandy Hollow

# this is a big job and will take a few minutes 
# BIEN_LA_bystate <- BIEN_occurrence_state(country = "United States", state = "Louisiana", observation.type = TRUE, collection.info = TRUE)

LA_county_vector <- c("Tangipahoa", "Ponchatoula", "Laplace", "Ruddock", "Kentwood", "New Zion")
LA_state_vector <- c("Louisiana", "Louisiana", "Louisiana", "Louisiana", "Louisiana", "Louisiana")
LA_country_vector <- c("United States", "United States", "United States", "United States", "United States", "United States")

BIENcountyOccurrencesLA <- BIEN_occurrence_county(country = LA_country_vector, state = LA_state_vector, county = LA_county_vector, observation.type = TRUE)

BIEN_Q.oglethorpensis <- BIEN_occurrence_species(species = "Quercus oglethorpensis", collection.info = TRUE, observation.type = TRUE, natives.only = FALSE)

Quercus_box <- BIEN_occurrence_box(min.lat = 28, max.lat = 35, min.long = -94, max.long = -88, species = "Quercus oglethorpensis", collection.info = TRUE, observation.type = TRUE)

# Mississippi near Bienville National Forest
# Scott county, Forest, Pulaski, Wicker, Burns, Morton, Forkville, Buckleytown, Tanglewood

MS_counties <- c("Scott", "Forest", "Pulaski", "Wicker", "Burns", "Morton", "Forkville", "Buckleytown", "Tanglewood", "Hillsboro")
MS_country <- c("United States", "United States", "United States", "United States", "United States", "United States", "United States", "United States",
              "United States", "United States")
MS_state <- c("Mississippi", "Mississippi", "Mississippi", "Mississippi", "Mississippi", "Mississippi", 
              "Mississippi", "Mississippi", "Mississippi", "Mississippi")
BIENcountyOccurrencesMS <- BIEN_occurrence_county(country = MS_country, state = MS_state, county = MS_counties, observation.type = TRUE)

write.csv(BIENcountyOccurrencesLA, file = "BIEN_countyOccurrencesLA07252024.csv")
write.csv(BIENcountyOccurrencesMS, file = "BIEN_countyOccurrencesMS07252024.csv")

#### test preliminary conservation assessments with occurrence data
###this isn't available on CRAN right now because of rgeos and rgdal so we download from Github using devtools
install.packages("devtools")
devtools::install_github("gdauby/ConR")
require(ConR)
devtools::install_github("azizka/speciesgeocodeR")
library(speciesgeocodeR)
devtools::install_github("cran/rgeos")

#format the csv files for ConR, ddlat, ddlon, taxa

LAcountySpecies <- BIEN_countyOccurrencesLA07252024_ConRformat
MScountySpecies <- BIEN_countyOccurrencesMS07252024_ConRformat
Quercus_oglethorpensisGBIFoccurrences <- read.csv("GBIFQuercus_ogle_LA_MS07122024_ConRformat.csv")
QuercusEOO <- EOO.computing(Quercus_oglethorpensisGBIFoccurrences)
QuercusCriterionB <- criterion_B(x=Quercus_oglethorpensisGBIFoccurrences, 
                                 AOO = AOO.computing(Quercus_oglethorpensisGBIFoccurrences), 
                                 EOO = EOO.computing(Quercus_oglethorpensisGBIFoccurrences),
                                 DrawMap = TRUE, add.legend = TRUE)

EOO.hull <- EOO.computing(XY=Quercus_oglethorpensisGBIFoccurrences, export_shp = TRUE, write_shp = TRUE)
EOO.hull_MS <- EOO.computing(XY=MScountySpecies, export_shp = TRUE, write_shp = TRUE)
EOO.hull_LA <- EOO.computing(XY=LAcountySpecies, export_shp = TRUE, write_shp = TRUE)

#BIEN_ranges_species(species = "Quercus arkansana")


