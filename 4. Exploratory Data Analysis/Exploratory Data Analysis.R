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

xyplot(y ~ x | f * g, data)

library(lattice)
library(datasets)
## Simple scatterplot
xyplot(Ozone ~ Wind, data = airquality)

library(datasets)
library(lattice)
## Convert 'Month' to a factor variable
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))

p <- xyplot(Ozone ~ Wind, data = airquality)  ## Nothing happens!
print(p)  ## Plot appears
xyplot(Ozone ~ Wind, data = airquality)  ## Auto-printing

set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2, 1))  ## Plot with 2 panels

## Custom panel function
xyplot(y ~ x | f, panel = function(x, y, ...) {    
  panel.xyplot(x, y, ...)  ## First call the default panel function for 'xyplot'    
  panel.abline(h = median(y), lty = 2)  ## Add a horizontal line at the median
})

## Custom panel function
xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...)  ## First call default panel function
  panel.lmline(x, y, col = 2)  ## Overlay a simple linear regression line
})

## Calculate the deciles of the data!> 
cutpoints <- quantile(maacs$logno2_new, seq(0, 1, length = 11), na.rm = TRUE)
## Cut the data at the deciles and create a new factor variable!> 
maacs$no2dec <- cut(maacs$logno2_new, cutpoints)
## See the levels of the newly created factor variable!> 
levels(maacs$no2dec)

## Setup ggplot with data frame!
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
## Add layers!
g + geom_point(alpha = 1/3)
+ facet_wrap(bmicat ~ no2dec, nrow = 2, ncol = 4)
+ geom_smooth(method="lm", se=FALSE, col="steelblue")
+ theme_bw(base_family = "Avenir", base_size = 10)
+ labs(x = expression("log " * PM[2.5]))
+ labs(y = "Nocturnal Symptoms”) 
+ labs(title = "MAACS Cohort”)



