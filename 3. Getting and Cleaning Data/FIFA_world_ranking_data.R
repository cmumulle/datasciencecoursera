## text <- readLines("http://www.fifa.com/fifa-world-ranking/ranking-table/men/index.html")
## head(text)

library("rvest")
library("dplyr")
library("lubridate")

first_ranking <- 1
last_ranking <- 280

url <- "http://www.fifa.com/fifa-world-ranking/ranking-table/men/index.html"

## Extract the table from the website
world_ranking <- url %>%
        html() %>%
        html_nodes(xpath='//*[@id="profile"]/div[2]/table') %>%
        html_table()
fifa_world_ranking <- world_ranking[[1]]
## Extract the specific date 
htmlText <- read_html(url)
text1 = htmlText %>% html_node("#content-wrap > div > div.navbar.navbar-pageheader.navbar-rankingtbl.nav-scrollspy > div > div.module > div > div.slider.slider-mock.ranking-browser") %>% html_text()
tabledate <- dmy(text1)
## Rename the headers correctly
headers <- c("?1", "Rank", "Team", "?2", "Team_short", "Total Points", "Previous Points",
             "+/-", "Positions", "2017_avg", "2017_weighted", "2016_avg", "2016_weighted", 
             "2015_avg", "2015_weighted", "2014_avg", "2014_weighted", "?3", "?3", "Confed")
colnames(fifa_world_ranking) <- headers


https://www.fifa.com/fifa-world-ranking/ranking-table/men/rank=269/index.html
https://www.fifa.com/fifa-world-ranking/ranking-table/men/rank=257/index.html
https://www.fifa.com/fifa-world-ranking/ranking-table/men/rank=245/index.html



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
        
        