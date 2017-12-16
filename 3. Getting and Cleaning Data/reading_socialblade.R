#Loading the rvest package
library("XML", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
library("RCurl", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
library("rvest", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")

## Reading the HTML code from the website and get the current date
url <- "https://socialblade.com/youtube/top/category/sports"
htmlText <- read_html(url)
text1 = htmlText %>% html_node("body > div:nth-child(8) > div:nth-child(2)") %>% html_text()
currentdate <- Sys.Date()

## Cut header/ad section of text to the actual data
pos <- regexpr('Username', text1) - 12; len <- nchar(text1); 
text <- substr(text1, pos, len)

## Clean the text from \n formatting
text <- gsub("\n\n\n", "\n\n", text)
text <- gsub("\n\n", "\n", text)
text <- gsub("\n \n", "\n", text)

## Split the text and unlist the resulting text
text <- strsplit(text, "\n")
text <- unlist(text, use.names=FALSE)

## Convert to data table and use the first row as column names (colnames is the first row, then delete 1st row)
df <- cbind.data.frame(split(text, rep(1:6, times=length(text)/6)), stringsAsFactors=FALSE)
colnames(df) <- df[1,]
df <- df[-1, ] 

## Clean number columns and convert to numberic format
df$Uploads <- gsub(",", "", df$Uploads)
df$Uploads <- as.numeric(as.character(df$Uploads))

df$Subs <- gsub(",", "", df$Subs)
df$Subs <- as.numeric(as.character(df$Subs))

df$`Video Views` <- gsub(",", "", df$`Video Views`)
df$`Video Views` <- as.numeric(as.character(df$`Video Views`))

## Add retrieval date and category
df$Date <- currentdate
df$Category <- "Sports"

## Set correct working directory and export as CSV file
setwd("~/OneDrive/Documents/Data Science/datasciencecoursera/3. Getting and Cleaning Data")
write.table(df, "socialblade.txt", sep="\t", row.names = FALSE)


######################################################################################################
## GRAVEYARD

## url <- "https://www.youtube.com/channel/UCJ5v_MCY6GNUBTO8-D3XoAg"
## htmlText <- read_html(url)
## htmlText %>% html_node("#channel-container") 
