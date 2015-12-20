library(readr)
library(dplyr)
library(ggplot2)

load("summary2014.RData")
weather <- read_csv("2014weather.csv")
weather$PrecipitationIn <- as.numeric(weather$PrecipitationIn)
diff = tail(weather$`Mean TemperatureF`, -1) - head(weather$`Mean TemperatureF`, -1)
diff = c(2,diff)
weather$tempdiff = diff

colnames(weather)[1] <- "date"
summary2014$date <- as.Date(summary2014$date, format="%Y%m%d")
comb <- inner_join(summary2014, weather)

save(comb, file="combined2014.RData")
save(summary2014, file="summary2014.RData")