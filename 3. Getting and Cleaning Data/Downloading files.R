## Checks if a data directory exists, if not it's created
if (!file.exists("data")) {
        dir.create("data")
}

## Downloading files from the internet template
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
list.files("./data")
dateDownloaded <- date()

## Loading local files template (IMPORTANT: file, header, sep, row.names, nrows)
cameraData <- read.table("./data/cameras.csv") ## Might give errors due to file formatting, solution below
cameraData <- read.table("./data/cameras.csv", sep =",", header = TRUE)
cameraData <- read.csv("./data/cameras.csv")
## Important parameters: quote="" (resolves '/" issues), na.strings, nrows, skip

## Reading Excel files
library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, header = TRUE)
head(cameraData)
##Excel file subset loading
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)

## Loading XML files
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
rootNode[[1]]
rootNode[[1]][[1]]
xmlSApply(rootNode, xmlValue) ##Recursively extract text from XML document
xpathSApply(rootNode, "//name", xmlValue) ## get the "name" node elements
xpathSApply(rootNode, "//price", xmlValue) ## another example

## XML example from sports :)
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal = TRUE)
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)

## Reading JSON files
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/cmumulle/repos")
names(jsonData)
names(jsonData$owner)
names(jsonData$owner$login)
## Turn data sets into JSON files
myjson <- toJSON(iris, pretty = TRUE)
iris2 <- fromJSON(myjson)
head(iris2)
head(iris)

## data.table package (faster than data.frame)
library(data.table)
DF = data.frame(x=rnorm(9), y=rep(c("a", "b", "c"), each=3), z=rnorm(9))
head(DF, 3)
DT = data.table(x=rnorm(9), y=rep(c("a", "b", "c"), each=3), z=rnorm(9))
head(DT, 3)
DT[2,]
DT[DT$y=="a",]
DT[c(2,3)] ## subsets only rows!!!
DT[, c(2,3)]
DT[,list(mean(x), sum(z))]
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
DT[, w:= z^2] ##adding new variable to data table, use := !!!
DT[, m := {tmp <- (x+z); log2(tmp+5)}] ## multi-step operations with curly brackets {}
DT[,a := x>0]
DT[,b := mean(x+w), by=a]

set.seed(123)
DT <- data.table(x = sample(letters[1:3], 1e5, TRUE))
DT[, .N, by=x] ## .N is an integer containing the character x appears 

## use of setkey
DT <- data.table(x = rep(c("a", "b", "c"), each = 100), y=rnorm(300))
setkey(DT, x)
DT['a']

## Quickly merge two tables based on setkey  
DT1 <- data.table(x=c("a", "b", "c", "dt1"), y=1:4)
DT2 <- data.table(x=c("a", "b", "dt2"), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)

## Working with the dplyr package
library(dplyr)
cran <- tbl_df(mydf)
select(cran, ip_id, package, country) ## select a subset of columns
select(cran, r_arch:country)
select(cran, -time) ## ommit column time
select(cran, -(X:size)) ## ommit all columns from X to size
filter(cran, package == "swirl") ## select all rows for which the package variable is equal to "swirl"
filter(cran, r_version == "3.1.1", country == "US") ##return all rows of cran corresponding to downloads from users in the US running R version 3.1.1
filter(cran, country == "US" | country == "IN") ## gives us all rows for which the country variable equals either "US" or "IN"
filter(cran, !is.na(r_version)) ## return all rows of cran for which r_version is NOT NA
cran2 <- select(cran, size:ip_id)
arrange(cran2, ip_id) ## order the ROWS of cran2 so that ip_id is in ascending order (from small to large)
arrange(cran2, desc(ip_id)) ## order the ROWS of cran2 so that ip_id is in descending order (from large to small)
cran3 <- select(cran, ip_id, package, size)
mutate(cran3, size_mb = size / 2^20) ## add a column called size_mb that contains the download size in megabytes
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10) ## add 2 columns, the 2nd using the 1st new column
summarize(cran, avg_bytes = mean(size)) ## yield the mean value of the size variable



