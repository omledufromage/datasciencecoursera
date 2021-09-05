library(dplyr)
library(stringr)
library(data.table)

### Passage which downloads the raw data and unzips it into a data directory (unnecessary for the assignment):
# if (!file.exists("data")) {
#        dir.create("data")
# }
# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(fileUrl, destfile = "./data/accelerometers.zip")
# unzip("./data/accelerometers.zip", exdir = "./data")

### SET THE WORKING DIRECTORY TO WHERE THE DATA IS (the directory that contains the "UCI HAR Dataset" folder).

### Cleaning the variable names (reads from the working directory):
headers <- read.table("./UCI HAR Dataset/features.txt", col.names = c("V1", "unclean"))
headers$clean <- tolower(headers$unclean)
headers$clean <- gsub("[[:digit:]]", "", headers$clean)
headers$clean <- gsub("[[:punct:]]", "", headers$clean)
headers$clean <- make.unique(headers$clean, sep = "")

### Reading the data:
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = headers$clean)
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c("label")) 
xtrain <-read.table("./UCI HAR Dataset/train/X_train.txt", col.names = headers$clean)
ytrain <-read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c("label")) 
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))

### Joining the datasets by rows to unify groups representing the same variables (x, y and subjects): 
dfx <- rbind(xtest, xtrain)
dfy <- rbind(ytest, ytrain)
subject <- rbind(subtest, subtrain)

# Joining the datasets by columns to create one large dataframe.
df <- cbind(dfy, dfx)
df <- cbind(subject, df)

### Changing the Subjects and the Labels into factor variables: 
df[,1] <- factor(df[,1])
df[,2] <- factor(df[,2], labels = c("Walking", "Upstairs", "Downstairs", "Sitting", "Standing", "Laying"))

### Selecting only the columns of factor variables and of means or standard deviation variables:
tidy <- df[,grepl("subject|label|mean|std", names(df))]

### Creating a new independent dataset with the averages of the tidy data set grouped by their factors (subject and labels): 
tidy2 <- copy(tidy)
tidy2 <- tidy2 %>% group_by(subject, label) %>% summarize_all(mean)

# Writing the dataset into a .txt file for submission:
# write.table(tidy2, file = "./data/tidy2.txt", row.names=FALSE)

### Another way of creating tidy2:

# tidylist <- split(tidy, list(tidy$subject, tidy$label))
# tidy2 <- sapply(tidylist, function(x) colMeans(x [,3:dim(tidy)[2]]))
# tidy2 <- t(tidy2)

### In case we needed to get the data from the Inertial Signals folders:

# for (i in dir("./data/UCI HAR Dataset/test/Inertial Signals/")) {
#        j <- str_replace(i, "test.txt", "train.txt") 
#        print(j)
#        temptest <- read.table(paste0("./data/UCI HAR Dataset/test/Inertial Signals/", i))
#        temptrain<- read.table(paste0("./data/UCI HAR Dataset/train/Inertial Signals/", j))  
#        tempis <- rbind(temptest, temptrain)
#        df <- cbind(df, tempis)
#}

### The names of the variables from the tidy dataset before and after changing:
# headers$clean <- names(dfx)
# headers[grepl("mean|std", headers$unclean), 2:3]