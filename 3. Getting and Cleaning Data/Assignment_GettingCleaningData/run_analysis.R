## Run the analysis -> creates the tiny data set and saves it under "tidy.txt"

## run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Preparatory steps
setwd("~/OneDrive/Documents/Data Science/datasciencecoursera/3. Getting and Cleaning Data/Assignment_GettingCleaningData")
## Load required packages
packages<-c("data.table", "dplyr", "reshape2")
sapply(packages, require, character.only = TRUE)

## Reads the base sets (files with begining by X) in an optimal way
## * filePath: path of the file
## * filteredFeatures: ids of the features to be extracted
## * features: all features names
readBaseSet <- function(filePath, filteredFeatures, features) {
        cols_widths <- rep(-16, length(features))
        cols_widths[filteredFeatures] <- 16
        rawSet <- read.fwf(
                file=filePath,
                widths=cols_widths,
                col.names=features[filteredFeatures])
}

## Reads an additional file (other than the base sets). Used for subjects and labels.
## * dataDirectory: directory of data
## * filePath: relative path of the file. For instance if its value is "subject" it
##   will read "UCI HAR Dataset/test/subject_test.txt" and
## "UCI HAR Dataset/train/subject_train.txt", and merge them
readAdditionalFile <- function(dataDirectory, filePath) {
        filePathTest <- paste(dataDirectory, "/test/", filePath, "_test.txt", sep="")
        filePathTrain <- paste(dataDirectory, "/train/", filePath, "_train.txt", sep="")
        data <- c(read.table(filePathTest)[,"V1"], read.table(filePathTrain)[,"V1"])
        data
}

## Correct a feature name - makes it nicer for dataframe columns (removes parentheses)
## because otherwise they are transformed to dots.
## * featureName: name of the feature
correctFeatureName <- function(featureName) {
        featureName <- gsub("\\(", "", featureName)
        featureName <- gsub("\\)", "", featureName)
        featureName
}

## Read sets and returns a complete sets
## * dataDirectory: directory of data
readSets <- function(dataDirectory) {
        # Adding main data files (X_train and X_test)
        featuresFilePath <- paste(dataDirectory, "/features.txt", sep="")
        features <- read.table(featuresFilePath)[,"V2"]
        filteredFeatures <- sort(union(grep("mean\\(\\)", features), grep("std\\(\\)", features)))
        features <- correctFeatureName(features)
        set <- readBaseSet(paste(dataDirectory, "/test/X_test.txt", sep=""), filteredFeatures, features)
        set <- rbind(set, readBaseSet(paste(dataDirectory, "/train/X_train.txt", sep=""), filteredFeatures, features))
        
        # Adding subjects
        set$subject <- readAdditionalFile("UCI HAR Dataset", "subject")
        
        # Adding activities
        activitiesFilePath <- paste(dataDirectory, "/activity_labels.txt", sep="")
        activities <- read.table(activitiesFilePath)[,"V2"]
        set$activity <- activities[readAdditionalFile("UCI HAR Dataset", "y")]
        
        set
}

## From sets, creates the tidy dataset (a summary)
## * dataDirectory: directory of data
createSummaryDataset <- function(dataDirectory) {
        sets <- readSets(dataDirectory)
        sets_x <- sets[,seq(1, length(names(sets)) - 2)]
        summary_by <- by(sets_x,paste(sets$subject, sets$activity, sep="_"), FUN=colMeans)
        summary <- do.call(rbind, summary_by)
        summary
}

dataDirectory <- "UCI HAR Dataset"
if (!file.exists(dataDirectory)) {
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        tmp_file <- "./temp.zip"
        download.file(url,tmp_file, method="curl")
        unzip(tmp_file, exdir="./")
        unlink(tmp_file)
}

## Create the tidy.txt file
summary <- createSummaryDataset(dataDirectory)
write.table(summary, "tidy.txt", row.name=FALSE)
