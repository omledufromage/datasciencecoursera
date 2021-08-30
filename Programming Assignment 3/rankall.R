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
        