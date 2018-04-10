# load data - ensure "household_power_consumption.txt" is in working directory root
# only interested in cols 1 & 3 ("Date" and "Global_active_power")
data.all = read.csv("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character", na.strings = "?")[, 1:3]

#remove nas
data.completeCases = data.all[complete.cases(data.all),]

# set column "Date" as Date type
data.completeCases$Date = as.Date(data.completeCases$Date, format = "%d/%m/%Y")

# filter dataset to range  2007-02-01 - 2007-02-02 inclusive
data.filtered = data.completeCases[data.completeCases$Date >= "2007-02-01" & data.completeCases$Date < "2007-02-03",]

# set column "Global_active_power" as Numeric type
data.filtered$Global_active_power = as.numeric(data.filtered$Global_active_power)


# set up png device driver with dimensions 480x480
png(file = "plot1.png", width = 480, height = 480)
# create histogram using golbalreactivepower, set breaks to 20
hist(data.filtered$Global_active_power, breaks = 20, col = "Red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()