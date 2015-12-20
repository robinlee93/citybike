library(ggplot2)
library(dplyr)
load("combined2014.RData")
load("summary2014.RData")

total <- summary2014 %>% group_by(date) %>% summarise(trips=sum(trips), totaltime=sum(totaltime))
comb_total <- inner_join(total, weather)

ggplot(data=comb_total, aes(`Mean TemperatureF`, trips))+
  geom_point()+
  scale_y_continuous(limits=c(0,40000), expand=c(0,0))+
  ggtitle("Number of trips per day in 2014")

m1 <- lm(data=comb_total, trips~`Mean TemperatureF`)

d <- ggplot(data=comb, aes(`Mean TemperatureF`, trips))+
  geom_point(alpha=.5)+
  scale_y_continuous(expand = c(0,5)) 

d + facet_grid(.~usertype, scales="free_y")
d + facet_grid(usertype ~ . , scales = "free_y")

m2 <-lm(data=comb, trips~`Mean TemperatureF`*usertype)
summary(m2)
# change in temp

m3 <-lm(data=comb, trips~`Mean TemperatureF`*usertype+tempdiff)
summary(m3)

# preciptation

m4 <- lm(data=comb, trips~`Mean TemperatureF`*usertype+PrecipitationIn)
summary(m4)

#recode rain as a dummy 
comb$precipitat <- comb$PrecipitationIn!=0
m5 <- lm(data=comb, trips~`Mean TemperatureF`*usertype+precipitat)
summary(m5)
# works better

# weekday
comb$weekday <- weekdays(comb$date)
comb$weekend <- comb$weekday=="Saturday"|comb$weekday=="Sunday"

m6 <- lm(data=comb, trips~`Mean TemperatureF`*usertype+precipitat+weekend)
summary(m6)

m7 <- lm(data=comb, trips~`Mean TemperatureF`*usertype+precipitat+weekend+weekend:usertype)
summary(m7)
## tempquadratic?

ggplot(data=comb_total, aes(`Mean TemperatureF`, trips))+
  geom_point()+
  scale_y_continuous(limits=c(0,40000), expand=c(0,0))+
  ggtitle("Number of trips per day in 2014")

m8<- glm(data=comb_total, trips~poly(`Mean TemperatureF`,2))

ggplot(data=comb_total, aes(`Max TemperatureF`, trips))+
  geom_point()
+
  scale_y_continuous(limits=c(0,40000), expand=c(0,0))+
  ggtitle("Number of trips per day in 2014")

