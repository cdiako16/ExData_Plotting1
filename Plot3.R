# EXPLORATORY DATA ANALYSIS PROJECT 1
# Code for Plot 3

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

# Converting date
timeDate <- strptime(paste(consumptionDate$Date, consumptionDate$Time), "%d/%m/%Y %H:%M:%S")

# Converting varibles to numeric
globalActivePower <- as.numeric(consumptionDate$Global_active_power, na.rm = TRUE)
subMetering1 <- as.numeric(consumptionDate$Sub_metering_1)
subMetering2 <- as.numeric(consumptionDate$Sub_metering_2)
subMetering3 <- as.numeric(consumptionDate$Sub_metering_3)

#Plotting graph
png("plot3.png", width=480, height=480)
plot(timeDate, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(timeDate, subMetering2, type="l", col="red")
lines(timeDate, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
dev.off()
