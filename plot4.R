#!/usr/bin/env R CMD BATCH

library(data.table)

# read
data <- fread("./household_power_consumption.txt", na.strings = c("?"), colClasses = rep("character",9))

# subset
data[,Date:=as.Date(Date, format="%d/%m/%Y")]
data <- data[Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02")]

# prepare
data[,Global_active_power:=as.numeric(Global_active_power)]
data[,Global_reactive_power:=as.numeric(Global_reactive_power)]
data[,Voltage:=as.numeric(Voltage)]
data[,Sub_metering_1:=as.numeric(Sub_metering_1)]
data[,Sub_metering_2:=as.numeric(Sub_metering_2)]
data[,Sub_metering_3:=as.numeric(Sub_metering_3)]
data[,datetime:=data.frame(strptime( paste( Date, Time ), format="%Y-%m-%d %H:%M:%S" ))]

par(mfrow = c(2,2))

# plot1
plot(data$datetime, data$Global_active_power, 
     type="l", xlab="", ylab="Global Active Power (kilowatts)")

# plot2
plot(data$datetime, data$Voltage, 
     type="l", xlab="datetime", ylab="Voltage")

# plot3
plot(data$datetime, data$Sub_metering_1, 
     type="l", xlab="", ylab="Energy sub metering")
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")

legend("topright", pch="-", 
       col=c("black","red","blue"),
       bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot4
plot(data$datetime, data$Global_reactive_power,
     type="l", xlab="datetime", ylab="Global_reactive_power")
