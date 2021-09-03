## Reading from MySQL
library(RMySQL)

ucscDb <- dbConnect(MySQL(), user="genome",
                    host="genome-mysql.cse.ucsc.edu")

#"show databases;" is a MySQL command.
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb); # Very important to disconnect from the MySQL server when you're done collecting data. 
# [1] TRUE                                                             #Coming from the dbDisconnect.

result

hg19 <- dbConnect(MySQL(), user="genome", db="hg19",
                  host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)

allTables[1:5] #Each data type gets its own table.

# "I want to look at hg19 database, and what are all the fields (columns) in the 'affyU133Plus2' table."

dbListFields(hg19, "affyU133Plus2") # affyU133Plus2 has to do with the genome.

#How many rows are inside the dataset? 
dbGetQuery(hg19, "select count(*) from affyU133Plus2") # select count (*) from ... is another MySQL command. It returns the number of records.

affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

# Tables might be too big. Specific subset:
query <- dbSendQuery(hg19, "select * from affyU133Plus2where misMatches between 1 and 3") ## SQL syntax is incorrect. Research!
affyMis <- fetch(query); quantile(affyMis$misMatches)

affyMisSmall <- fetch(query, n=10); dbClearResult(query)

dim(affyMisSmall)

# Always remember to close the connection!
dbDisconnect(hg19)

## http://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf
## http://www.pantz.org/software/mysql/mysqlcommands.html
        # - Do not, do not, delete add or join things from ensembl. Only select.
        # - In general, by careful with mysql commands.
# A nice blog post summarizing some other commands http://www.r-bloggers.com/mysql-and-r/

# Q2
setwd("~/Desktop/datasciencecoursera/Getting and Cleaning Data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/survey.csv")

dateDownloaded <- date()
dateDownloaded

# [1] "Fri Sep  3 04:34:38 2021"

acs <- read.csv("./data/survey.csv")
head()

