## Question
###################################
## Files plot2.R	--	plot2.png
################################
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.
################################

## Clear session of earlier variables
rm(list=ls())

## Read RDS file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset 'fips' from NEI dataset
baltimore <- subset(NEI, NEI$fips=="24510")
dim(baltimore)	## 2096 6
head(baltimore)
names(baltimore)

## sum(baltimore$Emissions, na.rm=T) ## 10681.73
## mean(baltimore$Emissions, na.rm=T) ## 5.096

## Get totals by year for Baltimore
totalEmissionsBaltimore <- with(baltimore, tapply(Emissions, year, sum, na.rm=TRUE))

## Convert to Numeric and create 'year' var
year <- as.numeric(names(totalEmissionsBaltimore))  ## check type using str
str(year)   ## num [1:4]

## Remove dimnames from 'totalEmissionsByYear'
totalEmissionsBaltimore <- unname(totalEmissionsBaltimore)

## No need to decrease scale since all are in range
## 3274.180 2453.916 3091.354 1862.282

## Create a data.frame to use for plotting
totalEmissions <- data.frame(year=year, total=totalEmissionsBaltimore)

## Create plot2.png
png(file="plot2.png")

## Create text for y-label and main
ylabtext <- expression(paste('Total PM', ''[2.5], ' Emissions in Baltimore City, MD'))
maintext <- expression(paste('Total PM', ''[2.5], ' Emissions in Baltimore City, MD by Year'))

## Create barplot
barplot(totalEmissions$total, names.arg=totalEmissions$year, xlab="Year", ylab=ylabtext, pch=19, main=maintext)

## Turn device off
dev.off()
