# Récupération du fond de carte sans les DROM pour centrer les cartes sur les métropôles

library(dplyr)
library(lubridate)
library(flair)
library(tmap)
library(sf)
data("World")

stringency_index <- read.csv("https://raw.githubusercontent.com/MaelTheuliere/ggplot_shs/master/introduction%20a%20ggplot%202/data/stringency_index.csv") %>% 
  mutate(Date = ymd(Date))

world <- st_cast(World,"POLYGON") %>% 
  mutate(aire = st_area(.)) %>% 
  group_by(iso_a3) %>% 
  filter(aire == max(aire)) %>% 
  ungroup()
ue <- world %>% 
  filter(iso_a3 %in% unique(stringency_index$CountryCode)) %>% 
  select(iso_a3,name,pop_est)
save(ue,file = "introduction a ggplot 2/data/ue.RData")
