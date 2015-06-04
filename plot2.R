## R script to generate plot 2 of the assignment.

## Read the data from the text file.
# Use data.table and do not coerce types for increased performance
library(data.table)
dat <- fread('household_power_consumption.txt', sep=";", na.strings = '?', colClasses = "character")
setkey(dat,Date)
# Subset and convert to a data.frame
d <- data.frame(dat[Date=='1/2/2007' | Date=='2/2/2007'])
rm(dat)
# Coerse types for our specific plot now
d$Datetime = strptime(with(d,paste(Date,Time)), format="%d/%m/%Y %T")
d$Global_active_power = as.numeric(d$Global_active_power)

## Generate the plot as specified
# Open the PNG device
png("plot2.png", width = 480, height = 480)
# Generate the plot
plot(d$Datetime, d$Global_active_power, type='l', xlab = "", ylab = "Global Active Power (kilowatts)")
# Close the device
dev.off()