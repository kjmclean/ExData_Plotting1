setwd("ExData_Plotting1/")

#Read in full dataset
full_dataset <- read.table("household_power_consumption.txt", header = TRUE, 
                           sep = ";", na.strings = "?")

#change format of Date column to facilitate subsetting
full_dataset[,1] <- as.character(full_dataset[,1])
full_dataset[,1] <- as.Date(full_dataset[,1], format = "%d/%m/%Y")

#Subset dataset to only 2007-02-01 and 2007-02-02 dates
sub_data <- subset(full_dataset, 
                   full_dataset[,1] == "2007-02-01" | full_dataset[,1] == "2007-02-02")

#Combine Date and Time column to make a new column, "datetime"
sub_data$datetime <- paste(sub_data$Date, sub_data$Time)
sub_data$datetime <- strptime(sub_data$datetime, format = "%Y-%m-%d %H:%M:%S")

#Initiate png device with 480x480 format
png(file="plot4.png",width=480,height=480)

#generate plot
par(mfrow = c(2,2), mar = c(5.1, 4.1, 3.1, 2.1), cex = 0.85)

topLeft <- plot(sub_data$datetime, sub_data$Global_active_power, type = "l", 
                ylab = "Global Active Power", xlab = "")

topRight <- plot(sub_data$datetime, sub_data$Voltage, type = "l", 
                 xlab = "datetime", ylab = "Voltage")

bottomLeft <- plot(sub_data$datetime, sub_data$Sub_metering_1, type = "l", col = 1, 
                   ylab = "Energy sub metering", xlab = "")
lines(sub_data$datetime, sub_data$Sub_metering_2, type = "l", col = 2)
lines(sub_data$datetime, sub_data$Sub_metering_3, type = "l", col = 4)
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c(1, 2, 4), bty = "n", pt.cex=1,cex= 0.99)

bottomRight <- plot(sub_data$datetime, sub_data$Global_reactive_power, type = "l", 
                    xlab = "datetime", ylab = "Global_reactive_power")

#turn off graphics device
dev.off()
