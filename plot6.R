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
## Filtering data for two cities and mobile sources
######################################################################################################

baltimore_mobile <- NEI %>%
  filter(fips == "24510") %>%
  inner_join(mobile_filter, by = c("SCC", "SCC")) %>%
  group_by(year) %>%
  summarize(Value = sum(Emissions)) %>%
  mutate(City = "Baltimore")

los_ageles_mobile <- NEI %>%
  filter(fips == "06037") %>%
  inner_join(mobile_filter, by = c("SCC", "SCC")) %>%
  group_by(year) %>%
  summarize(Value = sum(Emissions)) %>%
  mutate(City = "Los Angeles")


######################################################################################################
## Binding sources to one dataframe
######################################################################################################

baltimore_los_angeles <- bind_rows(baltimore_mobile,los_ageles_mobile)

######################################################################################################
## Plotting data to png format
######################################################################################################

png(file="plot6.png",
    width=480, height=480)
ggplot(baltimore_los_angeles, aes(year, Value, color = City)) +
  geom_line() + 
  labs(title = "Total PM2.5 emission in Baltimore and Los Angeles from mobile sources",
       x = "Year",
       y = "PM2.5 value")
dev.off()
