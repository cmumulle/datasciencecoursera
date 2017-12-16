## The American Community Survey distributes downloadable data about United States communities.
## Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
## and load the data into R. The code book, describing the variable names is here:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
## Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 
## worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the 
## which() function like this to identify the rows of the data frame where the logical vector is TRUE.
## which(agricultureLogical)
## What are the first 3 values that result?
library(data.table)
if(!file.exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
f <- file.path(getwd(), "ss06hid.csv")
download.file(url, f)
dt <- data.table(read.csv(f))

## Lot size is variable ACR with value 3, Sales of ag. products is variable AGS with value 6
agricultureLogical <- dt$ACR == 3 & dt$AGS == 6

## select the first three values [1:3] with which function
## The which() function will return the position of the elements(i.e., 
##row number/column number/array index) in a logical vector which are TRUE
which(agricultureLogical)[1:3]



##Using the jpeg package read in the following picture of your instructor into R
## https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg
## Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting 
## data? (some Linux systems may produce an answer 638 different for the 30th quantile)
library(jpeg)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
if(!file.exists("./data")){dir.create("./data")}
f <- file.path(getwd(), "jeff.jpg")
download.file(url, f, mode="wb")
img <- readJPEG(f, native=TRUE)
quantile(img, probs=c(0.3, 0.8))



## Load the Gross Domestic Product data for the 190 ranked countries in this data set:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
## Load the educational data from this data set:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
## Match the data based on the country shortcode. How many of the IDs match? Sort the data
## frame in descending order by GDP rank (so United States is last). What is the 13th country
##in the resulting data frame?
library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
f <- file.path(getwd(), "GDP.csv")
download.file(url, f)
dtGDP <- data.table(read.csv(f, skip=4, nrows=215))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
f <- file.path(getwd(), "EDSTATS_Country.csv")
download.file(url, f)
dtEd <- data.table(read.csv(f))
dt <- merge(dtGDP, dtEd, all=TRUE, by=c("CountryCode"))
## How many of the IDs match? 
sum(!is.na(unique(dt$rankingGDP)))
## What is the 13th country in the resulting data frame?
dt[order(rankingGDP, decreasing=TRUE), list(CountryCode, Long.Name.x, Long.Name.y, rankingGDP, gdp)][13] 




## What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
dt[, mean(rankingGDP, na.rm=TRUE), by=Income.Group]




## Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
## How many countries are Lower middle income but among the 38 nations with highest GDP?
breaks <- quantile(dt$rankingGDP, probs=seq(0, 1, 0.2), na.rm=TRUE)
dt$quantileGDP <- cut(dt$rankingGDP, breaks=breaks)
dt[Income.Group == "Lower middle income", .N, by=c("Income.Group", "quantileGDP")]