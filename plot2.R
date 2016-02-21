require(sqldf) # Use sqldf package to filter subset at the very beginning

# Reading from source file with filtering
# Assuming household_power_consumption.txt in the current working directory
print("Reading data from file...")
hpc <- read.csv.sql("household_power_consumption.txt", sep = ";", colClasses = "character",
                     sql = "select * from file where date in ('1/2/2007', '2/2/2007')")
closeAllConnections() # Closing connections

# Data preparation (chars to integer for the selected column as well as date)
print("Preparing data...")
ga <- as.numeric(hpc$Global_active_power) # Global Active Power var
t <- strptime(paste(hpc$Date, hpc$Time), format = "%d/%m/%Y %H:%M:%S") # DateTime var

# Construct the line
print("Building line...")
png(file = "plot2.png", width = 480, height = 480) # Open PNG file
plot(t, ga, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

print("Done")