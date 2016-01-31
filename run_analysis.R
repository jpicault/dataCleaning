## This script is assumed to be run in the same directory as where the dataset is
## unzipped
# check we are able to fond the data as expected (not exhaustive check)
if (!((dir.exists("test")&dir.exists("train")&file.exists("features.txt"))))
  stop("Required files not found, please check working directory settings")

## Import required libraries for processing
library(dplyr)


#####
## First, read the data from disk; based on the formatting of the data source
## read.table is appropriate, with the default parameters
## Thus, we create the following dataframes objects
# read data for testing set
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# does the same with training data
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

#####
## 1. Merge the training and the test sets to create one data set
## str(X_test) to have a look at the data we imported
##
## by looking at dimensions using dim(X_test) etc. (on all data frames),
## we have to concatenate the data in the following way
## - by columns: add to X_test the rows about y_test and subject_test;
## - to the same with the _train data
## - by rows: combine then the two datasets (test / train) by row
## we use intermediary variables for lisibility, but this could be done in one step
##
## In this dataset, the variables are not clearly identified (V1..Vn)
## we are going to label properly the columns based on the features.txt file
## that contains the variables names used in X_train and X_test tables
features <- read.table("features.txt")
names(X_test) <- features$V2
names(X_train) <- features$V2

testing_set <- cbind(subject_test, y_test, X_test)
training_set <- cbind(subject_train, y_train, X_train)
tidy_data_set <- rbind(testing_set, training_set)

## renames also the 2 first columns that have been added to avoid confusion
# column 1 corresponds to the subject
colnames(tidy_data_set)[1] <- "subject"
# column 2 corresponds to the activity
colnames(tidy_data_set)[2] <- "activity"

#####
## 2. Extracts only the measurements on the mean and standard deviation for each
## measurement
##
## This means, that for each row, we have only to keep vars that represent
## a mean or a standard deviation.
## We base this criteria on the name of the feature (containg the words mean or std)
# first we determine the columns that match this criteria using a regular expression
matching_columns <- grep("mean|Mean|std|Std", names(tidy_data_set))
# then we select the right columns (those which do match the regex + the 2 first ones)
tidy_data_set <- tidy_data_set[, c(1,2,matching_columns)]


#####
## 3. Uses descriptive activity names to name the activities in the data set
##
# read the activity labels
activity_names <- read.table("activity_labels.txt")
activity_names <- select(activity_names,V2)
# substitute the id of activity in the data set with the name of the activity
tidy_data_set$activity <- activity_names[tidy_data_set$activity,]

####
## 4. Appropriately labels the dataset with descriptive variable names
##
# 
# In a previous step, the meaningless names V1... were already replaced
# Here, we are just going to "clean" a little bit the names, by removing
# for example the special characters - it could be possible to imagine other 
# patterns for substitution
colnames(tidy_data_set) <- gsub("\\(|\\)|-|_|,","",colnames(tidy_data_set))

####
## 5. Create a second, independent tidy data set with the average of each variable
## for each activity and each subject
##
# For each variable, there are several observations for a given pair subject-activity
# 5.1 Group data by subjects and then by activity, use dplyr
final_tidy_data <- group_by(tidy_data_set, subject, activity)
# this guarantees that further operations are going to be computed on these groups
# now we use this group to summarize the other variables
final_tidy_data <- summarise_each(final_tidy_data, funs(mean))

## we obtain a clean data set with only 180 observations

## export the final data set as a text file
##
if (!dir.exists("final"))  dir.create("final")
write.table(final_tidy_data,"final/final_data_set.txt",row.name=FALSE)

