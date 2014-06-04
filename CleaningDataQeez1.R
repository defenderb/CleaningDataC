## q1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="./tmp.csv")
tmp <- read.csv("tmp.csv")
sum(tmp$VAL[!is.na(tmp$VAL)] == 24)

## q3
require(xlsx)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile="getdata-data-DATA.gov_NGAP.xlsx")
dat <- read.xlsx("getdata-data-DATA.gov_NGAP.xlsx", sheetIndex=1, colIndex=7:15,
                  rowIndex=18:23)
sum(dat$Zip*dat$Ext,na.rm=T) 

## q4
require(XML)
xmlUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(xmlUrl, useInternal = TRUE)
tmp <- xpathSApply(doc, "//row/row/zipcode", xmlValue)
sum(tmp == "21231")

## q5
require(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="./tmp.csv")
DT <- fread("tmp.csv", header = TRUE)
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))

system.time(DT[,mean(pwgtp15),by=SEX])
