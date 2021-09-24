## Question
###################################
## Files plot6.R	--	plot6.png
###################################
## Compare emissions from motor vehicle sources in Baltimore City with emissions from 
## motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?
###################################

## Clear session of earlier variables
rm(list=ls())

## Install ggplot2 package
install.packages("ggplot2")
library(ggplot2)

## Read RDS files
NEI <- readRDS("summarySCC_PM25.rds")               ## 6497651
SCC <- readRDS("Source_Classification_Code.rds")

## Merge both datasets
NEI_SCC <- merge(NEI, SCC, by="SCC")    # 6497561

## Capture 'coal' from EI.Sector
NEI_SCC_VEHICLE <- subset(NEI_SCC, grepl("vehicle", SCC.Level.Two, ignore.case=TRUE)) 

## Now subset on fips == Balitore or Los Angeles
NEI_SCC_LA  <- subset(NEI_SCC_VEHICLE, fips == "06037")  # 2717
NEI_SCC_BAL <- subset(NEI_SCC_VEHICLE, fips == "24510")  # 2717

## Add cities to frames
NEI_SCC_BAL$city <- "Baltimore City"
NEI_SCC_LA$city <- "Los Angeles City"

# Combine the two subsets with city name into one data frame
NEI_SCC_LA_BAL <- rbind(NEI_SCC_BAL,NEI_SCC_LA)

## Total Emissions by Year
totalEmissionsCities <- with(NEI_SCC_LA_BAL, tapply(Emissions, year, sum, na.rm=TRUE))

## Convert to Numeric and create 'year' var
year <- as.numeric(names(totalEmissionsCities))  ## check type using str

## Remove dimnames from 'totalEmissionsByYear'
totalEmissions <- unname(totalEmissionsCities)

## Create DataFrame
totalEmissions <- data.frame(year=year, total=totalEmissions)

## Create plot6.png using ggsave instead
###################################

## Create text for y-label and main
xlabtext <- "Year"
ylabtext <- expression(paste('Total PM', ''[2.5], ' Emissions'))
maintext <- expression(paste('Motor Vehicles PM', ''[2.5], ' Emissions Comparison -- LA Coounty and Baltimore City'))
 
## Create ggplot
g <- ggplot(NEI_SCC_LA_BAL, aes(x=factor(year), y=Emissions, fill=city))
g + geom_bar(stat="identity", position="dodge") + labs(x = xlabtext) + labs(y = ylabtext) + labs(title = maintext)
ggsave('plot6.png', width=8, height=7)

# print(g)
# dev.off()
