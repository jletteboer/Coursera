# Question 5:
# How have emissions from motor vehicle sources changed from 1999–2008 in 
# Baltimore City?

# Load library
library(ggplot2)

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset of Baltimore City, Maryland
nei2 <- subset(NEI, fips=="24510")

# Get motor vehicle related
vehicle_related <- grepl("vehicle", SCC$EI.Sector, ignore.case = TRUE)
vehicle_related <- SCC[vehicle_related,]
vehicle_related <- nei2[nei2$SCC %in% vehicle_related$SCC,]

# Aggregate the total PM2.5 emissions 
agg <- aggregate(Emissions ~ year, vehicle_related, sum)

# Setting output to png file
png('plot5.png')

# Make the plot
g <- ggplot(agg, aes(factor(year), Emissions)) + 
  geom_bar(stat="identity") + 
  theme_bw() +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions from motor vehicle related sources in Baltimore City")) 

print(g)

# Finish the image
dev.off()
