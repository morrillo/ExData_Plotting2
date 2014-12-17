# Loads ggplot2 library
library('ggplot2')
# Reads data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# filters Baltimore and External Combustion information
subsetBaltimore <- subset(NEI,fips=="24510")
filter_scc <- SCC[,c('SCC','Short.Name','SCC.Level.One')]
filtered_scc <- filter_scc[grep("External Combustion",filter_scc$SCC.Level.One,ignore.case=T),]

# Merges Baltimore and classificaton table for external combustion emissions
data_merge <- merge(subsetBaltimore,filtered_scc,by="SCC")
# Aggregates results in data frame
result <- aggregate(as.numeric(data_merge$Emissions),by=list(data_merge$year,data_merge$Short.Name),FUN=sum)
colnames(result)<-c('year','SCC','emissions')
data_result<-data.frame(result)

# plots data
png('plot5.png')
c<-ggplot(data=data_result,aes(x=year,y=emissions,fill=SCC,colour=SCC))+geom_line()+geom_point()
print(c)
dev.off()
