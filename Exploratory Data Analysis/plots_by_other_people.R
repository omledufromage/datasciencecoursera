# Interesting plots by other people. 

# t-miyazaki 
setwd("~/Desktop/Coursera") # Set working directory
library(tidyverse)
library(lubridate)
df <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- dmy_hms(df$DateTime)
df <- filter(df, date(DateTime) == as.Date("2007-02-01") | 
                     date(DateTime) == as.Date("2007-02-02")) %>%
        select(DateTime, everything()) %>%
        mutate(Global_active_power = as.numeric(Global_active_power))
hist(df$Global_active_power, xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", col = "red")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()

# Another one
setwd("~/Desktop/Coursera") # Set working directory
library(tidyverse)
library(lubridate)
df <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- dmy_hms(df$DateTime)
df <- filter(df, date(DateTime) == as.Date("2007-02-01") | 
                     date(DateTime) == as.Date("2007-02-02")) %>%
        select(DateTime, everything()) %>%
        mutate(Global_active_power = as.numeric(Global_active_power)) %>%
        mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
        mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
        mutate(Sub_metering_3 = as.numeric(Sub_metering_3))
ymax <- max(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3)
with(df, plot(DateTime, Sub_metering_1, type = "l", ylim = c(0, ymax),
              xlab = "", ylab = "", axes = F, ann = F))
par(new = T)
with(df, plot(DateTime, Sub_metering_2, type = "l", ylim = c(0, ymax), 
              xlab = "", ylab = "", axes = F, ann = F, col = "red"))
par(new = T)
with(df, plot(DateTime, Sub_metering_3, type = "l", ylim = c(0, ymax),
              xlab = "", ylab = "Energy sub metering", col = "blue"))
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
cols <- c("black", "red", "blue")
legend("topright", legend = labels, col = cols, lty = 1, y.intersp = 0.4)
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()

#

# emniese 

library(dplyr)
#Read in data converting ? to NA
df<-read.csv("./household_power_consumption.txt",header=TRUE,na.strings="?",stringsAsFactors=FALSE,sep=";")
match<-c("1/2/2007","2/2/2007") #these are the two dates we need to keep
smalldf<-subset(df,Date %in% match) #subset df to include only rows with the desired dates


smalldf=mutate(smalldf,datetime=strptime(paste(smalldf$Date,smalldf$Time),format="%d/%m/%Y %H:%M:%S"),.keep="unused")

png(file="plot1.png")
hist(smalldf$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()

png(file="plot2.png")
plot(Global_active_power~as.POSIXct(datetime,format="%Y-%m-%d %H:%M:%S"),smalldf,type="l",xlab="Date/Time",ylab="Global active power (kilowatts)",main="Global Active Power by Date")
dev.off()

png(file="plot3.png")
plot(Sub_metering_1~as.POSIXct(datetime,format="%Y-%m-%d %H:%M:%S"),smalldf,type="l",xlab="Date/Time",ylab="Energy sub metering")
lines(Sub_metering_2~as.POSIXct(datetime,format="%Y-%m-%d %H:%M:%S"),smalldf,col="red")
lines(Sub_metering_3~as.POSIXct(datetime,format="%Y-%m-%d %H:%M:%S"),smalldf,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1),lwd=c(2,2,2))
dev.off()

png(file="plot4.png")
par(mfrow=c(2,2))
plot(Global_active_power~as.POSIXct(datetime,format="%Y-%m-%d %H:%M:%S"),smalldf,type="l",xlab="Date/Time",ylab="Global active power (kilowatts)")
plot(Voltage~as.POSIXct(datetime,format="%Y-%m-%d %H:%M:%S"),smalldf,type="l",xlab="datetime",ylab="Voltage")
plot(Sub_metering_1~as.POSIXct(datetime,format="%Y-%m-%d %H:%M:%S"),smalldf,type="l",xlab="Date/Time",ylab="Energy sub metering")
lines(Sub_metering_2~as.POSIXct(datetime,format="%Y-%m-%d %H:%M:%S"),smalldf,col="red")
lines(Sub_metering_3~as.POSIXct(datetime,format="%Y-%m-%d %H:%M:%S"),smalldf,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1),lwd=c(2,2,2))
plot(Global_reactive_power~as.POSIXct(datetime,format="%Y-%m-%d %H:%M:%S"),smalldf,type="l",xlab="datetime")
dev.off()