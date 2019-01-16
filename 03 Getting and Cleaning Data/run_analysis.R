## Author: John Letteboer
## Date: April 14, 2018
## -------------------------------------------
##  Getting and Cleaning Data: Course Project 
## -------------------------------------------
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# ============================== #
# Preparing the script variables #
# ============================== #
message("Preparing the script variables")

list.of.packages <- c("data.table", "plyr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) {
        message("   - Installing required packages")
        install.packages(new.packages, quiet = TRUE)
}

# Create and change to project directory
message("   - Create and change to project directory")
project_dir <- "./Getting and Cleaning Data"
dir.create(project_dir, showWarnings = FALSE, recursive = TRUE)
setwd(project_dir)

# Setting variables for downloading and unzipping data
message("   - Setting variables for downloading and unzipping data")
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
datadir <- "./data"
org_dataset <- paste(datadir, "/org_dataset.zip", sep="")
unzipped_dir <- paste(datadir, "/UCI HAR Dataset", sep="")

# Check if data directory exists
message("   - Check if data directory exists, if dataset is already downloaded and unzipped")
if (!file.exists(datadir)) {
        dir.create(datadir)
}

# Check if data is already downloaded else download data and save file to working directory
if (!file.exists(org_dataset)) {
        download.file(fileUrl, destfile = org_dataset, method = "auto")
        dateDownloaded <- date()
}

# Check if data is already unzipped else unzip it
if (!file.exists(unzipped_dir)) {
        c <- unzip(org_dataset, exdir = datadir)
}

# ============================================== #
# 0. Reading Activity, Subject and Feauture data #
# ============================================== #
message("Reading Activity, Subject and Feauture data")

# Read the activity files
message("   - Read the activity files")
act_train <- read.table(file.path(unzipped_dir, "train", "Y_train.txt"), header = FALSE)
act_test  <- read.table(file.path(unzipped_dir, "test" , "Y_test.txt" ), header = FALSE)

# Read the subject files
message("   - Read the subject files")
sub_train <- read.table(file.path(unzipped_dir, "train", "subject_train.txt"), header = FALSE)
sub_test  <- read.table(file.path(unzipped_dir, "test" , "subject_test.txt"), header = FALSE)

# Read the features files
message("   - Read the features files")
ft_train <- read.table(file.path(unzipped_dir, "train", "X_train.txt"), header = FALSE)
ft_test  <- read.table(file.path(unzipped_dir, "test" , "X_test.txt" ), header = FALSE)
ft_names <- read.table(file.path(unzipped_dir, "features.txt"), header = FALSE)

# =============================================================== #
# 1. Merges the training and the test sets to create one data set #
# =============================================================== #
message("1. Merges the training and the test sets to create one data set")

activity <- rbind(act_train, act_test)
subject <- rbind(sub_train, sub_test)
features <- rbind(ft_train, ft_test)

names(subject) <- c("subject")
names(activity) <- c("activity")
names(features) <- ft_names$V2

combine <- cbind(subject, activity)
full_data <- cbind(features, combine)

# ========================================================================================= #
# 2. Extracts only the measurements on the mean and standard deviation for each measurement #
# ========================================================================================= #
message("2. Extracts only the measurements on the mean and standard deviation for each measurement")

extract_features <- ft_names$V2[grep("mean\\(\\)|std\\(\\)", ft_names$V2)]

selected_names <- c(as.character(extract_features), "subject", "activity" )
full_data <- subset(full_data, select = selected_names)

# ========================================================================= #
# 3. Uses descriptive activity names to name the activities in the data set #
# ========================================================================= #
message("3. Uses descriptive activity names to name the activities in the data set")

activity_labels <- read.table(file.path(unzipped_dir, "activity_labels.txt"), header = FALSE)

full_data$activity <- factor(full_data$activity)
full_data$activity <- factor(full_data$activity, labels = as.character(activity_labels$V2))

# -------------------------------------------------------------------- #
# 4. Appropriately labels the data set with descriptive variable names #
# -------------------------------------------------------------------- #
message("4. Appropriately labels the data set with descriptive variable names")

names(full_data) <- gsub("^t", "time", names(full_data))
names(full_data) <- gsub("^f", "frequency", names(full_data))
names(full_data) <- gsub("Acc", "Accelerometer", names(full_data))
names(full_data) <- gsub("Gyro", "Gyroscope", names(full_data))
names(full_data) <- gsub("Mag", "Magnitude", names(full_data))
names(full_data) <- gsub("BodyBody", "Body", names(full_data))

# ------------------------------------------------------------------------------------------------------------------------------------------------ #
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject #
# ------------------------------------------------------------------------------------------------------------------------------------------------ #
message("5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject")

tidydata <- aggregate(. ~subject + activity, full_data, mean)
tidydata <- tidydata[order(tidydata$subject,tidydata$activity),]
write.table(tidydata, file = "tidydata.txt", row.name=FALSE)

# Show finish message
message("---")
message("Finished, you can found the tidy dataset in the project directory ", "\"", project_dir, "\"")
