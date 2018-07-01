# Question 3:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999–2008 for Baltimore City? Which have seen increases in 
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
# answer this question.

# Load library
library(ggplot2)

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset of Baltimore City, Maryland
nei2 <- subset(NEI, fips=="24510")

# Aggregate the total PM2.5 emissions 
agg <- aggregate(Emissions ~ year + type, nei2, sum)

# Setting output to png file
png('plot3.png')

# Make the plot
g <- ggplot(agg, aes(factor(year), Emissions, group=1)) + 
  geom_bar(stat="identity") + 
  facet_grid( .~ type) + 
  theme_bw() +
  guides(fill=FALSE) +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Type")) +
  geom_smooth(size = 1, color = "red", linetype = 2, method = "lm", se = FALSE)

print(g)

# Finish the image
dev.off()
