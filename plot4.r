## load ibararies needed
library(data.table)
## 
##  download and unziped
##


#datadir<-"data"
if(!file.exists("data")) 
{ 
  dir.create("data")
} 
## download File and Unzip in Dir data
if(!file.exists("./data/powerSet.csv"))
{
desfile="./data/household_power_consumption.txt"
if(!file.exists(desfile))
{
  
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","data/Power.zip",mode="wb")  
  unzip("./data/power.zip",overwrite = TRUE, exdir = "data")
}

## load data
power<-read.table("data/household_power_consumption.txt",header =TRUE ,sep = ";",na.strings="?",stringsAsFactors=FALSE)
## clean data
power <-power[complete.cases(power),]
## set Datetime column
power$Datetime <-as.POSIXct(strptime(paste(power$Date,power$Time), format ="%d/%m/%Y %H:%M:%S"))
##get only what we need 2/1/2007 and 2/2/2007
powerSet<-subset(power,Datetime >= "2007-02-01 00:00:00" & Datetime < "2007-02-03 00:00:00")
write.csv(powerSet,"./data/powerSet.csv")
} else {
  
  powerSet<-read.table("data/powerSet.csv",header =TRUE ,sep = ",")
  powerSet$Datetime <-as.POSIXct(strptime(paste(powerSet$Date,powerSet$Time), format ="%d/%m/%Y %H:%M:%S"))
}
##open png device
png(filename = "plot4.png")
par(mfcol =c(2,2))
## create Graph
plot(powerSet$Datetime,powerSet$Global_active_power,type ="l",ylab="Global Active Power" ,xlab="")
plot(powerSet$Datetime,powerSet$Sub_metering_1,type ="l",ylab="Energy Sub Metering" ,xlab="")
lines(powerSet$Datetime,powerSet$Sub_metering_2,col="red")
lines(powerSet$Datetime,powerSet$Sub_metering_3,col="blue")
legend("topright",lwd=c(2.5,2.5,2.5), col =c("black","red","blue"),legend  = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
plot(powerSet$Datetime,powerSet$Voltage,type ="l",ylab="Voltage" ,xlab="datetime")
plot(powerSet$Datetime,powerSet$Global_reactive_power,type ="l",ylab="Global_reactive_power" ,xlab="datetime")
##Turn off
dev.off()


