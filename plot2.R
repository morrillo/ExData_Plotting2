# Reads data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filters Baltimore data
subsetBaltimore <- subset(NEI,fips=="24510")
# aggregates data
result<-aggregate(as.numeric(subsetBaltimore$Emissions),by=list(subsetBaltimore$year),FUN=sum)
data_result <- data.frame(result)
colnames(data_result)<-c('Year','Emissions')
## Plots data
png('plot2.png')
barplot(data_result$Emissions,col=c("blue","red","green","yellow"),legend=data_result$Year,names=c("1999","2002","2005","2008"),main="Emissions for Baltimore City",xlab="Year",ylab="Emissions")
dev.off()
