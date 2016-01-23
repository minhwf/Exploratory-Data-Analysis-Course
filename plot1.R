#substract table with the selected period

table <- read.table("household_power_consumption.txt",header = TRUE, sep = ";", na.strings = "?") #read original table with assigning NA value to "?"
datetime <- paste(table[,1], table[,2], sep = " ", collapse = NULL) #create charater datetime contains data and time
datetime01 <- strptime(datetime, "%d/%m/%Y %H:%M:%S") #convert datetime to class Dates in correct format
table$Date_time <- datetime01 #add column datetime in right class/format to original table
first_day <- strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S") # set boundaries for time series (first and last day)
last_day <- strptime("2007-02-03 00:00:00", "%Y-%m-%d %H:%M:%S")
mydata <-subset(table, Date_time >= first_day & Date_time < last_day) #final table is subtracted by the selected period

#plot
png("plot1.png", width = 480, height = 480) # set up print deveice PNG with resolution 480x480 pixels

with(mydata, hist(Global_active_power, main = "Global Active Power", col = "red", xlab ="Global Active Power (kilowatts)"))

dev.off() #tunr-off print device
