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

png("plot1.png", width = 480, height = 480, units = "px")
with(converted, hist(as.numeric(Global_active_power),
                     main = "Global Active Power",
                     xlab = "Global Active Power (kilowatts)",
                     col = "red"))
dev.off()

