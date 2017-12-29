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
png(file = "plot1.png", width = 480, height = 480)
hist(consumption$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
