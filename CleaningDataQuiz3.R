## q1
# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the 
# state of Idaho using download.file() from here:   
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
# and load the data into R. The code book, describing the variable names is here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# Create a logical vector that identifies the households on greater than 10 acres 
# who sold more than $10,000 worth of agriculture products. Assign that logical vector 
# to the variable agricultureLogical. Apply the which() function like this 
# to identify the rows of the data frame where the logical vector is TRUE. 
# which(agricultureLogical) What are the first 3 values that result?
fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if(!file.exists("./data")){dir.create("./data")}
download.file(fileUrl, destfile="./data/tmpQ1.csv")
tmp <- read.csv("./data/tmpQ1.csv")
agricultureLogical <- tmp$ACR == 3 & tmp$AGS == 6
which(agricultureLogical)

## q2
# Using the jpeg package read in the following picture of your instructor into R 
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 
# Use the parameter native=TRUE. What are the 30th and 80th 
# quantiles of the resulting data? (some Linux systems may 
# produce an answer 638 different for the 30th quantile)
fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
if(!file.exists("./data")){dir.create("./data")}
download.file(fileUrl, destfile="./data/tmpQ2.jpg",mode="wb")
require(jpeg)
tmp <- readJPEG("./data/tmpQ2.jpg", native=TRUE)
quantile(tmp, probs=c(0.3, 0.8))

## q3
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:   
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# Load the educational data from this data set:   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
# Match the data based on the country shortcode. How many of the IDs match? 
# Sort the data frame in descending order by GDP rank (so United States is last). 
# What is the 13th country in the resulting data frame? 
# Original data sources: 
# http://data.worldbank.org/data-catalog/GDP-ranking-table 
# http://data.worldbank.org/data-catalog/ed-stats

if(!file.exists("./data")){dir.create("./data")}
fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile="./data/tmpQ3GDP.csv")
fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl, destfile="./data/tmpQ3ESt.csv")
tmpGDP <- read.csv("./data/tmpQ3GDP.csv", skip=4, as.is =TRUE, nrows=190)
names(tmpGDP) <- c("ConCode", "Ranking", "Non", "CountryName", "GDPinUSD")
tmpGDP <- tmpGDP[tmpGDP[,1] != "",1:5]
tmpGDP$Ranking[tmpGDP$Ranking == ""] <- "0"
tmpGDP$Ranking <- as.integer(tmpGDP$Ranking)
tmpESt <- read.csv("./data/tmpQ3ESt.csv")
tmp <- merge(tmpGDP, tmpESt, by.x = "ConCode", by.y = "CountryCode")
tmp <- tmp[order(tmp$Ranking, decreasing=TRUE), ]

## q4
tapply(tmp$Ranking, tmp$Income.Group, mean)

## q5
RankGroups <- cut(tmp$Ranking, breaks=quantile(tmp$Ranking, probs=c(0,0.2,0.4,0.6,0.8,1)))
table(RankGroups,tmp$Income.Group)
