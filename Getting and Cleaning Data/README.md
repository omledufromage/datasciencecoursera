---
title: "README"
author: "Marcio Reverbel"
date: "9/5/2021"
output: pdf_document
---

# Assignment: Getting and Cleaning Data

This assignment fulfilled the task of getting and cleaning data collected from the accelerometers from the Samsung Galaxy S smartphone.

## run_analysis.R
run_analysis.R does the following to Samsung's data: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script assumes the file containing the data has been downloaded and was unzipped in your working directory.
