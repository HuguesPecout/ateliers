# PREPARATION SAMPLE COVID DATA

# Import database
BD_stringency_index <- read.csv("https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest.csv")

# Conversion date
BD_stringency_index <- transform(BD_stringency_index, Date = as.Date(as.character(BD_stringency_index$Date), "%Y%m%d"))

# Séléction variables
stringency_index<- BD_stringency_index[ ,c(1,2,5,33:35,6,8,10,12,14,16,18,20,21,23:26,28:31) ]

# Séléction temporelle
stringency_index <- stringency_index[stringency_index$Date >= "2020-02-01" & stringency_index$Date <= "2020-06-30",]

# Séléction géographique
# Import code ISO3 des pays de l'UE
UE <- c("AUT", "BEL", "BGR", "HRV", "CYP", "CZE", "DNK", "EST", "FIN", 
        "FRA", "DEU", "GRC", "HUN", "IRL", "ITA", "LVA", "LTU", "LUX", 
        "MLT", "NLD", "POL", "PRT", "ROU", "SVK", "SVN", "ESP", "SWE","GBR")

stringency_index <- stringency_index[stringency_index$CountryCode %in% UE,]

# Enregistrement du sample
write.csv(stringency_index, "introduction a ggplot 2/data/stringency_index.csv", row.names = FALSE)
