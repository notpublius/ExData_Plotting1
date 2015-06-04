## R script to generate plot 3 of the assignment.

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
for (col in c('Sub_metering_1','Sub_metering_3','Sub_metering_3')) {
  d[[col]] <- as.numeric(d[[col]])
}

## Generate the plot as specified
# Open the PNG device
png("plot3.png", width = 480, height = 480)
# Generate the plot
plot(d$Datetime, d$Sub_metering_1, type='l', col = 'black', ylab = 'Energy sub metering', xlab='')
points(d$Datetime, d$Sub_metering_2, type='l', col = 'red')
points(d$Datetime, d$Sub_metering_3, type='l', col = 'blue')
legend('topright', col=c('black','red','blue'), 
       legend=c('Sub_metering_1','Sub_metering_3','Sub_metering_3'),
       lty = 1)
# Close the device
dev.off()