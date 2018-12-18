if (!file.exists('..\\HPC\\hpc.txt')){
	download.file(url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', destfile='..\\hpc.zip', method='curl')
	unzip('..\\hpc.zip', exdir="..\\HPC\\hpc.txt")
}

power_consumption <- read.csv("..\\HPC\\hpc.txt", stringsAsFactors=FALSE, sep=";")
power_consumption <- power_consumption[power_consumption$Date == "1/2/2007" | power_consumption$Date == "2/2/2007", ]

power_consumption$Global_active_power <- as.numeric(power_consumption$Global_active_power)
power_consumption$Global_reactive_power <- as.numeric(power_consumption$Global_reactive_power)
power_consumption$Voltage <- as.numeric(power_consumption$Voltage)
power_consumption$Global_intensity <- as.numeric(power_consumption$Global_intensity)
power_consumption$Sub_metering_1 <- as.numeric(power_consumption$Sub_metering_1)
power_consumption$Sub_metering_2 <- as.numeric(power_consumption$Sub_metering_2)
power_consumption$Sub_metering_3 <- as.numeric(power_consumption$Sub_metering_3)

dates <- power_consumption$Date
times <- power_consumption$Time
dates_times <- paste(dates, times)
dates_times <- strptime(dates_times, "%d/%m/%Y %H:%M:%S")
power_consumption <- cbind(power_consumption, dates_times)

png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2), mar=c(4,4,2,2))
plot(power_consumption$dates_times, power_consumption$Global_active_power, type="l", pch="-", lty=1, xlab="", ylab="Global active power")
plot(power_consumption$dates_times, power_consumption$Voltage, type="l", pch="-", lty=1, xlab="datetime", ylab="Voltage")
plot(power_consumption$dates_times, power_consumption$Sub_metering_1, type="l", pch="-", lty=1, xlab="", ylab="Energy sub metering", col="black")
lines(power_consumption$dates_times, power_consumption$Sub_metering_2, type="l", pch="-", lty=1, col="red")
lines(power_consumption$dates_times, power_consumption$Sub_metering_3, type="l", pch="-", lty=1, col="blue")
legend("topright", pch="-", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(power_consumption$dates_times, power_consumption$Global_reactive_power, type="l", pch="-", lty=1, xlab="datetime", ylab="Global reactive power")
dev.off()


 