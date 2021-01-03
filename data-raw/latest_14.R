## code to prepare `latest_14` dataset goes here
# Get latest 14-day cases and use as input 
library(dplyr)
load("data/latest_14.rda")
latest_irish_data = read.csv("https://opendata.arcgis.com/datasets/d8eb52d56273413b84b0187a4e9117be_0.csv") %>% 
  mutate(Date = as.Date(Date)) %>% 
  arrange(Date) %>% 
  mutate(DailyCases = ConfirmedCovidCases) %>% 
  mutate(last14 = RcppRoll::roll_sum(DailyCases, 14, align = "right", 
                           fill = 0)) %>% 
  ungroup() %>% 
  arrange(desc(Date))
latest = latest_irish_data$last14[1]
if (identical(latest_14, latest)) {
  usethis::ui_done("Nothing to update")
  deploy_app <- 0
} else{
  usethis::use_data(latest_14, overwrite = TRUE)
  usethis::ui_done("dataset updated!")
  deploy_app <- 1
}