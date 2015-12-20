library(readr)
library(dplyr)
library(ggplot2)

load("summary2014.RData")
weather <- read_csv("2014weather.csv")
colnames(weather)[1] <- "date"
summary2014$date <- as.Date(summary2014$date, format="%Y%m%d")
comb <- inner_join(summary2014, weather)

save(comb, file="combined2014.RData")