## Question
###################################
## Files plot4.R	--	plot4.png
###################################
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
###################################

## Install ggplot2 package
install.packages("ggplot2")
library(ggplot2)

## Clear session of earlier variables
rm(list=ls())

## Read RDS files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge both datasets
NEI_SCC <- merge(NEI, SCC, by = "SCC")

## Capture 'coal' from EI.Sector
NEI_SCC_COAL <- subset(NEI_SCC, grepl("coal", EI.Sector, ignore.case=TRUE)) 

## Total Emissions Coal by Year
totalEmissionsCoal <- with(NEI_SCC_COAL, tapply(Emissions, year, sum, na.rm=TRUE))

## Convert to Numeric and create 'year' var
year <- as.numeric(names(totalEmissionsCoal))  ## check type using str

## Remove dimnames from 'totalEmissionsByYear'
totalEmissions <- unname(totalEmissionsCoal)

## Create DataFrame
totalEmissions <- data.frame(year=year, total=totalEmissions)

## Create plot4.png using ggsave instead
###################################

## Create text for y-label and main
xlabtext <- "Year"
ylabtext <- expression(paste('Total PM', ''[2.5], ' Emissions'))
maintext <- expression(paste('Total PM', ''[2.5], ' Emissions from Coal Combustion related Sources by Year'))

#############################
g <- ggplot(data=totalEmissions, aes(x=factor(year), y=total)) + geom_line(aes(group=1)) + ggtitle(maintext) + ylab(ylabtext) + xlab(xlabtext)
print(g)

## Save Plot
ggsave('plot4.png', width=8, height=7)

#############################
