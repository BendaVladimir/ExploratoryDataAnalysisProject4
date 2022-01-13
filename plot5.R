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
## Creating filtering condition for mobile sources
######################################################################################################

mobile_filter <- SCC %>%
  filter(str_detect(EI.Sector, "Mobile")) %>% 
  select(SCC) %>% 
  mutate (SCC = as.character(SCC))


######################################################################################################
## Filtering and aggregating data for ploting
######################################################################################################

baltimore_mobile <- NEI %>%
  filter(fips == "24510") %>%
  inner_join(mobile_filter, by = c("SCC", "SCC")) %>%
  group_by(year) %>%
  summarize(Value = sum(Emissions))


######################################################################################################
## Plotting data to png format
######################################################################################################

png(file="plot5.png",
    width=480, height=480)
with(baltimore_mobile, plot(year, Value, type = "l", main = "Total PM2.5 emission in Baltimore from mobile vehicles", xlab = "Year", ylab = "PM2.5 value"))
dev.off()
