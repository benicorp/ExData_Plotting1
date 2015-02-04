##This code constructs a histrogram showing how often a particular
##value of global active power occurs between 02/01/2007 and 
##02/02/2007 in the house hold power consumption dataset.

##Read data
data <- read.csv("household_power_consumption.txt",
                 sep=";", na.strings = "?", stringsAsFactors=F)
##Convert dates to date fields using lubridate
library(lubridate)
data[,1] <- dmy(data[,1])
##Filter data based on start and end dates
##Use UTC as timezone to match lutbridate default as the actual
##timezone in which the data was gathered is unknown.
start_date <- as.POSIXct("2007-02-01", tz="UTC")
end_date <- as.POSIXct("2007-02-02", tz="UTC")
selected <- data[data[,1]>=start_date & data[,1]<=end_date,]
#Open output file
png("plot1.png")
##Set background color to transparent
par(bg = NA)
hist(selected$Global_active_power,
     #Set bar color
     col="red", 
     #Set labels
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
#Close output file
dev.off()