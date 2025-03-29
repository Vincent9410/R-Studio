library(tidyverse)

df <- read_csv("/Users/wangjingwen/Downloads/co-emissions-per-capita-vs-fossil-fuel-consumption-per-capita/co-emissions-per-capita-vs-fossil-fuel-consumption-per-capita.csv")
head(df)

View(df)

df_new <- df %>% filter(!is.na(`Annual CO₂ emissions (per capita)`)) %>% 
  filter(!is.na(`Fossil fuels per capita (kWh)`)) %>% 
  filter(!is.na(`Population (historical)`)) %>% 
  filter(!is.na(`World Bank's income classification`))

head(df_new)


