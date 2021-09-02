vignette(all = FALSE)
setwd("~/Desktop/datasciencecoursera/Getting and Cleaning Data")

## Q1
#
# Metadata: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

# if (!file.exists("data")) {
#         dir.create("data")       
# }

# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
# download.file(fileUrl, destfile = "./data/cameras.csv")
# list.files("./data")

## [1] "cameras.csv"

# dateDownloaded <- date()
# dateDownloaded

## [1] "Wed Sep  1 17:59:49 2021"

cameraData <- read.csv("./data/cameras.csv")

which(names(cameraData) == "VAL")
length(which(cameraData[,37] >= 24))

# or
table(cameraData$VAL)

#or
DT <- data.table(cameraData)
DT[,.N,by=VAL]

# Answer = 53
######################################################

## Q2

setwd("~/Desktop/datasciencecoursera/Getting and Cleaning Data")
library(xlsx) ## Do not use openxlsx. It will give an error.

# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
# download.file(fileUrl, destfile = "./data/gas.xlsx")

# dateDownloaded <- date()
# dateDownloaded

## [1] "Thu Sep  2 14:42:45 2021"

rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx("./data/gas.xlsx", sheetIndex = 1, header = TRUE, colIndex = colIndex, rowIndex = rowIndex)

sum(dat$Zip*dat$Ext, na.rm=TRUE)

## [1] 36534720

#####################################################

## Q3 

# Multiple variables in the same column violates the principle of tidy data.

###########################

## Q4
#
# 

library(XML)

fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE, isURL = TRUE)
# dateDownloaded <- date()
# dateDownloaded

## [1] "Thu Sep  2 15:05:16 2021"

rootNode <- xmlRoot(doc)
sum(xpathSApply(rootNode, "//zipcode", xmlValue) == "21231")

## [1] 127

#############################################

## Q5
library(data.table)

# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
# download.file(fileUrl, destfile = "./data/survey.csv")
DT <- fread("./data/survey.csv")

# dateDownloaded <- date()
# dateDownloaded
## [1] "Thu Sep  2 15:22:44 2021"

tapply(DT$pwgtp15,DT$SEX,mean)
# 1        2 
# 99.80667 96.66534 

system.time(tapply(DT$pwgtp15,DT$SEX,mean))

# user  system elapsed 
# 0.001   0.000   0.001 

mean(DT[DT$SEX==1,]$pwgtp15) ; mean(DT[DT$SEX==2,]$pwgtp15)
# [1] 99.80667
# [1] 96.66534

system.time(mean(DT[DT$SEX==1,]$pwgtp15)) + system.time(mean(DT[DT$SEX==2,]$pwgtp15))
# user  system elapsed 
# 0.020   0.000   0.008 

sapply(split(DT$pwgtp15,DT$SEX),mean)
# 1        2 
# 99.80667 96.66534 

system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
# user  system elapsed 
# 0.001   0.000   0.001 

rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
# Error in rowMeans(DT) : 'x' must be numeric

system.time(rowMeans(DT$pwgtp15)[DT$SEX==1]) + system.time(rowMeans(DT$pwgtp15)[DT$SEX==2])
# Error in rowMeans(DT) : 'x' must be numeric
# Timing stopped at: 1.01 0.01 1.019

mean(DT$pwgtp15,by=DT$SEX)
# [1] 98.21613
system.time(mean(DT$pwgtp15,by=DT$SEX))
# user  system elapsed 
# 0       0       0 

DT[,mean(pwgtp15),by=SEX]
# SEX       V1
# 1:   1 99.80667
# 2:   2 96.66534

system.time(DT[,mean(pwgtp15),by=SEX])
# user  system elapsed 
# 0.004   0.000   0.002 
# THIS ONE IS MARKED AS CORRECT!!!!!!!!!!