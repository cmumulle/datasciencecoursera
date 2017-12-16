corr <- function(directory, threshold = 0) {
        
        result <- numeric(length = 0)
        
        for (i in 1:332) {
                
                data <- read.csv(paste(directory,"/", formatC(i, width=3, flag="0"), ".csv", sep=""))
                y <- sum(complete.cases(data))
                
                if (y > threshold) {
                        new_value <- cor(data$sulfate, data$nitrate, use="complete.obs")
                        result <- c(result, new_value)
                }

        }
        
        result

}