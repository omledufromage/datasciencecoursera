
## Q1

setwd("~/Desktop/datasciencecoursera/Getting and Cleaning Data")

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/q3survey.csv")
survey <- read.csv("./data/q3survey.csv")

head(survey, 3)

## ACR == 3 => House on ten or more acres.
## AGS == 6 => Sold more than $10000 in agricultural products

agricultureLogical <- survey$ACR == 3 & survey$AGS == 6
which(agricultureLogical)

## Q2

library(jpeg)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg" 
download.file(fileUrl, destfile = "./data/jeff.jpeg")
jeff <- readJPEG("./data/jeff.jpeg", native = TRUE)
quantile(jeff, c(0.30,0.80))

## Q3

fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl1, destfile = "./data/gdp.csv")
gdp <- read.csv("./data/gdp.csv")
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl2, destfile = "./data/education.csv")
education <- read.csv("./data/education.csv")

intersect(gdp$X, education$CountryCode)
df <- merge(education, gdp, by.x = "CountryCode", by.y = "X", all = FALSE)
df <- df %>% rename(GDP = Gross.domestic.product.2012) %>% select(CountryCode, GDP) %>% filter(CountryCode %in% education$CountryCode)

df <- mutate(df, GDP = as.numeric(GDP))
df <- arrange(df, desc(GDP)) 
head(df, 13)

sum(!is.na(as.numeric(df$GDP)))

## Q4

df <- merge(education, gdp, by.x = "CountryCode", by.y = "X", all = FALSE)
df <- df %>% rename(GDP = Gross.domestic.product.2012) %>% select(CountryCode, GDP, Income.Group) %>% filter(CountryCode %in% education$CountryCode)

df <- mutate(df, GDP = as.numeric(GDP))
oecd <- filter(df, Income.Group == "High income: OECD")
noecd <- filter(df, Income.Group == "High income: nonOECD")

mean(oecd$GDP, na.rm = TRUE)
mean(noecd$GDP, na.rm = TRUE)

## Q5

df$quantile <- cut(df$GDP, breaks = quantile(df$GDP, na.rm = TRUE, c(0, 0.20, 0.40, 0.60, 0.80, 1)))
print(table( df$Income.Group, df$quantile))

#                      (1,38.6] (38.6,76.2] (76.2,114] (114,152] (152,190]
#                             0           0          0         0         0
# High income: nonOECD        4           5          8         4         2
# High income: OECD          17          10          1         1         0
# Low income                  0           1          9        16        11
# Lower middle income  HERE>> 5 <<HERE   13         11         9        16
# Upper middle income        11           9          8         8         9

