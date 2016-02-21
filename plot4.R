require(sqldf) # Use sqldf package to filter subset at the very beginning

# Reading from source file with filtering
# Assuming household_power_consumption.txt in the current working directory
print("Reading data from file...")
hpc <- read.csv.sql("household_power_consumption.txt", sep = ";", colClasses = "character",
                     sql = "select * from file where date in ('1/2/2007', '2/2/2007')")
closeAllConnections() # Closing connections

# Data preparation (chars to integer for the selected columns as well as date)
print("Preparing data...")
ga <- as.numeric(hpc$Global_active_power) # Global Active Power var
sm1 <- as.numeric(hpc$Sub_metering_1) # Submetering 1 var
sm2 <- as.numeric(hpc$Sub_metering_2) # Submetering 2 var
sm3 <- as.numeric(hpc$Sub_metering_3) # Submetering 3 var
v <- as.numeric(hpc$Voltage) # Voltage
gr <- as.numeric(hpc$Global_reactive_power) # Global Reactive Power var
t <- strptime(paste(hpc$Date, hpc$Time), format = "%d/%m/%Y %H:%M:%S") # DateTime var

png(file = "plot4.png", width = 480, height = 480) # Open PNG file
par(mfcol = c(2, 2)) # Multi-column plotting switch on

# Construct Global Active Power
print("Building Global Active Power line...")
plot(t, ga, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Construct Submetering
print("Building Submetering lines...")
plot(t, sm1, type = "l", xlab = "", ylab = "Energy sub metering") # Initial with Submetering 1
points(t, sm2, type = "l", col = "red") # Adding Submetering 2
points(t, sm3, type = "l", col = "blue") # Adding Submetering 3
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), col = c("black", "red", "blue"),
       box.col = "transparent", inset = c(0.01, 0.01), cex = 0.7)

# Construct Voltage
print("Building Voltage line...")
plot(t, v, type = "l", xlab = "datetime", ylab = "Voltage")

# Construct Global Reactive Power
print("Building Global Reactive Power line...")
plot(t, gr, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off() # Close PNG file

print("Done")