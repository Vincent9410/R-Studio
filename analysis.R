library(tidyverse)
library(knitr)

df <- read_csv("/Users/wangjingwen/Downloads/co-emissions-per-capita-vs-fossil-fuel-consumption-per-capita/co-emissions-per-capita-vs-fossil-fuel-consumption-per-capita.csv")
head(df)

View(df)

df_new <- df %>% filter(!is.na(`Annual CO₂ emissions (per capita)`)) %>% 
  filter(!is.na(`Fossil fuels per capita (kWh)`)) %>% 
  filter(!is.na(`Population (historical)`)) %>% 
  filter(!is.na(`World Bank's income classification`))

head(df_new)

variable_desc <- data_frame (
  Variable = c("Entity", "Code", "Year", 
               "Annual CO₂ emissions (per capita", "Fossil fuels per capita (kWh)", 
               "Population", "World Bank's income classification"),
  Description = c("国家/地区名称", 
                  "ISO 3字母国家代码", 
                  "数据记录年份", 
                  "人均年度二氧化碳排放量（吨）", 
                  "人均化石燃料消耗量（千瓦时）", 
                  "历史人口估计值", 
                  "世界银行收入分类")
)

knitr::kable(
  variable_desc,
  caption = "(\\#tab:variables)数据集变量说明：包含环境指标与人口统计的核心变量",
  col.names = c("变量名称", "变量描述"),
  align = c("l", "c"),
  booktabs = TRUE
) 