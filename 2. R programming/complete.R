complete <- function(directory, id = 1:322) {
        
        output <- data.frame(matrix(ncol = 2, nrow = 0))

        for (i in id) {
                data <- read.csv(paste(directory,"/", formatC(i, width=3, flag="0"), ".csv", sep=""))
                y <- sum(complete.cases(data))
                
                output <- rbind(output, c(i,y))
        }
        
        x <- c("id", "nobs")
        colnames(output) <- x
        output

}