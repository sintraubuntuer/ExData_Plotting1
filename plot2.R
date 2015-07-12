
tablePower <- read.table("household_power_consumption.txt", header = TRUE,sep=';')

# concatenates the date and time column and uses the strptime fuction to 'produce' a POSIXlt Time object
# and uses as.Date to convert it to an object of class Date 
tablePower$Time <- paste(tablePower[,1],tablePower[,2], sep=" ")
tablePower$Time <- strptime(tablePower$Time , "%d/%m/%Y %H:%M:%S")
tablePower$Time <- as.POSIXlt(tablePower$Time,tz="UTC")
tablePower$Date <- as.Date(tablePower$Time)

#create new dataframe with rows corresponding to dates '2007-02-01' and '2007-02-02'
subTablePower <- subset(tablePower ,tablePower[,1]==as.Date('2007-02-01') | tablePower[,1]==as.Date('2007-02-02') )

#convert all columns except for the Date and Time columns to numeric format
cols=3:ncol(subTablePower)    
subTablePower[,cols] = apply(subTablePower[,cols], 2, function(x) as.numeric(as.character(x)))

#plot the line graph to a png file
png(file="plot2.png")
plot(subTablePower$Time,subTablePower$Global_active_power , main="", xlab="" , ylab="Global Active Power (kilowatts)" , type="l")
dev.off()


