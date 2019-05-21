#Read in packages and data
setwd("~/Coursera/Data Analytics/Exploratory Analysis")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

#Subset vehicles
vehicles_subset2<-subset(SCC, grepl("Vehicle", Short.Name) | grepl("vehicle", Short.Name))
vehicles_subset2<-subset(NEI, SCC %in% vehicles_subset2$SCC)
vehicles_subset2<-vehicles_subset2[vehicles_subset2$fips == "24510" | vehicles_subset2$fips == "06037",]

#Sum by year and fips and city
Emissions_vehicle_type2<-aggregate(Emissions ~ year * fips, vehicles_subset2, sum)
Emissions_vehicle_type2$county<-ifelse(Emissions_vehicle_type2$fips == "24510", "Baltimore", "Los Angeles")

#Plot
png(filename = "plot6.png",width = 480,height = 480)

plot6<-qplot(year, Emissions, data=Emissions_vehicle_type2, geom="line", color=county) + 
  ggtitle("Baltimore and LA Emissions") + 
  xlab("Year") + 
  ylab("Emissions")
print(plot6)
dev.off()