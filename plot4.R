## R script to generate plot 4 of the assignment.

## Read the data from the text file.
# Use data.table and do not coerce types for increased performance
library(data.table)
dat <- fread('household_power_consumption.txt', sep=";", na.strings = '?', colClasses = "character")
setkey(dat,Date)
# Subset and convert to a data.frame
d <- data.frame(dat[Date=='1/2/2007' | Date=='2/2/2007'])
rm(dat)
# Coerse types for our specific plot now
d$Datetime <- strptime(with(d,paste(Date,Time)), format="%d/%m/%Y %T")
d$Global_active_power <- as.numeric(d$Global_active_power)
d$Global_reactive_power <- as.numeric(d$Global_reactive_power)
d$Voltager <- as.numeric(d$Voltage)
sub_meter <- c('Sub_metering_1','Sub_metering_2','Sub_metering_3')
for (col in sub_meter) {
  d[[col]] <- as.numeric(d[[col]])
}

## Generate the plot as specified
# Open the PNG device
png("plot4.png", width = 480, height = 480)
par( mfrow=c(2,2))
# Generate the 1st plot
plot(d$Datetime, d$Global_active_power, type='l', xlab = "", ylab = "Global Active Power")
# Generate the 2nd plot
with(d,plot(Datetime, Voltage, type='l'))
# Generate the 3rd plot
plot(d$Datetime, d$Sub_metering_1, type='n', col = 'black', ylab = 'Energy sub metering', xlab='')
pltcol = c('black', 'red', 'blue')
for (i in 1:3) {
  points(d$Datetime, d[[sub_meter[i]]], type='l', col = pltcol[i])
}
legend('topright', col=pltcol, legend=sub_meter, lty = 1, bty = "n")
# Generate the 4th plot of the panel
with(d,plot(Datetime, Global_reactive_power, type='l'))
# Close the device
dev.off()