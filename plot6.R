# Lodas ggplot2 library
library('ggplot2')
# reads data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filters Baltimore and LA data
subsetBaltimore <- subset(NEI,fips=="24510")
subsetLosAngeles <- subset(NEI,fips=="06037")
subsetCities <- rbind(subsetBaltimore,subsetLosAngeles)
# filters External Combustion SCC names
filter_scc <- SCC[,c('SCC','Short.Name','SCC.Level.One')]
filtered_scc <- filter_scc[grep("External Combustion",filter_scc$SCC.Level.One,ignore.case=T),]

# Merge emission data with descriptive emission data
data_merge <- merge(subsetCities,filtered_scc,by="SCC")
result <- aggregate(as.numeric(data_merge$Emissions),by=list(data_merge$year,data_merge$fips),FUN=sum)
colnames(result)<-c('year','city','emissions')
data_result<-data.frame(result)

# Adds city names to result
cities = data.frame(c('24510','06037'),c('Baltimore','Los Angeles County'))
colnames(cities) <- c('city','city_name')
data_merge <- merge(data_result,cities,by="city")

# Plots data
png('plot6.png')
c<-ggplot(data=data_merge,aes(x=as.factor(year),y=emissions,fill=city_name,colour=city_name))+geom_bar(stat="identity",position=position_dodge())+xlab("Year")+ylab("Emissions")
print(c)
dev.off()
