pollution <- read.csv("daily_88101_2017.csv", 
                      colClasses = c("numeric", "character", "factor", "numeric", "numeric"))
head(pollution)

summary(pollution$pm25)

boxplot(pollution$pm25, col = "blue")

hist(pollution$pm25, col = "green")

hist(pollution$pm25, col = "green")
rug(pollution$pm25)

hist(pollution$pm25, col = "green", breaks = 100)
rug(pollution$pm25)

boxplot(pollution$pm25, col = "blue")
abline(h = 12)

hist(pollution$pm25, col = "green")
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)

barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each Region")

boxplot(pm25 ~ region, data = pollution, col = "red")

par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
hist(subset(pollution, region == "east")$pm25, col = "green") 
hist(subset(pollution, region == "west")$pm25, col = "green")

with(pollution, plot(latitude, pm25))
abline(h=12,lwd=2,lty=2)

with(pollution, plot(latitude, pm25, col = region))
abline(h=12,lwd=2,lty=2)

par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))



