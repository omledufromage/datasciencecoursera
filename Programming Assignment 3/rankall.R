# This function, like rankhospital.R, takes one out of three outcomes (heart attack, 
# heart failure and pneumonia) and the state ranking desired and returns a dataframe 
# containing the name of the hospital of each state in the specified rank. Ties
# are resolved alphabetically.  

rankall <- function(outcome, num = "best") {
        source("rankhospital.R")
        
        df <- read.csv("outcome-of-care-measures.csv", 
                       colClasses = "character")
        df2 <- data.frame(hospital = numeric(length(unique(df[,7]))), state = sort(unique(df[,7])))
        
        for (i in unique(df[,7])) {
                df2$hospital[df2$state == i] <- rankhospital(i, outcome, num)
        }
        df2
}
        