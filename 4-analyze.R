library(ggplot2)
library(dplyr)
load("combined2014.RData")
subscribers <- comb %>% filter(usertype=="Subscriber")

ggplot(data=comb, aes(`Mean TemperatureF`, trips))+
  geom_point()+
  scale_y_continuous(limits=c(0,36000), expand=c(0,0))
