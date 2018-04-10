# load data - ensure "household_power_consumption.txt" is in working directory root
# only interested in cols 1, 2, 3 ("Date", "Time" and "Global_active_power")
data.all = read.csv("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character", na.strings = "?")[, 1:3]

#remove nas
data.completeCases = data.all[complete.cases(data.all),]

# set column "Date" as Date type
data.completeCases$Date = as.Date(data.completeCases$Date, format = "%d/%m/%Y")

# filter dataset to range  2007-02-01 - 2007-02-02 inclusive
data.filtered = data.completeCases[data.completeCases$Date >= "2007-02-01" & data.completeCases$Date < "2007-02-03",]

# set column "Global_active_power" as Numeric type
data.filtered$Global_active_power = as.numeric(data.filtered$Global_active_power)

# create "DateTime" as combination of date and time 
data.filtered$DateTime = as.POSIXct(paste(data.filtered$Date, data.filtered$Time), format = "%Y-%m-%d %H:%M:%S")

# set up png device driver with dimensions 480x480
png(file = "plot2.png", width = 480, height = 480)

# create line chart using datetime and golbalreactivepower 
plot(data.filtered$DateTime, data.filtered$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")

dev.off()