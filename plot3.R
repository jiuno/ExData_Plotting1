#Required packages
library(lubridate)
library(dplyr)
#"House_power_consumption.txt" must already be in your working directory.
#Reading the whole txt
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
png("plot3.png", width = 480, height = 480)
#Graph plot as requested
plot(x = minipower$`Date/Time`,
     y = minipower$Sub_metering_1,
     type = "l",
     col = "black",
     ylab = "Energy sub metering",
     xlab = "")
#Plotted more variables on top of the graph.
#Sub metering 2
lines(x = minipower[,10], y = minipower[,8],
	type = "l",
	col = "red")
#Sub metering 3
lines(x = minipower[,10], y = minipower[,9],
	type = "l",
	col = "blue")
#Add legend
legend("topright",
	 legend = c(names(minipower[,7:9])),
	 lty = 1,col = c("black","red","blue"))
#Close png device and save png file.
dev.off()
