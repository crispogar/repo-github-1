#Se nos pide buscar los casos en Madrid, filtrar por fecha y agruparlos por fecha diaria.

library(readr)
library(tidyverse)
library(readxl)
library(httr)

datos <- read.csv("https://cnecovid.isciii.es/covid19/resources/casos_hosp_uci_def_sexo_edad_provres.csv",
                  na = "NC")

datos_madrid <- 
  datos |> 
  drop_na(sexo) |> 
  filter(provincia_iso == "M" & fecha <= "2020-12-31" &
           sexo != "NC") |> 
  select(fecha, sexo, grupo_edad, num_casos) |> 
  summarise(num_casos = sum(num_casos), .by = c(fecha, sexo))

write_csv(datos_madrid, file = "./datos_madrid.csv")

