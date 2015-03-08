#!/usr/bin/env R CMD BATCH

library(data.table)

# read
data <- fread("./household_power_consumption.txt", na.strings = c("?"), colClasses = rep("character",9))

# subset
data[,Date:=as.Date(Date, format="%d/%m/%Y")]
data <- data[Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02")]

# prepare
data[,Global_active_power:=as.numeric(Global_active_power)]

# device
filename <- "plot1.png"
png(filename, 480, 480, units="px")

# plot
hist(data[,Global_active_power], 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     col="red")

dev.off()
