# Reading data from the web
# Webscraping and maybe working on APIs and authentication.
# Webscraping: Programatically extracting data from the HTML code of websites. (How Netflix reverse engineered Hollywood)

con <- url("http:scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode
# Doesn't work, and is not practical.


######################################
library(XML)
fileUrl <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(fileUrl, useInternalNodes=TRUE)
## htmlTreeParse does not support https

library(httr); html2 = GET(fileUrl)
content2 = content(html2, as = "text")
parsedHtml = htmlParse(content2, asText = TRUE)

xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col0citedby']", xmlValue)
######################################## Also doesn't work...

# Accessing websites with passwords (using httr)

pg2 = GET("http://httpbin.org/basic-auth/user/passwd", 
          authenticate("user", "passwd"))
pg2

# Response [http://httpbin.org/basic-auth/user/passwd]
#   Status: 200
#   Content-type: application/json
#{
#   "authenticated": true,
#   "user":"user"
#}

names(pg2)

# Using handles
google = handle("http://google.com")
pg1 = GET(handle=google, path = "/")
pg2 = GET(handle=google, path = "search")

#######################################

# Q4

library(httr)

url <- "https://biostat.jhsph.edu/~jleek/contact.html"
html2 = GET(url)
content2 = content(html2, as = "text")
parsedHtml = htmlParse(content2, asText = TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)


x <- c(10, 20, 30, 100)
html <- readLines(link)
html[x]

html <- htmlTreeParse(url, useInternalNodes=TRUE)

testing <- readLines("https://biostat.jhsph.edu/~jleek/contact.html")

###################################################################################

setwd("~/Desktop/datasciencecoursera/Getting and Cleaning Data")

if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov.api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/restaurants.csv")
## URL Doesn't work anymore. Downloaded manually. 

restData <- read.csv("./data/restaurants.csv")