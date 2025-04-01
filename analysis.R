library(tidyverse)
library(knitr)

df <- read_csv("/Users/wangjingwen/Downloads/co-emissions-per-capita-vs-fossil-fuel-consumption-per-capita/co-emissions-per-capita-vs-fossil-fuel-consumption-per-capita.csv")
head(df)

View(df)

unique(df$Entity)
unique(df$Year)

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

kable(sapply(df, class))

head(df_new)

df_new1 <- df_new %>% filter(Year >= 2004 & Year <= 2023) %>% 
  mutate(Income_Classification = factor(`World Bank's income classification`)) %>% 
  rename(Annual_CO2_Emission_per_captial = "Annual CO₂ emissions (per capita)")
View(df_new1)

df_agg <- df_new1 %>%
  group_by(Year, Income_Classification) %>%
  summarize(
    Mean_CO2 = mean(Annual_CO2_Emission_per_captial, na.rm = TRUE),
    .groups = 'drop'
  ) 



#View(df_agg)


ggplot(df_agg, 
       aes(x = factor(Year), 
           y = Mean_CO2, 
           fill = Income_Classification)) +
  geom_bar(stat = "identity", 
           position = position_dodge2(preserve = "single", width = 0.9),
           width = 0.7) +
#  scale_fill_brewer(palette = "Set2") +  # 使用ColorBrewer配色
  labs(title = "Annual CO2 emissions (per capita)(2004-2023)",
       subtitle = "World Bank's income classification",
       x = "Year",
       y = "Annual CO2 emissions (per capita)",
       fill = "Income_Classification") +
#  theme_minimal(base_size = 12) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        legend.position = "top")  # 倾斜年份标签