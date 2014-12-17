library('ggplot2')
# Reads data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Filters Baltimore rows
subsetBaltimore <- subset(NEI,fips=="24510")
# Aggregates Baltimore data in a data.frame
result <- aggregate(as.numeric(subsetBaltimore$Emissions),by=list(subsetBaltimore$year,subsetBaltimore$type),FUN=sum)
colnames(result)<-c('year','type','emissions')
data_result<-data.frame(result)
# Plots data to file
png('plot3.png')
c<-ggplot(data=data_result, aes(x=year, y=emissions,fill=type,colour=type))+geom_line()+geom_point()
print(c)
dev.off()
