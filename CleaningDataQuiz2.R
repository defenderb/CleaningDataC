## q1
# Register an application with the Github API here 
# https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories 
# (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 
# Use this data to find the time that the datasharing repo was created. 
# What time was it created? This tutorial may be useful 
# (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
# You may also need to run the code in the base R package and not R studio.
require(httr)
oauth_endpoints("github")
myapp <- oauth_app("github", key ="checkprofile",
                   secret = "checkprofile")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
tmp <- content(req)
for (i in 1:length(tmp)){
  if (tmp[[i]]$name == "datasharing") {
    print(tmp[[i]]$created_at)
  }
}

## q2
require(sqldf)
fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="./tmp.csv")
acs <- read.csv("tmp.csv")
str(acs)
sqldf("select * from acs where AGEP < 50 and pwgtp1")
sqldf("select pwgtp1 from acs where AGEP < 50")

## q3
# Using the same data frame you created in the previous problem, 
# what is the equivalent function to unique(acs$AGEP)
sqldf("select distinct AGEP from acs")


## q4
# How many characters are in the 10th, 20th, 30th and 100th 
# lines of HTML from this page: 
#   http://biostat.jhsph.edu/~jleek/contact.html 
# (Hint: the nchar() function in R may be helpful)
siteurl <- "http://biostat.jhsph.edu/~jleek/contact.html" 
con <- url(siteurl)
sitetext <- readLines(con)
close(con)
rownums <- c(10, 20, 30, 100)
sapply(rownums, function(x){ nchar(sitetext[x])})

## q5
# Read this data set into R and report the sum of the numbers 
# in the fourth column. 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 
# (Hint this is a fixed width file format)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, destfile="./tmp.for")
tmp <- read.fwf("tmp.for",width=c(15, 4, 9, 4, 9, 4, 9, 4, 4), skip = 4)
sum(tmp[,4])
