#Loading the rvest package
library("XML", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
library("RCurl", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
library("rvest", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")

#Specifying the url for desired website to be scrapped
url <- "https://www.youtube.com/channel/UCJ5v_MCY6GNUBTO8-D3XoAg"
htmlText <- read_html(url)
title = as.character(html_nodes(htmlText, 'meta[itemprop="name"]') %>% 
                             html_attr("content"))

htmlText %>% html_node("#subscriber-count") %>% html_text()






## Setting up empty df to store data
temp.df = data.frame(id="", date="", title="", duration="", mins="", secs="",
                     description="", views= "", pos="", neg="", fullurl="")
youtube.df = data.frame() #Will include the final outcome


subscriber <- html_node(youtube_url, "#subscriber-count") %>% html_text()


        id = as.character(html_nodes(youtube_url, 'meta[itemprop="videoId"]') %>% 
                                  html_attr("content"))
        date = as.character(html_nodes(youtube_url, 'meta[itemprop="datePublished"]') %>% 
                                    html_attr("content"))
        title = as.character(html_nodes(youtube_url, 'meta[itemprop="name"]') %>% 
                                     html_attr("content"))
        mins = as.numeric(gsub("M","",str_extract(as.character(html_nodes(youtube_url, 'meta[itemprop="duration"]') %>% 
                                                                       html_attr("content")), "\\d*M")))
        secs = as.numeric(gsub("S","",str_extract(as.character(html_nodes(youtube_url, 'meta[itemprop="duration"]') %>% 
                                                                       html_attr("content")), "\\d*S")))
        duration = (mins*60) + secs
        description = as.character(html_node(youtube_url, '#eow-description') %>% 
                                           html_text())
        views = as.numeric(html_nodes(youtube_url, 'meta[itemprop="interactionCount"]') %>% 
                                   html_attr("content"))  
        try({
                pos = html_nodes(youtube_url, 'span.yt-uix-button-content') %>% 
                        html_text()
                pos = as.numeric(gsub(",", "", pos[15]))}, silent = TRUE)
        if(length(pos)==0){
                pos=NA
        }
        try({
                neg = html_nodes(youtube_url, 'span.yt-uix-button-content') %>% 
                        html_text()
                neg = as.numeric(gsub(",", "", neg[18]))}, silent = TRUE)
        if(length(neg)==0){
                neg=NA
        }
        fullurl = paste("https://www.youtube.com/watch?v=",id, sep="")
        #Saves output into a df and appends the data to the final df
        temp.df = data.frame(id, date, title, duration, description, mins, secs, views, pos, neg, fullurl)
        youtube.df = rbind(youtube.df, temp.df)
        
        #Empties all the fields before creating a new entry 
        temp.df = data.frame(id="", date="", title="", duration="", mins="", secs="", description="",  
                             views= "", pos="", neg="", fullurl="")
        #Clear all temp variables    
        remove(id, date, title, duration, description,views, pos, neg, fullurl, mins, secs)
}
#Delete temporary df
remove(temp.df, youtube_url, i, youtube_list)