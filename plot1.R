
##read data as characters

char_data <- read.csv2("household_power_consumption.txt", stringsAsFactors = F)

##put character data in a matrix. we're coercing out some NAs but suppress the 
##warnings because we won't use those columns in the final data
suppressWarnings(num_data <- data.frame(data.matrix(char_data)))


##Find the columns of numeric data
numeric_columns <- sapply(num_data,function(x){mean(as.numeric(is.na(x)))<0.5})

##make a data frame that has numerical data and character data as appropriate 
final_data <- data.frame(num_data[,numeric_columns], char_data[,!numeric_columns])

##subset out the right days
smallData<-subset(final_data, Date=="1/2/2007" | Date=="2/2/2007")

##change Date to date class
smallData$DateTime<-strptime(paste(as.Date(smallData$Date, format="%d/%m/%Y"), smallData$Time), format="%Y-%m-%d %H:%M:%S")

##Launch png graphics device, call hist, close the graphics device
png(file = "plot1.png", width = 480, height = 480)
hist(smallData$Global_active_power, col="red", main= "Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

