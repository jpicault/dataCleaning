# Human Activity Recognition Using Smartphones Dataset Version 2.0 (tidy version)

## Background
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

The orginal data set has been programmatically processed to obtain a tidy data set.

## Code book

### Variables
Here is the list of variables of the tidy data set.
Most of the variables are indexed by "mean" or "std" depending if it relates to a mean or standard deviation measurement. XYZ is used to denote 3-axial signals in the X, Y, Z directions.
At the beginning of the name of the variable, "t" refers to time and "f" to frequency domain signals.

* subject
* activity
* tBodyAcc[mean|std][XYZ]
* tGravityAcc[mean|std][XYZ]                
* tBodyAccJerk[mean|std][XYZ]
* tBodyGyro[mean|std][XYZ]
* tBodyGyroJerk[mean|std][XYZ]
* tBodyAccMag[mean|std]
* tGravityAccMag[mean|std]
* tBodyAccJerkMag[mean|std]
* tBodyGyroMag[mean|std]
* tBodyGyroJerkMag[mean|std]
* fBodyAcc[mean|std][XYZ]
* fBodyAccmeanFreq[XYZ]
* fBodyAccJerk[mean|std][XYZ]
* fBodyAccJerkmeanFreq[XYZ]
* fBodyGyro[mean|std][XYZ]
* fBodyGyromeanFreq[XYZ]
* fBodyAccMag[mean|std]
* fBodyAccMagmeanFreq
* fBodyBodyAccJerkMag[mean|std]
* fBodyBodyAccJerkMagmeanFreq
* fBodyBodyGyroMag[mean|std]
* fBodyBodyGyroMagmeanFreq
* fBodyBodyGyroJerkMag[mean|std]
* fBodyBodyGyroJerkMagmeanFreq 
* angletBodyAccMeangravity
* angletBodyAccJerkMeangravityMean
* angletBodyGyroMeangravityMean 
* angletBodyGyroJerkMeangravityMean
* angle[XYZ]gravityMean

### Data
The processing results is 180 observations (30 subjects * 6 activities) according to the 88 variables listed below.

### Transformations to clean up the data
Here is a short list of the transformations that have been applied on the original data:
* Merging of the training and the test sets to create one data set: we have concatenated the data in the following way:
    + combination by columns to group together all data relating to test: add to X_test the rows about y_test and subject_test;
    + do the same with the _train data
    + concatenate the other data by rows: combine then the two datasets (test / train)
    
* filtering of variables
    + we have kept only the variables referring to a mean or a standard deviation measurement
    
* renaming of labels of variables
    + we have removed from the variable names all special characters
  
* replacing non-explicit activities values with their associated textual description  
    
* average each variable for each activity and each subject (because for each variable, there were several observations for a given pair subject-activity) 