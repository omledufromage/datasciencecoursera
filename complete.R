## This function returns the number of rows with completely observed cases from each datafile (ID number).

## directory <- "specdata"
## id <- from 1 to 332

complete <- function(directory, id = 1:332) {
        classes <- c("Date", "numeric", "numeric", "integer")
        df <- data.frame("id" = NA, "nobs" = NA) 
        for(i in id) {
                id_char <- if(i < 10) {
                        paste("00", i, sep = "")
                } else if(i <100) {
                        paste("0", i, sep = "")
                } else {
                        i
                }  
                id_data <- read.table(paste(directory,"/", id_char, ".csv", sep = ""), 
                                      sep = ",", na.strings = "<NA>", header = TRUE, 
                                      colClasses = classes)
                good <- complete.cases(id_data)
                nobs <- nrow(id_data[good,][])
                
                df <- rbind(df, c(i, nobs))
        }
        good <- complete.cases(df)
        df[good,][]
}