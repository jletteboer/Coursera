# Question 6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips=="06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Load library
library(ggplot2)

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset of Baltimore City, Maryland
nei2 <- subset(NEI, fips=="24510")
nei2$City <- "Baltimore City"
nei3 <- subset(NEI, fips=="06037")
nei3$City <- "Los Angeles County"

# Combine both
both <- rbind(nei2,nei3)

# Get motor vehicle related
vehicle_related <- grepl("vehicle", SCC$EI.Sector, ignore.case = TRUE)
vehicle_related <- SCC[vehicle_related,]
vehicle_related <- both[both$SCC %in% vehicle_related$SCC,]

# Aggregate the total PM2.5 emissions 
agg <- aggregate(Emissions ~ year + City, vehicle_related, sum)

# Setting output to png file
png('plot6.png')

# Make the plot
g <- ggplot(agg, aes(factor(year), Emissions)) + 
  geom_bar(stat="identity") + 
  facet_grid( .~ City) + 
  theme_bw() +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions from motor vehicle in Baltimore City & Los Angeles")) 

print(g)

# Finish the image
dev.off()
