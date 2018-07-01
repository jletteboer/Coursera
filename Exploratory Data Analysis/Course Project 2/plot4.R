# Question 4:
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

# Load library
library(ggplot2)

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get Coal related
coal_related <- grepl("coal|comb", SCC$EI.Sector, ignore.case = TRUE)
coal_related <- SCC[coal_related,]
coal_related <- NEI[NEI$SCC %in% coal_related$SCC,]

# Aggregate the total PM2.5 emissions 
agg <- aggregate(Emissions ~ year, coal_related, sum)

# Setting output to png file
png('plot4.png')

# Make the plot
g <- ggplot(agg, aes(factor(year), Emissions/10^6)) + 
  geom_bar(stat="identity") + 
  theme_bw() +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions coal combustion related sources")) 

print(g)

# Finish the image
dev.off()
