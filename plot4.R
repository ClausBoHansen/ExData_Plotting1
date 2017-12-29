# Exploratory Data Analysis assignment
# Claus Bo Hansen

# Settings
downloadlink <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
localarchive <- "powerconsumption.zip"
datafile     <- "household_power_consumption.txt"

# Download and unzip data
download.file(downloadlink, localarchive)
unzip(localarchive)

# Load data
consumption <- read.table(datafile, sep = ";", header = TRUE, colClasses = c(rep("character",2), rep("numeric",7)), na.strings = c("?"))

# Subset to only 2007-02-01 and 2007-02-02
consumption <- consumption[which(grepl("^(1|2)/2/2007$", consumption$Date)),]

# Combine Data and Time, then convert POSIXct
consumption$timestamp <- as.POSIXct(paste(consumption$Date,consumption$Time), format = "%e/%m/%Y %H:%M:%S")

# Create plot
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

# First plot
with(consumption, plot(timestamp, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l"))

# Second plot
with(consumption, plot(timestamp, Voltage, xlab = "datetime", ylab = "Voltage", type = "l"))

# Third plot
with(consumption, plot(timestamp, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l"))
with(consumption, lines(timestamp, Sub_metering_2, type = "l", col = "red"))
with(consumption, lines(timestamp, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), pch = NA, lwd = 1, bty = "n")

# Fourth plot
with(consumption, plot(timestamp, Global_reactive_power, xlab = "datetime",  type = "l"))

dev.off()
