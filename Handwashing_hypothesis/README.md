---
editor_options: 
  markdown: 
    wrap: 72
---

## Data Overview: Vienna General Hospital Childbed Fever

Hungarian physician Dr. Ignaz Semmelweis worked at the Vienna General
Hospital with childbed fever patients. Childbed fever is a deadly
disease affecting women who have just given birth, and in the early
1840s, as many as 10% of the women giving birth died from it at the
Vienna General Hospital. Dr.Semmelweis discovered that it was the
contaminated hands of the doctors delivering the babies, and on June
1st, 1847, he decreed that everyone should wash their hands, an
unorthodox and controversial request; nobody in Vienna knew about
bacteria.

You will reanalyze the data that made Semmelweis discover the importance
of handwashing and its impact on the hospital.

## Dataset Description

The data is stored as two CSV files within the data folder.

**yearly_deaths_by_clinic.csv** contains the number of women giving
birth at the two clinics at the Vienna General Hospital between the
years 1841 and 1846.

| Column | Description |
|---|---|---|
| year | Years (1841-1846) |
| births | Number of births |
| deaths | Number of deaths |
| clinic | Clinic 1 or Clinic 2 |


**monthly_deaths.csv** contains data from 'Clinic 1' of the hospital
where most deaths occurred.
| Column | Description |
|---|---|
| date | Date (YYYY-MM-DD) |
| births | Number of births |
| deaths | Number of deaths |

## Project Instructions 
How much did handwashing reduce monthly death rates on average?

1. Load the CSV files into yearly and monthly data frames and check the data.

2. Add a proportion_deaths column to each df, calculating the proportion of deaths per number of births for each year 
in yearly and month in monthly.

3. Create two ggplot line plots: one for the yearly proportion of deaths and another for the monthly proportion of 
deaths. For the yearly plot, create a different colored line for each clinic.

4. Add a handwashing_started boolean column to monthly using June 1st, 1847 as the threshold; TRUE should mean that 
handwashing has started at the clinic. Plot the new df with different colored lines depending on handwashing_started.

5. Calculate the mean proportion of deaths before and after handwashing from the monthly data, and store the result as 
a 2x2 df named monthly_summary with the first column containing the handwashing_started groups and the second column 
having the mean proportion of deaths.

## Results
According to the results obtained, we note that Semmelweis' research shows that hand washing reduces the proportion of
deaths due to childbed fever.



