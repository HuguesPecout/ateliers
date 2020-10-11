## code to prepare `prepa_data_covid` dataset goes here

library(sf)
# PREPARATION SAMPLE COVID DATA

# Import database
BD_stringency_index <- read.csv("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest.csv")

# Conversion date
BD_stringency_index <- transform(BD_stringency_index, Date = as.Date(as.character(BD_stringency_index$Date), "%Y%m%d"))

# Supression lignes pays membres de GBR
BD_stringency_index <- BD_stringency_index[BD_stringency_index$RegionName == "",]

# Séléction variables
stringency_index<- BD_stringency_index[ ,c(1,2,5,33:35,6,8,10,12,14,16,18,20,21,23:26,28:31) ]

# Séléction temporelle
stringency_index <- stringency_index[stringency_index$Date >= "2020-02-01" & stringency_index$Date <= "2020-06-30",]

# Séléction géographique
# Import code ISO3 des pays européenne

eu <- read_sf("https://raw.githubusercontent.com/leakyMirror/map-of-europe/master/GeoJSON/europe.geojson")

stringency_index <- stringency_index[stringency_index$CountryCode %in% eu$ISO3,]


# Enregistrement du sample
write.csv(stringency_index, "inst/extdata/stringency_index.csv", row.names = FALSE)


