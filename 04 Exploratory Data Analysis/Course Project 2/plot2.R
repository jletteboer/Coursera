# Question 2:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips=="24510") from 1999 to 2008? Use the base plotting system to make a 
# plot answering this question.

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset of Baltimore City, Maryland
nei2 <- subset(NEI, fips=="24510")

# Aggregate the total PM2.5 emissions 
agg <- aggregate(Emissions ~ year, nei2, sum)

# Setting output to png file
png('plot2.png')

# Make the plot
barplot(agg$Emissions/10^6, names.arg = agg$year, 
        xlab = "Year", 
        ylab=expression("PM"[2.5]*" Emissions (10^6 Tons)"),
        main = expression("Total PM"[2.5]* " Emissions in the United States"),
        col="lightblue")

# Finish the image
dev.off()
