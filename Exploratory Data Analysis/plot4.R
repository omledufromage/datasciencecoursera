library(lubridate)

setwd("~/Desktop/datasciencecoursera/Exploratory Data Analysis")

if (!file.exists("data")) {
        dir.create("data")
 }

# Preparing the data. If the selected data already exists, 
# then it is retrieved in from the working directory. Otherwise,
# it is downloaded and prepared by subsetting the relevant dates.

if (file.exists("./data/converted.csv")) {
        cat("Retrieving converted data file")
        converted <- read.csv("./data/converted.csv")
} else {
        cat("No valid data file found in the local directory. Downloading and subsetting from the original zip file on the internet. This may take a while. \n")
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "./data/elec_power_consumption.zip")
        unzip("./data/elec_power_consumption.zip", exdir = "./data")

        data <- read.csv2("./data/household_power_consumption.txt", header = TRUE)
        data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
        data$Time <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

        converted <- data[data$Date == as.Date("2007-02-02") | data$Date == as.Date("2007-02-01"),]
# converted <- subset(data, Date == as.Date("2007-02-02") | Date == as.Date("2007-02-01"))

        rm(data)
        gc()

        write.csv(converted, file = "./data/converted.csv")
} 

# Plotting a histogram as a png file in the working directory.

png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))

# 1, 1
plot(converted$Time, 
     as.numeric(converted$Global_active_power), 
     ylab = "Global Active Power", 
     xlab = "",
     type = "l")

# 2, 1
plot(converted$Time, 
     as.numeric(converted$Voltage), 
     ylab = "Voltage", 
     xlab = "datetime",
     type = "l")

# 1, 2
plot(converted$Time, 
     as.numeric(converted$Sub_metering_1), 
     ylab = "Energy sub metering", 
     xlab = "",
     type = "l")
lines(converted$Time, 
      as.numeric(converted$Sub_metering_2), 
      col = "red")
lines(converted$Time, 
      as.numeric(converted$Sub_metering_3), 
      col = "blue")
legend("topright", lty = 1, col = c("black" , "red", "blue"), legend = c("Sub_metering_1" , "Sub_metering_2" , "Sub_metering_3"))

# 2, 2
plot(converted$Time, 
     as.numeric(converted$Global_reactive_power), 
     ylab = "Global_reactive_power", 
     xlab = "datetime",
     type = "l")

dev.off()

