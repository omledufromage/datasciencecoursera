# Reviewing other people's assignments:

download.file("", destfile = "./data/temp.txt")
temp <- read.table("./data/temp.txt", header = TRUE)
dim(temp)
temp[1:3, 1:7]

# dim(temp) should be 180 88