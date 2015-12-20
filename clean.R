library(readr)
library(dplyr)


aggrdaily <- function(x){
  x$date <- format(x$starttime, "%Y%m%d")
  
  summary <- x %>% group_by(date, usertype) %>%
    summarize(trips = n(), totaltime=sum(tripduration))
  return(summary)
}

temp = list.files("bikedata/",pattern="*.csv")
myfiles = lapply(paste("bikedata/",temp, sep=""), read_csv)

for(i in 9:12){
myfiles[[i]]$starttime <- as.POSIXct(myfiles[[i]]$starttime, format="%m/%d/%Y %H:%M:%S")
}

summary <- list()
for(i in 1:12){
  summary[[i]] <- aggrdaily(myfiles[[i]])
}

summary2014 <- data.frame()
for(i in 1:12){
  summary2014 <- rbind(summary2014,summary[[i]])
}

write_csv(summary2014, "summary2014.csv")
triplevel <- head(myfiles[[1]])
save(triplevel, file = "preview1.RData")
save(summary2014, file = "summary2014.RData")
