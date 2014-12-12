NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

subsetNEI <- subset(NEI,year==1999|year==2002|year==2005|year==2008)
plot(subsetNEI$year,as.numeric(as.character(subsetNEI$Emissions)),type="h")
