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

# Plots data
png('plot4.png')
c <- ggplot(data=data_result, aes(x=year, y=emissions,fill=SCC,colour=SCC))+geom_line()+geom_point()
print(c)
dev.off()
