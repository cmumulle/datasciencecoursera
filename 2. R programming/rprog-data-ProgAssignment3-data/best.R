## This function takes two arguments: the 2-character abbreviated name of a state 
## and an outcome name. The function reads the outcome-of-care-measures.csv file 
## and returns a character vector with the name of the hospital that has the best 
## (i.e. lowest) 30-day mortality for the specified outcome in that state. The 
## hospital name is the name provided in the Hospital.Name variable. The outcomes 
## can be one of “heart attack”, “heart failure”, or “pneumonia”. Hospitals that 
## do not have data on a particular outcome should be excluded from the set of 
## hospitals when deciding the rankings.

best <- function(state, outcome) {
        
        ## Read outcome data
        data <- read.csv(file='outcome-of-care-measures.csv', colClasses = 'character')
        
        ## Check that state and outcome are valid
        if(!any(state == data$State)) {
                stop('invalid state')
        }
        
        cases <- c("heart attack", "heart failure", "pneumonia")
        if(!(outcome %in% cases)) {
                stop("invalid outcome")
        }
        
        ## get the right column index to retrieve cases data
        col <- c(11,17,23)
        index <- data.frame(cases, col)
        i <- as.numeric(index[which(index$cases == outcome),][,2])
        
        ## select the right state, clean data and take care of NAs
        data.state <- data[data$State == state, ]
        data.state[, i] <- suppressWarnings(as.numeric(x=data.state[, i]))
        data.state <- data.state[complete.cases(data.state), ]

        ## Return hospital name(s) in that state with lowest 30-day death rate        
        names <- data.state[(data.state[, i] == 
                                     min(data.state[, i])), ]$Hospital.Name
        
        ## sort the names alphabetically
        sort(names)[1]
                    
}