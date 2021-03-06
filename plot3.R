##This code constructs a plot showing the sub-meterings
##per minute between 02/01/2007 and 02/02/2007 
##for the house hold power consumption dataset. 
##Each sub-metering is indicated by its color in the plot.

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
png("plot3.png")
##Set background color to transparent
par(bg = NA)
#Create the base plot with sub-metering 1
plot(selected$Date, 
     selected$Sub_metering_1,
     type='l', #use lines for plotting
     xlab='', #remove the default label for x-axis
     ylab="Energy sub metering")
#Add the second submetering in red and the third in blue
lines(selected$Date, 
      selected$Sub_metering_2,
      col="red")
lines(selected$Date, 
      selected$Sub_metering_3,
      col="blue")
#Add a lengend showing the colors for each metering
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=1, 
       col=c("black","red","blue"))
#Close output file
dev.off()