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
png ('plot3.png', height = 480, width = 480)
with(tbl1, {
    plot(Sub_metering_1~Datetime, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.off ()

