#!/usr/bin/env R CMD BATCH

library(data.table)

# read
data <- fread("./household_power_consumption.txt", na.strings = c("?"), colClasses = rep("character",9))

# subset
data[,Date:=as.Date(Date, format="%d/%m/%Y")]
data <- data[Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02")]

# prepare
data[,Sub_metering_1:=as.numeric(Sub_metering_1)]
data[,Sub_metering_2:=as.numeric(Sub_metering_2)]
data[,Sub_metering_3:=as.numeric(Sub_metering_3)]
data[,datetime:=data.frame(strptime( paste( Date, Time ), format="%Y-%m-%d %H:%M:%S" ))]

# plot
plot(data$datetime, data$Sub_metering_1, 
     type="l", xlab="", ylab="Energy sub metering")
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")

legend("topright", pch="-", 
       col=c("black","red","blue"),
       pt.cex=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
