#substract table with the selected period

table <- read.table("household_power_consumption.txt",header = TRUE, sep = ";", na.strings = "?") #read original table with assigning NA value to "?"
datetime <- paste(table[,1], table[,2], sep = " ", collapse = NULL) #create charater datetime contains data and time
datetime01 <- strptime(datetime, "%d/%m/%Y %H:%M:%S") #convert datetime to class Dates in correct format
table$Date_time <- datetime01 #add column datetime in right class/format to original table
first_day <- strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S") # set boundaries for time series (first and last day)
last_day <- strptime("2007-02-03 00:00:00", "%Y-%m-%d %H:%M:%S")
mydata <-subset(table, Date_time >= first_day & Date_time < last_day) #final table is subtracted by the selected period

#######plot
png("plot3.png", width = 480, height = 480) # set up print deveice PNG with resolution 480x480 pixels

# Create a data frame which consits all three sub metering values with lable assigned for each sub_metering data
# inwhich 2880 is number of value for each type of sub_metering (repeats 3 times)
metering_123 <- data.frame(type = gl(3,2880, labels = c("meter1", "meter2", "meter3")), meter_data = c(mydata[,7], mydata[,8], mydata[,9])) 

# Similar to previous step, but for time series instead
time_123 <- data.frame(period = gl(3,2880, labels =c("p1","p2","p3")), time = c(mydata[,10], mydata[,10], mydata[,10]))

#plot sub_metering_1 vs time and add other meters as lines
plot(time_123$time[time_123$period == "p1"], metering_123$meter_data[metering_123$type == "meter1"], type ="l", xlab ="", ylab ="Energy sub metering", col ="black")
lines(time_123$time[time_123$period == "p2"], metering_123$meter_data[metering_123$type == "meter2"], col = "red")
lines(time_123$time[time_123$period == "p3"], metering_123$meter_data[metering_123$type == "meter3"], col = "blue")
legend("topright",lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off() #turn-off print device
