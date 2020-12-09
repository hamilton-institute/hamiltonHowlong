## code to prepare `latest_14` dataset goes here
# Get latest 14-day cases and use as input 
library(dplyr)
latest_irish_data = read.csv("https://opendata.arcgis.com/datasets/d8eb52d56273413b84b0187a4e9117be_0.csv") %>% 
  mutate(Date = as.Date(Date)) %>% 
  arrange(Date) %>% 
  mutate(DailyCases = ConfirmedCovidCases) %>% 
  mutate(last14 = RcppRoll::roll_sum(DailyCases, 14, align = "right", 
                           fill = 0)) %>% 
  ungroup() %>% 
  arrange(desc(Date))
latest_14 = latest_irish_data$last14[1]
usethis::use_data(latest_14, overwrite = TRUE)
