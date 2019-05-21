#Read in packages and data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

#Subset Vehicles by Baltimore
vehicles_code<-subset(SCC, grepl("Vehicle", Short.Name) | grepl("vehicle", Short.Name))
vehicles_subset<-subset(NEI, SCC %in% vehicles_code$SCC)
vehicles_subset<-vehicles_subset[vehicles_subset$fips == "24510",]

#Sum across vehicle and year
Emissions_vehicle_type<-aggregate(Emissions ~ year, vehicles_subset, sum)

#Plot
png(filename = "plot5.png",width = 480,height = 480)

vehicle_plot<-qplot(year, Emissions, data=Emissions_vehicle_type, geom="line") + 
  ggtitle('Vehicle Emissions for Baltimore')+
  geom_point(color='red')+
  geom_line(color='red')
print(vehicle_plot)

dev.off()