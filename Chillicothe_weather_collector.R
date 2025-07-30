library(httr)
library(tidyverse)
library(rvest)
library(xml2)

dir.create("data_Chillicothe", showWarnings = FALSE)

# === CONFIGURATION ===
weather_url_daily <- "http://166.193.33.75/?command=TableDisplay&table=b_Daily&records=24" 
weather_url_hourly <- "http://166.193.33.75/?command=TableDisplay&table=a_Hourly&records=24" 
status<-"http://166.193.33.75/?command=NewestRecord&table=Status"

today <- Sys.Date()
filename_daily <- paste0("weather_daily_24_record_", today, ".csv")
filename_hourly <- paste0("weather_hourly_24_record_", today, ".csv")
status_daily <- paste0("status_", today, ".csv")

# === FETCH Daily WEATHER DATA ===
res <- GET(weather_url_daily)
page <- read_html(weather_url_daily) #Creates an html document from URL
table <- html_table(page, fill = TRUE) #Parses tables into data frames
table1<-table[[1]]

write.csv(table1, file = file.path("data_Chillicothe",filename_daily),quote = F)

# === FETCH Hourly WEATHER DATA ===
res <- GET(weather_url_hourly)
page <- read_html(weather_url_hourly) #Creates an html document from URL
table <- html_table(page, fill = TRUE) #Parses tables into data frames
table1<-table[[1]]

write.csv(table1, file = file.path("data_Chillicothe",filename_hourly),quote = F)

# === FETCH Daily Status ===
res <- GET(status)
page <- read_html(status) #Creates an html document from URL
table <- html_table(page, fill = TRUE) #Parses tables into data frames
table1<-table[[1]]

write.csv(table1, file = file.path("data_Chillicothe",status_daily),quote = F)
battery<-table1[which(table1$X1=="Battery"),2]

Sys.setenv(JAVA_HOME = "C:/Program Files/Java/jdk-24")
# Sys.setenv(JAVA_HOME='C:\\Program Files(x86)\\Java\\jre1.8.0_461')
library(rJava)
library(mailR)

# === SEND EMAIL IF BATTERY IS LOW ===
sender <- "sayantans1994@gmail.com"  # Replace with a valid address
recipients <- c("hardevsinghdeocy@gmail.com")  # Replace with one or more valid addresses

if(battery<=12.15){
  send.mail(from = sender,
            to = recipients,
            # cc = c("CC Recipient <cc.recipient@gmail.com>"),
            # bcc = c("BCC Recipient <bcc.recipient@gmail.com>"),
            subject = "!!!!Battery Low at Chillicothe!!!",
            body = "!!!!Battery Low at Chillicothe!!!",
            smtp = list(
              host.name = "smtp.gmail.com", port = 587,
              user.name = "sayantans1994@gmail.com",
              passwd = "umglmzppvnmscxjz",
              tls = TRUE),
            authenticate = TRUE,
            send = TRUE)
  
}
