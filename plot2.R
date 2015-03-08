#!/usr/bin/env R CMD BATCH

library(data.table)

# read
data <- fread("./household_power_consumption.txt", na.strings = c("?"), colClasses = rep("character",9))

# subset
data[,Date:=as.Date(Date, format="%d/%m/%Y")]
data <- data[Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02")]

# prepare
data[,Global_active_power:=as.numeric(Global_active_power)]
data[,datetime:=data.frame(strptime( paste( Date, Time ), format="%Y-%m-%d %H:%M:%S" ))]

# plot
plot(data$datetime, data$Global_active_power, 
     type="l", xlab="", ylab="Global Active Power (kilowatts)")
