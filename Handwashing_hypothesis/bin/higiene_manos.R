# Proyecto: Importancia del lavado de manos

# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Preparación del ambiente
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
## Limpieza del ambiente 
rm(list = ls())

## Cargar los paquetes a utilizar
library(tidyverse)


# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Load the CSV files into yearly and monthly data frames and check the data
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

## Cargar e inspeccionar las bases de datos
### Mensual 
monthly <- read_csv("../data/monthly_deaths.csv", show_col_types = FALSE)

monthly |> 
  glimpse()

### Anual 
yearly <- read_csv("../data/yearly_deaths_by_clinic.csv", show_col_types = FALSE)

yearly |> 
  glimpse()


# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Add a proportion_deaths column to each df
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

## Calcular el número de proporción de muertes (se calcula dividiendo el # de muertes entre el #nacimeintos * 100)
### Mensual 
death_proportion_month <- monthly |> 
  mutate(proportion_deaths = 100* (deaths/births), 
         date = ymd(date))

### Anual 
death_proportion_year <- yearly |> 
  mutate(proportion_deaths =100* (deaths/births), 
         year = as.Date(as.character(year), format="%Y"))


# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Create two ggplot line plots: 
# 1. For the yearly proportion of deaths. Create a different colored line for each clinic.
# 2. For the monthly proportion of deaths. 
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

## Crear las gráficas de proporción de muertes
### Mensual 
death_proportion_month |> 
  ggplot(aes(x=date, y= proportion_deaths))+
  geom_line()+ 
  labs(title= "Proportion of Deaths by Month", 
         x="Time (Months)", 
       y="Deaths proportion (%)")+
  theme_minimal()

### Anual 
death_proportion_year |> 
  ggplot(aes(x=year, y= proportion_deaths, color=clinic))+
  geom_line()+ 
  labs(title= "Proportion of Deaths by Year and Clinic", 
       x="Time (Months)", 
       y="Deaths proportion (%)")+
  theme_minimal()


# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Add a handwashing_started boolean column to monthly using June 1st, 1847 as the threshold;
# TRUE should mean that handwashing has started at the clinic. 
# Plot the new df with different colored lines depending on handwashing_started.
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
handwash_month <- death_proportion_month |> 
  mutate(handwashing_started = case_when(date >= as.Date("1847-06-01") ~ TRUE, 
                                 date < as.Date("1847-06-01") ~ FALSE))

handwash_month |> 
  ggplot(aes(x=date, y= proportion_deaths, color=handwashing_started))+
  geom_line()+ 
  labs(title= "Proportion of Deaths by Month", 
       x="Time (Months)", 
       y="Deaths proportion (%)")+
  theme_minimal()


# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Calculate the mean proportion of deaths before and after handwashing from the monthly data.  
# Store the result as a 2x2 df named monthly_summary with 
# the first column containing the handwashing_started groups and 
# the second column having the mean proportion of deaths.
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
monthly_summary <- handwash_month |> 
  group_by(handwashing_started) |> 
  summarise(mean_proportion_deaths=mean(proportion_deaths), .groups = "drop")

monthly_summary
