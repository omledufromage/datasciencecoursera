# This function, like best.R, takes a US state and one of three possible 
# outcomes (heart attack, heart failure and pneumonia) as arguments, as well as
# an argument indicating the ranking of the hospital in that state, and returns
# the name of the hospital ranked in the specified position within the state
# in terms of mortality for the specified outcome (higher ranking means lower
# mortality). Ties are settled alphabetically. 


rankhospital <- function(state, outcome, num = "best") {
        df <- read.csv("outcome-of-care-measures.csv", 
                       colClasses = "character")
        State <- df$State
        
        if (any(state == unique(df[,7])) == FALSE) {
                stop("invalid state")
        }
        
        if (outcome == "heart attack") {        
                data <- as.numeric(df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack[State==state])
        } else if (outcome == "heart failure") {  
                data <- as.numeric(df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure[State==state])
        } else if (outcome == "pneumonia") { 
                data <- as.numeric(df$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia[State==state])
        } else {
                stop("invalid outcome")
        }
        
        if (num == "best") {
                r <- 1
        } else if (num == "worst") {
                r <- sum(!is.na(data))
        } else {
                r <- num
        }
        
        coord <- order(as.numeric(data), df$Hospital.Name[State==state])[r]
        df$Hospital.Name[State==state][coord]
}



####
# rankhospital <- function(state, outcome, num = "best") {
#        df <- read.csv("outcome-of-care-measures.csv", 
#                       colClasses = "character")
#        
#        if (any(state == unique(df[,7])) == FALSE) {
#                stop("invalid state")
#        }
#        
#        if (num == "best") {
#                num <- c(1, 1, 1)
#        } else if (num == "worst") {
#                num <- c(sum(!is.na(as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack[State==state]))),
#                         sum(!is.na(as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure[State==state]))),    
#                         sum(!is.na(as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia[State==state]))))
#        } else {
#                num <- c(num, num, num)
#        }
#        if (outcome == "heart attack") {        
#                coord <- order(as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack[State==state]), 
#                               Hospital.Name[State==state])[num[1]]
#        } else if (outcome == "heart failure") {  
#                coord <- order(as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure[State==state]), 
#                               Hospital.Name[State==state])[num[2]]
#        } else if (outcome == "pneumonia") { 
#                coord <- order(as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia[State==state]), 
#                               Hospital.Name[State==state])[num[3]]
#        } else {
#                stop("invalid outcome")
#        }
#        Hospital.Name[State==state][coord]
#}
###