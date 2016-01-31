# Human Activity Recognition Using Smartphones Dataset Version 2.0 (tidy version)

## Obtaining a tidy data set from the Samsung Galaxy S smartphone accelerometers data

### How to run the script?

* Please ensure the original data is available in the __working directory__
    + download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
    + unzip the dataset and ensure R is pointing to the root of this directory using the setwd() command
  
    + copy the R script __run_analysis.R__ in the same directory
  
  
* Run the script using the following R command
    + `source("run_analysis.R")`
  
  
* The script is going to create a new directory called "final" that contains the final tidy data set in a file called "final_data_set.txt"

* Please read `CodeBook.md` for details about variables and transformations that have been applied