temp <- tempfile ()
download.file ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
unzip (temp, list=TRUE)

tbl <-fread(unzip (temp,'household_power_consumption.txt'), header=T, stringsAsFactors = F, na.strings="?")
tbl [,timestamp := paste (Date, Time)]
tbl [,timestamp :=as.POSIXct (timestamp, format = "%d/%m/%Y %H:%M:%S", origin="1970-1-1", tz="UTC")]
unlink (temp)

tbl1 <- tbl [timestamp >= as.POSIXct ("2007-02-01", format = "%Y-%m-%d", origin="1970-1-1", tz="UTC") & timestamp <= as.POSIXct ("2007-02-02", format = "%Y-%m-%d", origin="1970-1-1", tz="UTC"),]

# 
png ('plot1.png', height = 480, width = 480)
hist (tbl1$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col="red", border= "black")
dev.off ()


