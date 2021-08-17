## This function calculates the correlation between nitrate and sulfate 
## measurements for each monitor (observe threshold) and creates a vector 
## with the results. Only complete cases are observed.

## threshold <- number of minumum observed cases in a monitor.  

corr <- function(directory, threshold = 0) {
        x <- complete("specdata", 1:332)
        threshold_data <- x$nobs > threshold
        x <- x[threshold_data,][]
        y <- vector("numeric")
        classes <- c("Date", "numeric", "numeric", "integer")

        for (i in x[["id"]]){
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
                good <- complete.cases(id_data)
                cleandata <- id_data[good,][]
                y <- append(y, cor(cleandata[["sulfate"]], cleandata[["nitrate"]]))
        }        
        y
}
