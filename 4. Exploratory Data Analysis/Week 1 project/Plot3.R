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

with(data, {
        plot(Sub_metering_1~Datetime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue') })
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))



##########################################
## Saving to PNG file
##########################################
dev.copy(png, file="Plot3.png", height=480, width=480)
dev.off()