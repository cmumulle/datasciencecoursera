## QUESTION 1
## load file with read.csv, record download date
fname <- "ss06hid.csv"
data <- read.csv(fname)
dateDownloaded <- date()
str(data)
## load data.table library and assign data to DT, use .N to summarize by VAL values
library(data.table)
DT <- data.table(data)
DT[,.N,by=VAL]


## QUESTION 2
## To answer the question, check the FES definition in the code book:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
## Note statements like these:
## ".. in .LF"
## ".. not in .LF"
## That suggests FES depends on another variable


## QUESTION 3
## load file but only rows 18-23 and columns 7-15 
dyn.load('/Library/Java/JavaVirtualMachines/jdk-9.0.1.jdk/Contents/Home/lib/server/libjvm.dylib')
library(rJava)
library(xlsx)
rowIndex <- 18:23
colIndex <- 7:15
fname <- "DATA.gov_NGAP.xlsx"
dat <- read.xlsx(fname, sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)
str(dat)
sum(dat$Zip*dat$Ext,na.rm=T)


## QUESTION 4
library(XML)
fname <- "restaurants.xml"
doc <- xmlTreeParse(fname, useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
## Get all nodes with zipcode 21231 and calculate length, i.e. number of occurences (=# of restaurants)
x <- xpathApply(doc, "//zipcode[text()='21231']", xmlValue)
length(x)


## QUESTION 5
library(data.table)
fname <- "ss06pid.csv"
download_if_not_exists(fname, "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")
DT <- fread(input = fname, sep = ",")

system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
system.time(DT[,mean(pwgtp15),by=SEX])