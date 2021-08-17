## directory <- "specdata"
## pollutant <- "nitrate" ## or "sulfate"
## id <- from 1 to 332

## str_pad(x, 3, side = "left", pad = "0")

pollutantmean <- function(directory, pollutant, id = 1:332) {
        classes <- c("Date", "numeric", "numeric", "integer")
        df <- data.frame("Date" = NA, "sulfate" = NA, "nitrate" = NA, "ID" = NA) 
        for (i in id) {
                id_char <- if (i < 10) {
                        paste("00", i, sep = "")
                } else if (i <100) {
                        paste("0", i, sep = "")
                } else {
                        i
                }  
                id_data <- read.table(paste(directory,"/", id_char, ".csv", sep = ""),  
                                      sep = ",", na.strings = "<NA>", header = TRUE, 
                                      colClasses = classes)
                df <- rbind(df, id_data)
        }
        mean(df[[pollutant]], na.rm = TRUE)
}

