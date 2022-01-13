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
## Creating filtering condition for coal sources
######################################################################################################

filter_data <- SCC %>% 
  filter(str_detect(EI.Sector,"Coal")) %>% 
  select(SCC) %>% 
  mutate (SCC = as.character(SCC))


######################################################################################################
## Filtering and aggregating data for ploting
######################################################################################################

usa_coal <- NEI %>%
  inner_join(filter_data, by = c("SCC", "SCC")) %>%
  group_by(year) %>%
  summarize(Value = sum(Emissions))


######################################################################################################
## Plotting data to png format
######################################################################################################

png(file="plot4.png",
    width=480, height=480)
with(usa_coal, plot(year, Value, type = "l", main = "Total PM2.5 emission in USA from coal", xlab = "Year", ylab = "PM2.5 value"))
dev.off()
