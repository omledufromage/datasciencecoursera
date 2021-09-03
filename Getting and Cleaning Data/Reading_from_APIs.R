# Reading data from APIs (GitHub: Quiz Q1)

# Client ID: 3a4942799375145a958c
# Secret: 35fdf881fd353ef1d0146df56bdb80ef89e09486

library(httr)
library(httpuv)
oauth_endpoints("github")

myapp <- oauth_app("github",
                   key = "3a4942799375145a958c",
                   # secret = "35fdf881fd353ef1d0146df56bdb80ef89e09486"
                   secret = "114485f101b80f0e15e9cda69362d1139d03b806"
)

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
#github_token <- sign_oauth1.0(myapp, 
#                              token = "https://github.com/omledufromage", 
#                              token_secret = "http://localhost:1410")


# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

json1 = content(req)
json2 = jsonlite::fromJSON(jsonlite::toJSON(json1))
json2[json2$full_name == "jtleek/datasharing", ]$created_at

# OR:
# req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
# stop_for_status(req)
# content(req)

jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
jsonData$created_at[jsonData$html_url == "https://github.com/jtleek/datasharing"]

# Q5

data <- read.fwf(file = "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",
                 skip = 4,
                 widths = c(12, 7,4, 9,4, 9,4, 9,4))

sum(as.numeric(data[,4]))
