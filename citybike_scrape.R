# Date: 10/15/2015
# Download city bike system data, but only the trip data

# Step 1: Scarpe files links
# 
# I refer to Hadley's rvest github page and utilize selector gadget in Chrome to help find the html node

library(rvest)
base.url <- html("https://www.citibikenyc.com/system-data")
data <- base.url %>% 
  html_nodes("#system-data li a") 

# choose again, specify hyperlink
links <- base.url %>%
  html_nodes("#system-data li a") %>%
  html_attr("href")

# i want trip data
trip_links <- links[1:27]

# Step 2: Download zip files
# the last link is google drive. that might be tricky
for(i in 1:length(trip_links)){
  time = substr(basename(trip_links[i]),1,6)
  download.file(trip_links[i],paste0("bikedata/",time,".zip"), method = "libcurl")
}
