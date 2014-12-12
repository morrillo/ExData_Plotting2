library('ggplot2')

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

subsetBaltimore <- subset(NEI,fips=="24510")
result <- aggregate(as.numeric(subsetBaltimore$Emissions),by=list(subsetBaltimore$year,subsetBaltimore$SCC),FUN=sum)
colnames(result)<-c('year','SCC','emissions')

data_result<-data.frame(result)
ggplot(data=data_result, aes(x=year, y=emissions,fill=SCC,colour=SCC))+geom_line()+geom_point()

