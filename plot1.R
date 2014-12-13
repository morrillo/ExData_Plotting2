NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

subsetNEI <- subset(NEI,year==1999|year==2002|year==2005|year==2008)
result <- aggregate(as.numeric(as.character(subsetNEI$Emissions)),by=list(subsetNEI$year),FUN=sum)
data_result <- data.frame(result)
colnames(data_result)<-c('Year','Emissions')
barplot(data_result$Emissions,legend=data_result$Year,col=c('blue','yellow','red','green'),main="Total Emissions from PM2.5",names=c("1999","2002","2005","2008"))

