if (!file.exists('..\\HPC\\hpc.txt')){
	download.file(url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', destfile='..\\hpc.zip', method='curl')
	unzip('..\\hpc.zip', exdir="..\\HPC\\hpc.txt")
}

power_consumption <- read.csv("..\\HPC\\hpc.txt", stringsAsFactors=FALSE, sep=";")
power_consumption <- power_consumption[power_consumption$Date == "1/2/2007" | power_consumption$Date == "2/2/2007", ]

power_consumption$Global_active_power <- as.numeric(power_consumption$Global_active_power)

png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(power_consumption$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
dev.off()


 