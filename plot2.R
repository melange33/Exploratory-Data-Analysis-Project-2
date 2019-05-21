#Read in packages

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Question 2
#Subset Baltimore
Balt_Emissions<-NEI[NEI$fips == "24510",]

#Sum Across year
Balt_Emissions<-tapply(Balt_Emissions$Emissions,Balt_Emissions$year,sum)

#Plot
png(filename = "plot2.png",width = 480,height = 480)
plot(names(Balt_Emissions),Balt_Emissions,xlab="Year",ylab="Total Emissions",main="Baltimore Emissions",type="o",col="blue")
dev.off()