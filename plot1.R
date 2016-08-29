#EXPLORATORY DATA ANALYSIS PROJECT 1
#Code for Plot 1

if(!file.exists("data")) {
        dir.create("data")
}

fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/powerconsumption.zip")
unzip(zipfile="./data/powerconsumption.zip",exdir="./data")

library(dplyr)
# reading in the data
powerConsumption <- read.table("./data/household_power_consumption.txt", header= TRUE, sep =";", na.strings = "?")
head(powerConsumption)
str(powerConsumption)


powerConsumption <- tbl_df(powerConsumption)

#Subsetting the data for the required dates
consumptionDate <- filter(powerConsumption, grepl("^[1,2]/2/2007", Date))
#Could also use ConsumptionDate <- powerConsumption[powerConsumption$Date %in% c("1/2/2007","2/2/2007") ,]

# Checking the dimension, head and tail
dim(consumptionDate)
head(consumptionDate)
tail(consumptionDate)
#Converting gloabal active power to numeric
globalActivePower <- as.numeric(consumptionDate$Global_active_power, na.rm = TRUE)

#Plotting the graph as png
png("plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()