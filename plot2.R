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
png(file="plot2.png",width=480,height=480)

#generate plot
plot(sub_data$datetime, sub_data$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")

#turn off graphics device
dev.off()
