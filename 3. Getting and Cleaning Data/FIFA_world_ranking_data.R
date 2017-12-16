## text <- readLines("http://www.fifa.com/fifa-world-ranking/ranking-table/men/index.html")
## head(text)

library("rvest", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")

url <- "http://www.fifa.com/fifa-world-ranking/ranking-table/men/index.html"

world_ranking <- url %>%
        html() %>%
        html_nodes(xpath='//*[@id="profile"]/div[2]/table') %>%
        html_table()

fifa_world_ranking <- world_ranking[[1]]

head(fifa_world_ranking)

## GRAVEYARD
## library("dplyr", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
## library("XML", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
## page <- read_html("http://www.fifa.com/fifa-world-ranking/ranking-table/men/index.html")
## head(text)
## selector <- "#profile > div:nth-child(2) > table > tbody"
## text <- page %>% html_nodes(css = selector) %>% html_text()
## xpath <- '//*[@id="profile"]/div[2]/table/tbody'
## text <- page %>% html_nodes(xpath = xpath) %>% html_text()
## df <- html_table("http://www.fifa.com/fifa-world-ranking/ranking-table/men/index.html")
## library("rvest")
        
        