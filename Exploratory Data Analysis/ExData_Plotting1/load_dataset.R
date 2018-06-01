## Author: John Letteboer
## Date: June 1, 2018
## ---------------------------------------------
## Exploratory Data Analysis: Course Project 1
## ---------------------------------------------
## The dataset has 2,075,259 rows and 9 columns. First calculate a rough 
## estimate of how much memory the dataset will require in memory before reading
## into R. Make sure your computer has enough memory (most modern computers 
## should be fine).
##
## We will only be using data from the dates 2007-02-01 and 2007-02-02. 
## One alternative is to read the data from just those dates rather than reading 
## in the entire dataset and subsetting to those dates.
##
## You may find it useful to convert the Date and Time variables to Date/Time 
## classes in R using the strptime() and as.Date() functions.
##
## Note that in this dataset missing values are coded as ?.
## 
## Data: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##

# Load complete dataset
df <- read.csv("household_power_consumption.txt", 
               sep = ";", 
               colClasses = c("character", "character", rep("numeric",7)), 
               na="?")

# Create subset of data, we need only two days as described above
df <- subset(df, Date == "1/2/2007" | Date == "2/2/2007")

# Format Date and Time Columns
df$Time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date,format="%d/%m/%Y")
