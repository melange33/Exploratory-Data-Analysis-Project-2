#Read in packages and data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

#Seclect Baltimore
Balt_Emissions<-NEI[NEI$fips == "24510",]

#Sum across year and type
Balt_Emissions_yt<-aggregate(Emissions ~ year + type, Balt_Emissions, sum)

#Plot
png(filename = "plot3.png",width = 480,height = 480)

plot_agg<-ggplot(Balt_Emissions_yt, aes(year, Emissions, color = type))
plot_agg<-plot_agg + geom_line() +
  xlab("Year") +
  ylab('Total Emissions') +
  ggtitle('Baltimore Emissions by Year and Type')
print(plot_agg)

dev.off()