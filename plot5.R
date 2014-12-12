library('ggplot2')

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

subsetBaltimore <- subset(NEI,fips=="24510")
filter_scc <- SCC[,c('SCC','Short.Name','SCC.Level.One')]
filtered_scc <- filter_scc[grep("External Combustion",filter_scc$SCC.Level.One,ignore.case=T),]

data_merge <- merge(subsetBaltimore,filtered_scc,by="SCC")
result <- aggregate(as.numeric(data_merge$Emissions),by=list(data_merge$year,data_merge$Short.Name),FUN=sum)
colnames(result)<-c('year','SCC','emissions')

data_result<-data.frame(result)
c<-ggplot(data=data_result,aes(x=year,y=emissions,fill=SCC,colour=SCC))
c + geom_line() + geom_point()
