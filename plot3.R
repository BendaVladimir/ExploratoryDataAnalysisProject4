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
## Filtering and aggregating data by year and type for plotting
######################################################################################################

baltimore_type <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  summarize(Value = sum(Emissions))


######################################################################################################
## Plotting data to png format
######################################################################################################

png(file="plot3.png",
    width=480, height=480)
ggplot(baltimore_type, aes(year, Value, color = type)) +
  geom_line() + 
  labs(title = "Total PM2.5 emission in Baltimore by source of emissions",
       x = "Year",
       y = "PM2.5 value")
dev.off()
