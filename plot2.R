
# in Shell: git clone https://github.com/Greg1717/ExData_Plotting1.git

# git remote add origin https://github.com/Greg1717/ExData_Plotting1.git

# url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# dir.create("data")

# download ZIP file
# download.file(url = url,
#               destfile = "./data/power_consumption.zip")

# unzip(zipfile = "./data/power_consumption.zip",
#       exdir = "./data")

# load package =================================================================
library(data.table)

# import data ==================================================================
dt <- data.table::fread(file = "./data/household_power_consumption.txt",
                        header = TRUE,
                        dec = ".",
                        na.strings = c("?"),
                        colClasses = list(
                            character = c("Date", "Time"),
                            numeric = c("Global_active_power",
                                        "Global_reactive_power",
                                        "Voltage",
                                        "Global_intensity",
                                        "Sub_metering_1",
                                        "Sub_metering_2",
                                        "Sub_metering_3")
                        ),
                        data.table = TRUE)

# character to Date ============================================================
# dt[, Date := as.Date(Date, format = "%d/%m/%Y")]
# dt[, Time := strptime(Time, format = "%H:%M:%S")]
dt[, date_time := as.POSIXct(paste(dt$Date, dt$Time),
                             format = "%d/%m/%Y %H:%M:%S",
                             tz = "GMT")]

# filter on days ===============================================================
dt <- dt[as.Date(date_time) == "2007-02-01" |
             as.Date(date_time) == "2007-02-02"]


# plot 2 =======================================================================
png(filename = "plot2.png")

plot(x = dt$date_time,
     y = dt$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.off()
