######################################################################################################
## Importing data files
## Use your data directory in setwd instead ~
######################################################################################################

setwd("~")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


######################################################################################################
## Importing libraries
######################################################################################################

library(dplyr)
library(ggplot2)
library(stringr)


######################################################################################################
## Filtering and aggregating data for plotting
######################################################################################################

baltimore_total <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarize(Value = sum(Emissions))


######################################################################################################
## Plotting data to png format
######################################################################################################

png(file="plot2.png",
    width=480, height=480)
with(baltimore_total, plot(year, Value, type = "l", main = "Total PM2.5 emission in Baltimore", xlab = "Year", ylab = "PM2.5 value"))
dev.off()
