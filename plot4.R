#Read in packages and data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

#Subset Coal
coal_subset<-subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))
coal_subset<-subset(NEI, SCC %in% coal_subset$SCC)

#Sum across year and type
coal_year_type<-aggregate(Emissions ~ year + type, coal_subset, sum)

#Plot
png(filename = "plot4.png",width = 480,height = 480)

coalplot<-qplot(year, Emissions, data=coal_year_type, color=type, geom="line") + 
  ggtitle('Coal Emissions')
print(coalplot)

dev.off()