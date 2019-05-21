#Read in packages

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Question 1
#sum across year
Total_Emissions<-tapply(NEI$Emissions,NEI$year,sum)

#Plot
png(filename = "plot1.png",width = 480,height = 480)
plot(names(Total_Emissions),Total_Emissions,xlab="Year",ylab="Total Emissions",main="Sum of Emissions",type="o",col="red")


dev.off()