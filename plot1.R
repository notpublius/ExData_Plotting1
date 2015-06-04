## R script to generate plot 1 of the assignment.

## Read the data from the text file.
# Use data.table and do not coerce types for increased performance
library(data.table)
dat <- fread('household_power_consumption.txt', sep=";", na.strings = '?', colClasses = "character")
setkey(dat,Date)
# Subset and convert to a data.frame
d <- data.frame(dat[Date=='1/2/2007' | Date=='2/2/2007'])
rm(dat)
# Coerse types for our specific plot now
d$Global_active_power = as.numeric(d$Global_active_power)

## Generate the plot as specified
# Open the PNG device
png("plot1.png", width = 480, height = 480)
# Generate the plot
hist(d$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col='red')
# Close the device
dev.off()