NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

subsetBaltimore <- subset(NEI,fips=="24510")
result<-aggregate(as.numeric(subsetBaltimore$Emissions),by=list(subsetBaltimore$year),FUN=sum)
barplot(result$x,col=c("blue","red","green","yellow"),legend=result$Group.1)

