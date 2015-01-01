tv_data <- read.table(system.file("doc", "extdata", "tv.dat", package = "vcdExtra"))
str(tv_data)
head(tv_data, 5)

TV_df <- tv_data
colnames(TV_df) <- c("Day", "Time", "Network", "State", "Freq")
TV_df <- within(TV_df, {Day <- factor(Day,
                                      labels = c("Mon", "Tue", "Wed", "Thu", "Fri"))
                        Time <- factor(Time)
                        Network <- factor(Network)
                        State <- factor(State)})

TV <- array(tv_data[,5], dim = c(5, 11, 5, 3))
dimnames(TV) <- 
    list(c("Mon", "Tue", "Wed", "Thu", "Fri"),
         c("8:00", "8:15", "8:30", "8:45", "9:00", "9:15", "9:30",
           "9:45", "10:00", "10:15", "10:30"),
         c("ABC", "CBS", "NBC", "Fox", "Other"),
         c("Off", "Switch", "Persist"))
names(dimnames(TV)) <- c("Day", "Time", "Network", "State")

TV <- xtabs(V5 ~ ., data = tv_data)
dimnames(TV) <- 
    list(Day = c("Mon", "Tue", "Wed", "Thu", "Fri"),
         Time = c("8:00", "8:15", "8:30", "8:45", "9:00", "9:15", "9:30",
                  "9:45", "10:00", "10:15", "10:30"),
         Network = c("ABC", "CBS", "NBC", "Fox", "Other"),
         State = c("Off", "Switch", "Persist"))

TV <- TV[,,1:3,]     # keep only ABC, CBS, NBC
TV <- TV[,,,3]       # keep only Persist -- now a 3 way table
structable(TV)

#\TODO{DM: Why not using \func{collapse.table} as introduced before?}

TV_df <- as.data.frame.table(TV)
levels(TV_df$Time) <- c(rep("8:00-8:59", 4),
                        rep("9:00-9:59", 4), rep("10:00-10:44", 3))
TV2 <- xtabs(Freq ~ Day + Time + Network, TV_df)
structable(Day ~ Time + Network, TV2)

TV2 <- collapse.table(as.table(TV), Time=c(rep("8:00-8:59", 4),
                        rep("9:00-9:59", 4), rep("10:00-10:44", 3)))

# revise collapse.table to accept arrays
TV2 <- collapse.table(TV, Time=c(rep("8:00-8:59", 4),
                        rep("9:00-9:59", 4), rep("10:00-10:44", 3)))
