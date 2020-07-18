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
png(filename = "plot1.png",width = 480,height = 480)
#Graph histogram as requested
hist(minipower$Global_active_power,col = "red",
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
#Close png device and saves png file.
dev.off()
