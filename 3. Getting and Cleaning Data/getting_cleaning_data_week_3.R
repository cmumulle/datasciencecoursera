###########################################################################
## subsetting and sorting

set.seed(13435)
X <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
X <- X[sample(1:5),]
X$var2[c(1,3)] = NA
X

X[,1]
X[,"var1"]
X[1:2, "var2"]

X[(X$var1 <= 3 & X$var3 > 11),]
X[(X$var1 <= 3 | X$var3 > 15),]

X[which(X$var2 > 8),]
sort(X$var1)
sort(X$var1, decreasing = TRUE)
sort(X$var2, na.last = TRUE)
X[order(X$var1),]
X[order(X$var1, X$var3),]

library(plyr)
arrange(X, var1)
arrange(X, desc(var1))

X$var4 <- rnorm(5)
Y <- cbind(X, rnorm(5))

## summarizing data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/restaurants.csv", method="curl")
restData <- read.csv("./data/restaurants.csv")
head(restData, n=3) ## default is top 6 rows
tail(restData, n=3)
summary(restData)
quantile(restData$councilDistrict, na.rm=TRUE)
quantile(restData$councilDistrict, probs = c(0.5,0.75,0.9))
table(restData$zipCode, useNA = "ifany") ## ifany: table added with number of missing values
table(restData$councilDistrict, restData$zipCode)
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)
colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))
newRestData <- restData[restData$zipCode %in% c("21212", "21213"),] ## !!!!!!

data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)
## Cross tabs
xt <- xtabs(Freq ~ Gender + Admit, data = DF) ## show Freq broken down by Gender and Admit

warpbreaks$replicate <- rep(1:9, len = 54)
xt <- xtabs(breaks ~ . , data = warpbreaks)
xt
ftable(xt)

## creating new variables
s1 <- seq(1,10, by=2) ## creating a sequence to index the data set
s1
s2 <- seq(1,10, by=3) 
s2
x <- c(1,3,7,34,300)
seq(along = x)

restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode <0) ## Check if above command yields correct result

restData$zipGroups = cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups)
Z <- table(restData$zipGroups, restData$zipCode)
Z[1,3]

library(Hmisc); library(plyr)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)
restData2 = mutate(restData, zipGroups=cut2(zipCode, g=4))
table(restData2$zipGroups)

## reshaping data
library(reshape2)
head(mtcars)
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id=c("carname","gear","cyl"), measure.vars = c("mpg", "hp"))
## Provide id factors and measurables to a new data frame
head(carMelt, n=3)
tail(carMelt, n=3)
cylData <- dcast(carMelt, cyl ~ variable)
cylData
cylData <- dcast(carMelt, cyl ~ variable, max)
cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData

## tapply = index apply; apply sum along the index spray to InsectSprays$count
tapply(InsectSprays$count, InsectSprays$spray, sum)

## take the InsectSpray counts and split them up by $Spray
spIns = split(InsectSprays$count, InsectSprays$spray)
spIns

sprCount = lapply(spIns, sum)
unlist(sprCount)
## or 
sapply(spIns, sum)

## ??? ddply(InsectSprays, .(spray), summarize,sum = sum(count))

## managing data frames with dplyr
library(dplyr)
select(data, col1:col3)
filter(data, col1 > 30 & col2 == "cool")
arrange(data, col3) ## order data along asscending col3
arrange(data, desc(col3)) ## same but descending
rename(data, top = col1, whatever = col2) ## top = new, col1 = old name
mutate(data, col5 = col1 - mean(col1, na.rm = TRUE))
mutate(data, temp = factor(1 * (col1 > 80), labels = c("top", "down")))
## xyz <- group_by(data, temp)
## %>% <- pipeline operator !!!!!!

## merging data
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile="./data/reviews.csv", method="curl")
download.file(fileUrl1, destfile="./data/solutions.csv", method="curl")
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
names(reviews)
names(solutions)

## merge by solution_id
mergedData = merge(reviews, solutions, by.x="solution_id", by.y="id", all=TRUE)
intersect(names(solutions), names(reviews))

## merge with plyr package
df1 = data.frame(id=sample(1:10), x=rnorm(10))
df2 = data.frame(id=sample(1:10), x=rnorm(10))
arrange(join(df1,df2), id)

df1 = data.frame(id=sample(1:10), x=rnorm(10))
df2 = data.frame(id=sample(1:10), y=rnorm(10))
df3 = data.frame(id=sample(1:10), z=rnorm(10))
dfList = list(df1, df2, df3)
join_all(dfList)

## swirl: Manipulating data with dplyr
mydf <- read.csv(path2csv, stringsAsFactors = FALSE)
dim(mydf)
head(mydf)
library(dplyr)
packageVersion("dplyr")
cran <- tbl_df(mydf)
rm("mydf")
cran
?select
select(cran, ip_id, package, country)
5:20
select(cran, r_arch:country)
select(cran, country:r_arch)
cran
select(cran, -time)
-5:20
-(5:20)
select(cran, -(X:size))
filter(cran, package == "swirl")
filter(cran, r_version == "3.1.1", country == "US")
filter(cran, r_version <= "3.0.2", country == "IN")
filter(cran, country == "US" | country == "IN")
filter(cran, size > 100500, r_os == "linux-gnu")
is.na(c(3, 5, NA, 10))
!is.na(c(3, 5, NA, 10))
filter(cran, !is.na(r_version))
cran2 <- select(cran, size:ip_id)
arrange(cran2, ip_id)
arrange(cran2, desc(ip_id))
arrange(cran2, package, ip_id)
arrange(cran2, country, desc(r_version), ip_id)
cran3 <- select(cran, ip_id, package, size)
cran3
mutate(cran3, size_mb = size / 2^20)
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)
mutate(cran3, correct_size = size + 1000)
summarize(cran, avg_bytes = mean(size))

## swirl: Grouping and Chaining with dplyr
library(dplyr)
cran <- tbl_df(mydf)
rm("mydf")
cran
?group_by
by_package <- group_by(cran, package)
by_package
summarize(by_package, mean(size))
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))
pack_sum
quantile(pack_sum$count, probs = 0.99)
top_counts <- filter(pack_sum, count > 679)
top_counts
View(top_counts)
top_counts_sorted <- arrange(top_counts, desc(count))
View(top_counts_sorted)
quantile(pack_sum$unique, probs = 0.99)
top_unique <- filter(pack_sum, unique > 465)
View(top_unique)
top_unique_sorted <- arrange(top_unique, desc(unique))
View(top_unique_sorted)

## %>% is "then"
result3 <-
        cran %>%
        group_by(package) %>%
        summarize(count = n(),
                  unique = n_distinct(ip_id),
                  countries = n_distinct(country),
                  avg_bytes = mean(size)
        ) %>%
        filter(countries > 60) %>%
        arrange(desc(countries), avg_bytes)

# Print result to console
print(result3)

cran %>%
        select(ip_id, country, package, size) %>%
        print

cran %>%
        select(ip_id, country, package, size) %>%
        mutate(size_mb = size / 2^20) %>%
        print

cran %>%
        select(ip_id, country, package, size) %>%
        mutate(size_mb = size / 2^20) %>%
        filter(size_mb <= 0.5) %>%
        print

cran %>%
        select(ip_id, country, package, size) %>%
        mutate(size_mb = size / 2^20) %>%
        filter(size_mb <= 0.5) %>%
        arrange(desc(size_mb)) %>%
        print

## swirl: Tidying Data with tidyr
library(readr)
library(tidyr)
students
?gather
gather(students, sex, count, -grade)
students2
res <- gather(students2, sex_class, count, -grade)
res
separate(data = res, col = sex_class, into = c("sex", "class"))

## IMPORTANT: When chaining, omit the FIRST argument in the functions!!!!!
students2 %>%
        gather(sex_class, count, -grade) %>%
        separate(col = sex_class, into = c("sex", "class")) %>%
        print

students3

students3 %>%
        gather(class, grade, class1:class5, na.rm = TRUE) %>%
        print

students3 %>%
        gather(class, grade, class1:class5, na.rm = TRUE) %>%
        spread(test,grade) %>%
        print

library(readr)
parse_number("class5")

students3 %>%
        gather(class, grade, class1:class5, na.rm = TRUE) %>%
        spread(test, grade) %>%
        mutate(class = parse_number(class)) %>%
        print

students4

student_info <- students4 %>%
        select(id,name,sex) %>%
        print

student_info <- students4 %>%
        select(id, name, sex) %>%
        unique %>%
        print

gradebook <- students4 %>%
        select(id, class, midterm, final) %>%
        print

passed
failed
passed <- passed %>% mutate(status = "passed")
failed <- failed %>% mutate(status = "failed")
bind_rows(passed, failed)
fileUrl <- "http://research.collegeboard.org/programs/sat/data/cb-seniors-2013"
sat

sat %>%
        select(-contains("total")) %>%
        gather(key = part_sex, value = count, -score_range) %>%
        separate(part_sex, c("part", "sex")) %>%
        print

sat %>%
        select(-contains("total")) %>%
        gather(part_sex, count, -score_range) %>%
        separate(part_sex, c("part", "sex")) %>%
        group_by(part, sex) %>%
        mutate(total = sum(count),
               prop = count / total
        ) %>% print










