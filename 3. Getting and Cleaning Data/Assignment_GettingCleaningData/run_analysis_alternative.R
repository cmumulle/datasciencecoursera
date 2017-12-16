# Getting and Cleaning Data Course Project

library(dplyr)

# Download dataset:
urll <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(urll, destfile = "./dataset.zip")
unzip("dataset.zip")

# Reading training data:
features_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
activitys_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjects_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Reading testing data:
features_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
activitys_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjects_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Reading feature and activity labels:
features_Labels <- read.table('./UCI HAR Dataset/features.txt', colClasses = "character")
activity_Labels <- read.table('./UCI HAR Dataset/activity_labels.txt')

# Merge the training and the test sets:
mrg_train <- cbind(subjects_train, activitys_train, features_train)
mrg_test <- cbind(subjects_test, activitys_test, features_test)
total_set <- rbind(mrg_train, mrg_test)

# Rename columns:
names(total_set) <- c("subject", "activitys", features_Labels$V2)

# Select mean and std:
index <- grepl("activitys|subject|mean|std", names(total_set), ignore.case = TRUE)
total_set <- total_set[index]

# Set descriptive activity names:
total_set$activitys <- factor(total_set$activitys,
                              levels = 1:6,
                              labels = activity_Labels$V2)

# Create tidy data set:
tidydata <- group_by(total_set, subject, activitys) %>% summarise_all(mean)

# Write tidy data set to the file:
write.table(tidydata, "TidyData.txt", row.name=FALSE)