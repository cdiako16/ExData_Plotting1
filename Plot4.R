# EXPLORATORY DATA ANALYSIS PROJECT 1
#Code for Plot 4
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
consumptionDate <- filter(powerConsumption, grepl("^[1,2]/2/2007", Date))
#Could also use ConsumptionDate <- powerConsumption[powerConsumption$Date %in% c("1/2/2007","2/2/2007") ,]
globalActivePower <- as.numeric(consumptionDate$Global_active_power, na.rm = TRUE)

timeDate <- strptime(paste(consumptionDate$Date, consumptionDate$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# Converting varibles to numeric
globalReactivePower <- as.numeric(consumptionDate$Global_reactive_power, na.rm = TRUE)
voltage <- as.numeric(consumptionDate$Voltage)
subMetering1 <- as.numeric(consumptionDate$Sub_metering_1)
subMetering2 <- as.numeric(consumptionDate$Sub_metering_2)
subMetering3 <- as.numeric(consumptionDate$Sub_metering_3)

#Ploting figure as png
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
plot(timeDate, globalActivePower, type="l", xlab="", ylab="Global Active Power")
plot(timeDate, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(timeDate, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(timeDate, subMetering2, type="l", col="red")
lines(timeDate, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
plot(timeDate, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()