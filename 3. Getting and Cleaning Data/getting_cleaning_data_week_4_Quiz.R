library(data.table)
setwd("~/OneDrive/Documents/Data Science/datasciencecoursera/3. Getting and Cleaning Data")
if(!file.exists("./data")){dir.create("./data")}
setwd("~/OneDrive/Documents/Data Science/datasciencecoursera/3. Getting and Cleaning Data/data")




fname <- "survey.csv"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", fname)
survey_df <- read.csv(fname, header = TRUE, sep = ",")
answer1 <- strsplit(names(survey_df), "wgtp")[[123]]
print("The value of the 123th element is:")
# Expected output: ""   "15"
print(answer1)



url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
f <- file.path(getwd(), "GDP.csv")
download.file(url, f)
dtGDP <- data.table(read.csv(f, skip = 4, nrows = 215, stringsAsFactors = FALSE))
dtGDP <- dtGDP[X != ""]
dtGDP <- dtGDP[, list(X, X.1, X.3, X.4)]
setnames(dtGDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                               "Long.Name", "gdp"))
gdp <- as.numeric(gsub(",", "", dtGDP$gdp))
mean(gdp, na.rm = TRUE)



isUnited <- grepl("^United", dtGDP$Long.Name)
summary(isUnited)



url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
f <- file.path(getwd(), "EDSTATS_Country.csv")
download.file(url, f)
dtEd <- data.table(read.csv(f))
dt <- merge(dtGDP, dtEd, all = TRUE, by = c("CountryCode"))
isFiscalYearEnd <- grepl("fiscal year end", tolower(dt$Special.Notes))
isJune <- grepl("june", tolower(dt$Special.Notes))
table(isFiscalYearEnd, isJune)
dt[isFiscalYearEnd & isJune, Special.Notes]



library(quantmod) 
amzn = getSymbols("AMZN",auto.assign=FALSE)
##     As of 0.4-0, 'getSymbols' uses env=parent.frame() and
##  auto.assign=TRUE by default.
## 
##  This  behavior  will be  phased out in 0.5-0  when the call  will
##  default to use auto.assign=FALSE. getOption("getSymbols.env") and 
##  getOptions("getSymbols.auto.assign") are now checked for alternate defaults
## 
##  This message is shown once per session and may be disabled by setting 
##  options("getSymbols.warning4.0"=FALSE). See ?getSymbol for more details
## Warning: downloaded length 96069 != reported length 200
sampleTimes <- index(amzn)
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))
