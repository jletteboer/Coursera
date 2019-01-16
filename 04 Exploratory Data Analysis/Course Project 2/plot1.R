# Question 1:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 
# 2008? Using the base plotting system, make a plot showing the total PM2.5 
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate the total PM2.5 emissions 
agg <- aggregate(Emissions ~ year, NEI, sum)

# Setting output to png file
png('plot1.png')

# Make the plot
barplot(agg$Emissions/10^6, names.arg = agg$year, 
        xlab = "Year", 
        ylab=expression("PM"[2.5]*" Emissions (10^6 Tons)"),
        main = expression("Total PM"[2.5]* " Emissions in the United States"),
        col="lightblue")

# Finish the image
dev.off()
