setwd("~/Desktop/datasciencecoursera/Getting and Cleaning Data")

if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)
#Link doesn't work...

## Q1

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/q4housing.csv", method = "curl")
housing <- read.csv("./data/q4housing.csv")

strsplit(names(housing), "wgtp")[123]

## Q2

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/q4gdp.csv", method = "curl")
gdp <- read.csv("./data/q4gdp.csv")

cleangdp <- gdp[5:194,]
mean(as.numeric(gsub(",","", cleangdp$X.3)), na.rm = TRUE)

## Q3

grep("^United", cleangdp$X.2)

## Q4

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl, destfile = "./data/q4education.csv", method = "curl")
education <- read.csv("./data/q4education.csv")

q4 <- merge(education, gdp, by.x = "CountryCode", by.y = "X", all = FALSE)
sapply(q4, grep, "[Ff]iscal year (.*) June")

q4[grepl("[Ff]iscal year(.*)[Jj]une", q4[,10]),]["Short.Name"]
sum(grepl("[Ff]iscal year(.*)[Jj]une", q4[,10]))

## Q5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

head(sampleTimes)

table(grepl("2012", sampleTimes))

table(grepl("Montag", 
            weekdays(as.Date(sampleTimes, "%Y-%m-%d"))) * grepl("2012", 
                                                                sampleTimes))

