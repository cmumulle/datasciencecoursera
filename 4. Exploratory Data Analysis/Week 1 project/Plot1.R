##########################################
## Getting full dataset
##########################################
ig <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
               nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
ig$Date <- as.Date(ig$Date, format="%d/%m/%Y")


##########################################
## Subsetting the data
##########################################
data <- subset(ig, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))


##########################################
## Converting dates
##########################################
hello_ig <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(hello_ig)


##########################################
## Plot 1
##########################################
par(mfrow = c(1, 1))
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")


##########################################
## Saving to PNG file
##########################################
dev.copy(png, file="Plot1.png", height=480, width=480)
dev.off()