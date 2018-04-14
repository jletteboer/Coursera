# Getting and Cleaning Data: Course Project 
##### (Human Activity Recognition Using Smartphones Data Set)

## Requirements
You need an internet connection for downloading the dataset and the missing packages.

## About the Code Book
The CodeBook.md file describes the variables, the data, and any transformations or work that you performed to clean up the data.

## The steps the script will do
Very simple.... The script will do everything for you. :) It will

- install the required packages if needed;
- create the project directory called "~/Data Analysis/Coursera/Getting and Cleaning Data";
- download the data source and store it into the project folder;
- create a data direcory in the project folder;
- unzip the downloaded file to the data directory;
- merges the training and the test sets to create one data set;
- extracts only the measurements on the mean and standard deviation for each measurement;
- uses descriptive activity names to name the activities in the data set;
- appropriately labels the data set with descriptive activity names;
- creates a second, independent tidy data set with the average of each variable for each activity and each subject;
- Saves a file tidydata.txt into your project directory.

## Running the script
The only thing you have to do is to run the code:
`source("run_analysis.R")`

After running, you will see the following output as the script works:

	Preparing the script variables
	   - Installing required packages
	   - Create and change to project directory
	   - Setting variables for downloading and unzipping data
	   - Check if data directory exists, if dataset is already downloaded and unzipped
	Reading Activity, Subject and Feauture data
	   - Read the activity files
	   - Read the subject files
	   - Read the features files
	1. Merges the training and the test sets to create one data set
	2. Extracts only the measurements on the mean and standard deviation for each measurement
	3. Uses descriptive activity names to name the activities in the data set
	4. Appropriately labels the data set with descriptive variable names
	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
	---
	Finished, you can found the tidy dataset in the project directory "./Getting and Cleaning Data"
