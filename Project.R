#Read in files
setwd("~/Coursera/Data Analytics/Exploratory Analysis")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Question 1
#sum across year
Total_Emissions<-tapply(NEI$Emissions,NEI$year,sum)

#Plot
plot(names(Total_Emissions),Total_Emissions,xlab="Year",ylab="Total Emissions",main="Sum of Emissions",type="o",col="red")

#Question 2
#Subset Baltimore
Balt_Emissions<-NEI[NEI$fips == "24510",]

#Sum Across year
Balt_Emissions<-tapply(Balt_Emissions$Emissions,Balt_Emissions$year,sum)

#Plot
plot(names(Balt_Emissions),Balt_Emissions,xlab="Year",ylab="Total Emissions",main="Baltimore Emissions",type="o",col="blue")

#Question 3
library(ggplot2)

#Seclect Baltimore
Balt_Emissions<-NEI[NEI$fips == "24510",]

#Sum across year and type
Balt_Emissions_yt<-aggregate(Emissions ~ year + type, Balt_Emissions, sum)

#Plot
plot_agg<-ggplot(Balt_Emissions_yt, aes(year, Emissions, color = type))
plot_agg<-plot_agg + geom_line() +
  xlab("Year") +
  ylab('Total Emissions') +
  ggtitle('Baltimore Emissions by Year and Type')
print(plot_agg)

#Question 4
#Subset Coal
coal_subset<-subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))
coal_subset<-subset(NEI, SCC %in% coal_subset$SCC)

#Sum across year and type
coal_year_type<-aggregate(Emissions ~ year + type, coal_subset, sum)

#Plot
coalplot<-qplot(year, Emissions, data=coal_year_type, color=type, geom="line") + 
  ggtitle('Coal Emissions')+
  geom_line(color='blue')
print(coalplot)

#Question 5
#Subset Vehicles by Baltimore
vehicles_code<-subset(SCC, grepl("Vehicle", Short.Name) | grepl("vehicle", Short.Name))
vehicles_subset<-subset(NEI, SCC %in% vehicles_code$SCC)
vehicles_subset<-vehicles_subset[vehicles_subset$fips == "24510",]

#Sum across vehicle and year
Emissions_vehicle_type<-aggregate(Emissions ~ year, vehicles_subset, sum)

#Plot
vehicle_plot<-qplot(year, Emissions, data=Emissions_vehicle_type, geom="line") + 
  ggtitle('Vehicle Emissions for Baltimore')+
  geom_point(color='red')+
  geom_line(color='red')
print(vehicle_plot)

#Question 6
#Subset vehicles
vehicles_subset2<-subset(SCC, grepl("Vehicle", Short.Name) | grepl("vehicle", Short.Name))
vehicles_subset2<-subset(NEI, SCC %in% vehicles_subset2$SCC)
vehicles_subset2<-vehicles_subset2[vehicles_subset2$fips == "24510" | vehicles_subset2$fips == "06037",]

#Sum by year and fips and city
Emissions_vehicle_type2<-aggregate(Emissions ~ year * fips, vehicles_subset2, sum)
Emissions_vehicle_type2$county<-ifelse(Emissions_vehicle_type2$fips == "24510", "Baltimore", "Los Angeles")

#Plot
qplot(year, Emissions, data=Emissions_vehicle_type2, geom="line", color=county) + 
  ggtitle("Baltimore and LA Emissions") + 
  xlab("Year") + 
  ylab("Emissions")
