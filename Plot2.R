#EXPLORATORY DATA ANALYSIS PROJECT 1
#Code for Plot 2

if(!file.exists("data")) {
        dir.create("data")
}

fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/powerconsumption.zip")
unzip(zipfile="./data/powerconsumption.zip",exdir="./data")

library(dplyr)

# Reading in the data
powerConsumption <- read.table("./data/household_power_consumption.txt", header= TRUE, sep =";", na.strings = "?")
powerConsumption <- tbl_df(powerConsumption)

#Subsetting the data for the required dates
consumptionDate <- filter(powerConsumption, grepl("^[1,2]/2/2007", Date))
#Could also use ConsumptionDate <- powerConsumption[powerConsumption$Date %in% c("1/2/2007","2/2/2007") ,]

# Converting the gobal active power variable to numeric
globalActivePower <- as.numeric(consumptionDate$Global_active_power, na.rm = TRUE)

# Converting date
timeDate <- strptime(paste(consumptionDate$Date, consumptionDate$Time), "%d/%m/%Y %H:%M:%S")

#Plotting the graph
png("plot2.png", width=480, height=480)
plot(timeDate,globalActivePower, type ="l", xlab = "", ylab = "Global Active Power(kilowatts)")
dev.off()
