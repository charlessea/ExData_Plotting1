if (!file.exists('..\\HPC\\hpc.txt')){
	download.file(url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', destfile='..\\hpc.zip', method='curl')
	unzip('..\\hpc.zip', exdir="..\\HPC\\hpc.txt")
}

power_consumption <- read.csv("..\\HPC\\hpc.txt", stringsAsFactors=FALSE, sep=";")
power_consumption <- power_consumption[power_consumption$Date == "1/2/2007" | power_consumption$Date == "2/2/2007", ]

power_consumption$Global_active_power <- as.numeric(power_consumption$Global_active_power)

dates <- power_consumption$Date
times <- power_consumption$Time
dates_times <- paste(dates, times)
dates_times <- strptime(dates_times, "%d/%m/%Y %H:%M:%S")
power_consumption <- cbind(power_consumption, dates_times)

png(filename = "plot2.png", width = 480, height = 480, units = "px")
with(power_consumption, plot(dates_times, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()


 