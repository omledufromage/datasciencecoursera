best <- function(state, outcome) {
        df <- read.csv("outcome-of-care-measures.csv", 
                       colClasses = "character")
        State <- df$State
        
        if (any(state == unique(df[,7])) == FALSE) {
                stop("invalid state")
        }
        
        if (outcome == "heart attack") {        
                coord <- order(as.numeric(df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack[State==state]), 
                               df$Hospital.Name[State==state])[1]
        } else if (outcome == "heart failure") {  
                coord <- order(as.numeric(df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure[State==state]), 
                               df$Hospital.Name[State==state])[1]
        } else if (outcome == "pneumonia") { 
                coord <- order(as.numeric(df$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia[State==state]), 
                               df$Hospital.Name[State==state])[1]
        } else {
                stop("invalid outcome")
        }
        df$Hospital.Name[State==state][coord]
}

### OLDER MATERIAL

#       sort(s[[state]][,"Hospital.Name"])
# t <- tapply(s[[state]][,n], s[[state]][,2], sort, na.rm = TRUE) ### n = 11, 17 or 23
# print(t)
# min(s[[state]][,n], na.rm = TRUE)

# s <- split(df, df$State)                      ###
#if (any(state == names(s)) == FALSE) {         ### OLDER WAY OF CHECKING THE STATE CONDITION

#coord = which.min(s[[state]][,n])
#s[[state]]["Hospital.Name"][coord,]

#df[,n] <- as.numeric(df[,n])

#x <- cbind(s[[state]][,n], s[[state]]["Hospital.Name"])
#coord = order(x[,1], x[,2])[1]
#x[coord,2]
