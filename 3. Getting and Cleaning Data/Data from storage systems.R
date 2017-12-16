######################################################
## mySQL database downloads
install.packages("DBI")
library("DBI")
install.packages("RMySQL")
library("RMySQL")
## Getting database into R
## Open a connect and give it a handle (ucscDb)
ucscDb <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu")
## "show databases;" is a mySQL command
result <- dbGetQuery(ucscDb, "show databases;") 
## Important to disconnect !!!
dbDisconnect(ucscDb)
hg19 <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
allTables(1:5)
dbListFields(hg19, "affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
## Read a table from the mySQL database
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)
## Select a smaller set of data
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)
affyMisSmall <- fetch(query, n=10)
dbClearResult(query) ## Close query as it still sits with the database
dim(affyMisSmall)
dbDisconnect(hg19) ## Important to disconnect !!!

######################################################
## Reading HDF5 ("hierarchical data format")
## Install packages
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
created = h5createFile("example.h5")
created ## returns TRUE if file created / package installed
## create some example data
created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")
## write a data set
A = matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5", "foo/A")
B = array(seq(0.1,2.0,by=0.1), dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")
## append a data set
df = data.frame(1L:5L, seq(0,1,length.out=5), c("ab","cde","fghi","a","s"), stringsAsFactors = FALSE)
h5write(df, "example.h5", "df")
h5ls("example.h5")
## read from a data set
readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobaa/B")
readdf = h5read("example.h5","df")
## read and write in chunks
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1)) ## write to the first 3 rows in the first column 12, 13 and 14
h5read("example.h5","foo/A")

######################################################
## Reading from the web (web scraping)
## Getting data off webpages with readLines()
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode
## Parsing with XML
library(XML)
## url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
## html <- htmlTreeParse(url, useInternalNodes = T)
## xpathSApply(html, "//title", xmlValue())
## Installing httr package
library(httr)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html2 <- GET(url)
content2 = content(html2, as="text")
parsedHtml = htmlParse(content2, asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)
## Authenticating with websites
pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user","passwd"))
pg2
names(pg2)
## use handles!!!
google = handle("http://google.com")
pg1 = GET(handle=google, path="/")
pg2 = GET(handle=google, path="search")

######################################################
## Downloading from APIs
library(httr)
myapp = oauth_app("twitter", key="yourConsumerKeyHere", secret="yourConsumerSecretHere")
sig = sign_oauth1.0(myapp, token="yourTokenHere", token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig) ## go to Twitter documentation for URLs
## extract information
json1 = content(homeTL)
json = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]

######################################################
## Downloading from other sources
library(foreign)
library(jpeg) ## and other image formats




