##########################################################################################
## QUESTION 1
library(httr)
library(httpuv)
library(jsonlite)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications
#    Insert your values below - if secret is omitted, it will look it up in
#    the GITHUB_CONSUMER_SECRET environmental variable.
#
#    Use http://localhost:1410 as the callback url
myapp <- oauth_app("CourseraDataScienceQuiz", "9f3c55ba895fbb7cbd53", secret="08d0162c8c49bbb052cda0aa38be6489391faf6a")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
repo_list <- content(req)

answer1 <- c() 
for (i in 1:length(repo_list)) {
        repo <- repo_list[[i]]
        if (repo$name == "datasharing") {
                answer1 = repo
                break
        }
}

print(answer1$created_at)

##########################################################################################
## QUESTION 2
library(data.table)
library(sqldf)
setwd("~/OneDrive/Documents/Data Science/datasciencecoursera/Getting and Cleaning Data")
fname <- "ss06pid.csv"
download_if_not_exists(fname, "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")
acs <- fread(input = fname, sep = ",")

##########################################################################################
## QUESTION 4
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
html <- readLines(con)
close(con)
c(nchar(html[10]), nchar(html[20]), nchar(html[30]), nchar(html[100]))

##########################################################################################
## QUESTION 5
setwd("~/OneDrive/Documents/Data Science/datasciencecoursera/Getting and Cleaning Data")
fname <- "wksst8110.for"
df <- read.fwf(file=fname,widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
sum(df[, 4])


