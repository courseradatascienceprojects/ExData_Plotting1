# Ensure "household_power_consumption.txt" is in working directory root
# load data 
data.all = read.csv("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character", na.strings = "?")

#remove nas
data.completeCases = data.all[complete.cases(data.all),]

# set column "Date" as Date type
data.completeCases$Date = as.Date(data.completeCases$Date, format = "%d/%m/%Y")

# filter dataset to range  2007-02-01 - 2007-02-02 inclusive
data.filtered = data.completeCases[data.completeCases$Date >= "2007-02-01" & data.completeCases$Date < "2007-02-03",]

# set column "Global_active_power" as Numeric type
data.filtered$Global_active_power = as.numeric(data.filtered$Global_active_power)

# set column "Sub_metering_1" - 3 as Numeric type
data.filtered$Sub_metering_1 = as.numeric(data.filtered$Sub_metering_1)
data.filtered$Sub_metering_2 = as.numeric(data.filtered$Sub_metering_2)
data.filtered$Sub_metering_3 = as.numeric(data.filtered$Sub_metering_3)

# set column "Global_reactive_power" as Numeric type
data.filtered$Global_reactive_power = as.numeric(data.filtered$Global_reactive_power)

# set column "Voltage" as Numeric type
data.filtered$Voltage = as.numeric(data.filtered$Voltage)

# create "DateTime" as combination of date and time 
data.filtered$DateTime = as.POSIXct(paste(data.filtered$Date, data.filtered$Time), format = "%Y-%m-%d %H:%M:%S")



# set up png device driver with dimensions 480x480
png(file = "plot4.png", width = 480, height = 480)

# set up 4 plots 2x2
par(mfrow=c(2,2))

# globalactive power
plot(data.filtered$DateTime, data.filtered$Global_active_power, ylab = "Global Active Power", xlab = "", type = "l")

# voltage plot
plot(data.filtered$DateTime, data.filtered$Voltage, ylab = "Voltage", xlab = "datetime", type = "l", lwd=1)

# sub metering - same as plot 3 but playing spot-the-difference reveals a few differences with the legend (no border, text slightly smaller)
plot(data.filtered$DateTime, data.filtered$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l")
lines(data.filtered$DateTime, data.filtered$Sub_metering_2, type = "l", col = "Red")
lines(data.filtered$DateTime, data.filtered$Sub_metering_3, type = "l", col = "Blue")
legend("topright", cex= 0.9, text.font = 0.9, c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), bty = "n" )

# global_reactive_power
plot(data.filtered$DateTime, data.filtered$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l")

dev.off()