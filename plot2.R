##This code constructs a plot showing the global active power 
##per minute between 02/01/2007 and 02/02/2007 
##for the house hold power consumption dataset.

##Read data
data <- read.csv("household_power_consumption.txt",
                 sep=";", na.strings = "?", stringsAsFactors=F)
##Convert dates to date fields using lubridate
library(lubridate)
data[,1] <- data[,1] <- dmy(data[,1])
##Filter data based on start and end dates (exlcuding times).
##Use UTC as timezone to match lutbridate default as the actual
##timezone in which the data was gathered is unknown.
start_date <- as.POSIXct("2007-02-01", tz="UTC")
end_date <- as.POSIXct("2007-02-02", tz="UTC")
selected <- data[data[,1]>=start_date & data[,1]<=end_date,]
##Add time information from the second column to 
##the dates in to the Date field. 
##This is done after filtering based on dates without times
##to reduce the run time since this conversion,
##which requires using paste is much slower calling dmy.
selected[,1] <- fast_strptime(
    paste(selected[,1],selected[,2]),
    "%Y-%m-%d %H:%M:%S")
#Open output file
png("plot2.png")
##Set background color to transparent
par(bg = NA)
#Create the plot
plot(selected$Date, 
     selected$Global_active_power,
     type='l', #use lines for plotting
     xlab='', #remove the default label for x-axis
     ylab="Global Active Power (kilowatts)")
#Close output file
dev.off()