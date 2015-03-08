#!/usr/bin/env R

library(data.table)

# read
data <- fread("./household_power_consumption.txt", na.strings = c("?"), colClasses = rep("character",9))

# subset
data[,Date:=as.Date(Date, format="%d/%m/%Y")]
data <- data[Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02")]

# prepare
data[,Sub_metering_3:=as.numeric(Sub_metering_3)]
data[,datetime:=data.frame(strptime( paste( Date, Time ), format="%Y-%m-%d %H:%M:%S" ))]

# plot
plot(data$datetime, data$Sub_metering_3, type="l")
