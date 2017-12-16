pollutantmean <- function(directory, pollutant, id = 1:322) {
        
        data <- data.frame(matrix(ncol = 4, nrow = 0))
        x <- c("Date", "sulfate", "nitrate", "ID")
        colnames(data) <- x
        
        for (i in id) {
                new_data <- read.csv(paste(directory,"/", formatC(i, width=3, flag="0"), ".csv", sep=""))
                data <- rbind(data, new_data)
        }
        
        mean(data[[pollutant]], na.rm = TRUE)

}