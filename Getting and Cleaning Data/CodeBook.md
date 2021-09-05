---
title: "CodeBook"
author: "Marcio Reverbel"
date: "9/5/2021"
output: pdf_document
---

# CodeBook
## Assignment: Getting and Cleaning Data


### Variables

Variables were cleaned by removing digits, punctuation and changing all upper case letters to lower case letters. 
For example: Originally reported in features.txt as *tBodyAcc-mean()-X*, the cleaned version become *tbodyaccmeanx*. 

Variables can represent the mean or the standard deviation (std) of different measurements, and may have been taken for
any of the three axis (x, y and z). The prefix (t, f or angle) indicates whether the measurement was of time, frequency or angle.

The units of all the variables remain the same as described in features.txt. (In the case of the tidy2 data set, 
the units are likewise the same, since taking the average of the different measurements doesn't change the unit)

