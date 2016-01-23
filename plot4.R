#substract table with the selected period

table <- read.table("household_power_consumption.txt",header = TRUE, sep = ";", na.strings = "?") #read original table with assigning NA value to "?"
datetime <- paste(table[,1], table[,2], sep = " ", collapse = NULL) #create charater datetime contains data and time
datetime01 <- strptime(datetime, "%d/%m/%Y %H:%M:%S") #convert datetime to class Dates in correct format
table$Date_time <- datetime01 #add column datetime in right class/format to original table
first_day <- strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S") # set boundaries for time series (first and last day)
last_day <- strptime("2007-02-03 00:00:00", "%Y-%m-%d %H:%M:%S")
mydata <-subset(table, Date_time >= first_day & Date_time < last_day) #final table is subtracted by the selected period

####plot
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))  # multiple plots in 2 rows and 2 columns, order in row-wise
#plot 1st graph - top left
with(mydata, plot(Date_time,Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
#plot 2nd graph - top right
with(mydata, plot(Date_time,Voltage, type = "l", xlab = "datatime", ylab = "Voltage"))
#plot 3rd graph - bottom left
metering_123 <- data.frame(type = gl(3,2880, labels = c("meter1", "meter2", "meter3")), meter_data = c(mydata[,7], mydata[,8], mydata[,9])) 
time_123 <- data.frame(period = gl(3,2880, labels =c("p1","p2","p3")), time = c(mydata[,10], mydata[,10], mydata[,10]))
plot(time_123$time[time_123$period == "p1"], metering_123$meter_data[metering_123$type == "meter1"], type ="l", xlab ="", ylab ="Energy sub metering", col ="black")
lines(time_123$time[time_123$period == "p2"], metering_123$meter_data[metering_123$type == "meter2"], col = "red")
lines(time_123$time[time_123$period == "p3"], metering_123$meter_data[metering_123$type == "meter3"], col = "blue")
legend("topright",lty = c(1,1,1),bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#plot 4th graph - bottom right
with(mydata, plot(Date_time,Global_reactive_power, type = "l", xlab = "datetime"))

dev.off()
