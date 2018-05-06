## https://github.com/dessyamirudin/webScrappingR/blob/master/webScrap_ok.R

library("rvest")
library("dplyr")
library("lubridate")
library("RCurl")
library("XML")
library("purrr")

closeAllConnections()
rm(list=ls())

trim <- function(x) gsub("^\\s+|\\s+$", "", x)
ytsports.complete <- NA

url<-"https://www.youtube.com"

page_num <- 1

link_list <- list() 
front_url <- "https://www.youtube.com/results?search_query=sport&sp=CAMSAhAC&page="

for (page_num in 1:10) {
        
        site <- paste(front_url, page_num, sep="")
        web.code <- getURLContent(site, ssl.verifypeer = FALSE)
        web.html <- htmlTreeParse(web.code, asText=T, useInternalNodes=T)
        
        channel_link <- xpathSApply(web.html,"//a[contains(@href,'channel')]/@href")
        
        link_list <- c(link_list, channel_link)
        
        pause_time <- runif(1, min = 3, max = 8)
        Sys.sleep(pause_time)
        
}

## Clean up the list by removing duplicates and cleaning the URLs
link_list <- unique(link_list)
link_list <- gsub("https://www.youtube.com", "", link_list)









#########################################################################################################
## GRAVEYARD
#########################################################################################################
## url <- "https://www.youtube.com/results?sp=EgIQAg%253D%253D&search_query=sport"
## htmlText <- read_html(url)
## videotitle = html_nodes(url, 'meta[itemprop="name"]') %>% 
##         html_attr("content")
## 
## https://statistics.berkeley.edu/computing/r-reading-webpages
## url <- "https://www.youtube.com/results?sp=EgIQAg%253D%253D&search_query=sport"
## thepage = readLines(url)
## mypattern = '<span id="subscribers" class="style-scope ytd-channel-renderer">7([^<]*)</span>'
## datalines = grep(mypattern,thepage,value=TRUE)
## 
## site <- paste(front_url,page_num,sep="")
## web.code <- getURLContent(site,ssl.verifypeer = FALSE)
## web.html <- htmlTreeParse(web.code,asText=T,useInternalNodes=T)
## 
## https://github.com/dessyamirudin/webScrappingR/blob/master/webScrap_ok.R
## front_url <- "https://www.youtube.com/results?sp=EgIQAg%253D%253D&search_query=sport"
## web.code <- getURLContent(web.html,ssl.verifypeer = FALSE)
## web.html <- htmlTreeParse(web.code,asText=T,useInternalNodes=T)
## title_link <- xpathSApply(web.html,"//a/@href")
## title_link <- xpathSApply(web.html,"//a[contains(@href,'channel')]/@href")
## 
## 
## 
