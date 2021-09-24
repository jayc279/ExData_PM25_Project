## Question
###################################
## Files plot3.R	--	plot3.png
###################################
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? 
## Use the ggplot2 plotting system to make a plot answer this question.
###################################

## Install ggplot2 package
install.packages("ggplot2")
library(ggplot2)

## Clear session of earlier variables
rm(list=ls())

## Read RDS files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## check first few lines of NEI dataset
head(NEI)

## Check how many per 'type'
table(NEI$type)
## NON-ROAD NONPOINT  ON-ROAD    POINT 
## 2324262   473759  3183599   516031 

## check str type and convert to factor
str(NEI$type)		## chr [1:6497651]

## Get all data for Baltimore City and overwrite dataset
NEI <- subset(NEI, NEI$fips=="24510")

## Convert NEI$type to "factor" -- str(NEI$type)  -- factor with 4 levels
NEI$type=as.factor(NEI$type)

## Convert to Numeric and create 'year' var
NEI$year <- as.numeric(NEI$year)  ## check type using str
str(NEI$year)   ## num [1:2096]

## Create plot3.png using ggsave instead
###################################

## Create text for y-label and main
xlabtext <- "Year"
ylabtext <- expression(paste('Total PM', ''[2.5], ' Emissions in Baltimore City, MD'))
maintext <- expression(paste('Total PM', ''[2.5], ' Emissions in Baltimore City, MD by Type/Year'))

## Create ggplot
g <- ggplot(NEI, aes(x=factor(year), y=Emissions, fill=type))
g + facet_grid(.~type) + geom_bar(stat="identity", position="dodge") + labs(x = xlabtext) + labs(y = ylabtext) + labs(title = maintext)
ggsave('plot3.png', width=8, height=7)

