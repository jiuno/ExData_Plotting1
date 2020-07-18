#Required packages
library(lubridate)
library(dplyr)
power <- read.csv(file = "household_power_consumption.txt",header = T,sep = ";"
			,na.strings = "?")
#Change your timezone in R so the Date values are written in english.
Sys.setlocale("LC_TIME","english")
#Convert "Date" column into Date variable type.
power[,1] <-  dmy(power$Date)
#Filter rows between 2007/02/01 and 2007/02/02 (included)
minipower <- power %>% filter(Date == "2007-02-01" | Date == "2007-02-02" )
#Convert "Time" variables into "period" type variable from lubridate
minipower[,2] <- hms(minipower$Time)
#Create "Date/Time" Column. Adds Days and time from Date and Time variables.
minipower <- mutate(minipower,"Date/Time" = Date + Time)
#Open png device
png("plot4.png",width = 480,height = 480)
#Set global parameter "mfcol" so 4 plots can be plotted on the same graph.
par(mfcol = c(2,2))
#Global active power
plot(y = minipower$Global_active_power,x = minipower$`Date/Time`,
     type = "l",
     ylab = "Global Active Power",
     xlab = "")
#Energy sub metering
plot(x = minipower$`Date/Time`,
     y = minipower$Sub_metering_1,
     type = "l",
     col = "black",
     ylab = "Energy sub metering",
     xlab = "")
lines(x = minipower[,10], y = minipower[,8],
	type = "l",
	col = "red")
lines(x = minipower[,10], y = minipower[,9],
	type = "l",
	col = "blue")
legend("topright",
	 legend = c(names(minipower[,7:9])),
	 lty = 1,col = c("black","red","blue"))
#Voltage
plot(x = minipower$`Date/Time`,
     y = minipower$Voltage,
     type = "l",
     col = "black",
     ylab = "Voltage",
     xlab = "datetime")
#Global reactive power
plot(x = minipower$`Date/Time`,
     y = minipower$Global_reactive_power,
     type = "l",
     col = "black",
     ylab = "Global_reactive_power",
     xlab = "datetime")
#Close png device and save png file
dev.off()