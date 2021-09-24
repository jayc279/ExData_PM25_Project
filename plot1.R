## Question
###################################
## Files plot1.R	--	plot1.png
###################################
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 
## 1999, 2002, 2005, and 2008.
###################################

## Clear session of earlier variables
rm(list=ls())

## Read RDS file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## check first few lines of NEI dataset
head(NEI)

## Get totals by year for years
totalEmissionsByYear <- with(NEI, tapply(Emissions, year, sum, na.rm=TRUE))

## Convert to Numeric and create 'year' var
year <- as.numeric(names(totalEmissionsByYear))  ## check type using str
str(year)   ## num [1:4]

## Remove dimnames from 'totalEmissionsByYear'
totalEmissionsByYear <- unname(totalEmissionsByYear)

## Divide by 1000 to decrease scale
totalEmissionsByYear <- floor(totalEmissionsByYear / 1000)

## Create a data.frame to use for plotting
totalEmissions <- data.frame(year=year, total=totalEmissionsByYear)

## Create plot1.png
png(file="plot1.png")

## Create text for y-label and main
ylabtext <- expression(paste('Total PM', ''[2.5], ' Emissions in Kilotons'))
maintext <- expression(paste('Total PM', ''[2.5], ' Emissions in Kilotons by Year'))

## Create barplot
barplot(totalEmissions$total, names.arg=totalEmissions$year, xlab="Year", ylab=ylabtext, pch=19, main=maintext)

## Turn device off
dev.off()
