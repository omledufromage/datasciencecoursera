library(dplyr)

if (!file.exists("data")) {
        dir.create("data")
        }

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/accelerometers.zip")
unzip("./data/accelerometers.zip", exdir = "./data")

xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
xtrain <-read.table("./data/UCI HAR Dataset/train/X_train.txt")
ytrain <-read.table("./data/UCI HAR Dataset/train/y_train.txt")

istest <- read.table("./data/UCI HAR Dataset/test/Inertial Signals")
istrain <- read.table("./data/UCI HAR Dataset/train/Inertial Signals")

# 30 volunteers
# 6 movements. 

# x: set => merge train and test (at the end)
# y: labels => merge train and test (at the end)

