dir.create ('tmp')
temp <- tempfile ()
download.file ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
unzip (temp, list=TRUE)

tbl <-fread(unzip (temp,'household_power_consumption.txt'), header=T, stringsAsFactors = F, na.strings="?")
tbl [,timestamp := paste (Date, Time)]
tbl [,timestamp :=as.POSIXct (timestamp, format = "%d/%m/%Y %H:%M:%S", origin="1970-1-1", tz="UTC")]
unlink (temp)

tbl1 <- tbl [timestamp >= as.POSIXct ("2007-02-01", format = "%Y-%m-%d", origin="1970-1-1", tz="UTC") & timestamp <= as.POSIXct ("2007-02-02", format = "%Y-%m-%d", origin="1970-1-1", tz="UTC"),]

# 
tbl1 [,Datetime := timestamp]
tbl1 [,weekday := wday (timestamp)]

data <- copy (tbl1)
data <- as.data.frame (data)
png ('plot4.png', height = 480, width = 480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
    plot(Global_active_power~Datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~Datetime, type="l", 
         ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~Datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~Datetime, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.off ()

