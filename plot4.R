# Loads ggplo2 library
library('ggplot2')

# reads data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filters Baltimore emissions and aggregates them
subsetBaltimore <- subset(NEI,fips=="24510")
result <- aggregate(as.numeric(subsetBaltimore$Emissions),by=list(subsetBaltimore$year,subsetBaltimore$SCC),FUN=sum)
# creates a data frame with aggregated data
colnames(result)<-c('year','SCC','emissions')
data_result<-data.frame(result)

# Merges Baltimore and classificaton table for external combustion emissions
filter_scc <- SCC[,c('SCC','Short.Name')]
filtered_scc <- filter_scc[grep("Coal",filter_scc$Short.Name,ignore.case=T),]
data_merge <- merge(data_result,filtered_scc,by="SCC")
colnames(data_merge) <- c('SCC','year','emissions','Short.Name')

# Plots data
png('plot4.png',width=960,height=960)
c <- ggplot(data=data_merge, aes(x=as.factor(year), y=emissions,fill=as.factor(Short.Name),colour=as.factor(Short.Name)))+geom_bar(stat="identity")+xlab("Year")+ylab("Emissions")+labs(title="Emissions from coal related sources in USA")
print(c)
dev.off()
