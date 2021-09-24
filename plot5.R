## Question
###################################
## Files plot5.R	--	plot5.png
###################################
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
###################################

## Install ggplot2 package
install.packages("ggplot2")
library(ggplot2)

## Clear session of earlier variables
rm(list=ls())

## Read RDS files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Check how many per 'type'
table(NEI$type)
##
## NON-ROAD NONPOINT  ON-ROAD    POINT 
## 2324262   473759  3183599   516031 

## check str type and convert to factor
str(NEI$type)		## chr [1:6497651]

## Get all data for Baltimore City & type == 'ON-ROAD' and overwrite dataset
NEI <- subset(NEI, fips == '24510' & type == 'ON-ROAD')

totalEmissionsByYear <- with(NEI, tapply(Emissions, year, sum, na.rm=TRUE))

year <- as.numeric(names(totalEmissionsByYear))  ## check type using str
totalEmissionsByYear <- unname(totalEmissionsByYear)
totalEmissionsByYear <- floor(totalEmissionsByYear)

## Create Dataframe
totEmissions <- data.frame(year=year, total=totalEmissionsByYear)

## Create plot5.png using ggsave instead
###################################

## Create text for y-label and main
xlabtext <- "Year"
ylabtext <- expression(paste('Emissions from Motor Vehicles PM', ''[2.5], ''))
maintext <- expression(paste('Total Emissions from Motor Vehicle sources in Baltimore City'))

## Create ggplot
g <- ggplot(data=totEmissions, aes(x=factor(year), y=total)) 
g + geom_line(aes(group=1)) + ggtitle(maintext) + ylab(ylabtext) + xlab(xlabtext)

## Save Plot
ggsave('plot5.png', width=8, height=7)

