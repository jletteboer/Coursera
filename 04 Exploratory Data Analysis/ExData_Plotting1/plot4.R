## Author: John Letteboer
## Date: June 1, 2018
## ---------------------------------------------
## Exploratory Data Analysis: Course Project 1
## ---------------------------------------------
## This is script 4/4
## Output is plot4.png

png_file <- "plot4.png"

source("load_dataset.R")

# Setting output to png file
png(png_file, width=480, height=480)

par(mfrow=c(2,2))

plot(df$Time, df$Global_active_power, 
     type="l",
     xlab="",
     ylab="Global Active Power")

plot(df$Time, df$Voltage, 
     type="l",
     xlab="datetime",
     ylab="Voltage")

plot(df$Time, df$Sub_metering_1, 
     type="l", 
     xlab="",
     ylab="Energy sub metering",
     main="",
     col = "black")
lines(df$Time, df$Sub_metering_2, type="l", col = "red")
lines(df$Time, df$Sub_metering_3, type="l", col = "blue")
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black","red","blue"), 
       lty=1, 
       bty="n")

plot(df$Time, df$Global_reactive_power, 
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")


#"Finish" the image
dev.off()

