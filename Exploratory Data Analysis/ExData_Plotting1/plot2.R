## Author: John Letteboer
## Date: June 1, 2018
## ---------------------------------------------
## Exploratory Data Analysis: Course Project 1
## ---------------------------------------------
## This is script 2/4
## Output is plot2.png

png_file <- "plot2.png"

source("load_dataset.R")

# Setting output to png file
png(png_file, width=480, height=480)

plot(df$Time, df$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

#"Finish" the image
dev.off()


