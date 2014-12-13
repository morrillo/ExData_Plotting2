NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

subsetBaltimore <- subset(NEI,fips=="24510")
result<-aggregate(as.numeric(subsetBaltimore$Emissions),by=list(subsetBaltimore$year),FUN=sum)
barplot(result$x,col=c("blue","red","green","yellow"),legend=result$Group.1,main="Emissions from PM2.5 in Baltimore City",names=c("1999","2002","2005","2008"))
