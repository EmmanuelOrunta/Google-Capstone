
### Installing required packages and libraries
install.packages("tidyverse")
install.packages("lubridate")
library(tidyverse)
library(lubridate)
library(stringr)


### Checking the columns of the tables
colnames(january_2022)
colnames(febuary_2022)
colnames(march_2022)
colnames(april_2022)
colnames(may_2022)
colnames(june_2022)
colnames(july_2022)
colnames(august_2022)
colnames(september_2022)
colnames(october_2022)
colnames(november_2022)
colnames(december_2022)


### Joining all tables together
all_year_trips <- bind_rows(january_2022, febuary_2022, march_2022, april_2022, may_2022, 
                            june_2022, july_2022, august_2022, september_2022, 
                            october_2022, november_2022, december_2022)
View(all_year_trips)


###  DATA CLEANING 


### Removing columns that aren't needed
all_year_trips <- all_year_trips %>% 
                  select(-c(start_lng, start_lat, start_station_id, end_station_id, end_lat, end_lng))

all_year_trips <- all_year_trips %>% 
  select(-...14)

View(all_year_trips)

### Changing the Format of the ride_length column from datetime to time
all_year_trips$ride_length <- format(as.POSIXct(all_year_trips$ride_length), format = "%H:%M:%S")
  
View(all_year_trips)

### Checking and removing duplicates
duplicated(all_year_trips)

all_year_trips <- distinct(all_year_trips)  #removing duplicates
View(all_year_trips)

### Selecting and renaming the member_casual column to subscription
all_year_trips <- all_year_trips %>% 
  select(ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, ride_length, day_of_week, subscription = member_casual)

View(all_year_trips)

### Checking for NAs in Started_at and Ended_at
all_year_trips %>% 
  select(started_at, ended_at) %>% 
  filter(is.na(ended_at))

all_year_trips %>% 
  select(started_at, ended_at) %>% 
  filter(is.na(started_at)) %>% 
  all_year_trips

all_year_trips %>% 
  select(start_station_name) %>% 
  filter(is.na(start_station_name)) 

all_year_trips %>% 
  select(end_station_name) %>% 
  filter(is.na(end_station_name))
  

### Removing NAs in Station Names
library(tidyr)
all_year_trips <- all_year_trips %>% drop_na(start_station_name)
all_year_trips <- all_year_trips %>% drop_na(end_station_name)

View(all_year_trips)

### DATA TRANSFORMATION and MANIPULATION
### Renaming text strings in day of week
library(stringr)

rep_str = c('1'='Sunday','2'='Monday','3'='Tuesday','4'='Wednesday', '5'='Thursday','6'='Friday','7'='Saturday') ### Combining my replacement strings into a vector
all_year_trips$day_of_week <- str_replace_all(all_year_trips$day_of_week, rep_str)

View(all_year_trips)

### Calculating ride_length in mins
all_year_trips <- all_year_trips %>% 
  mutate(ride_length_mins = as.numeric(difftime(all_year_trips$ended_at, all_year_trips$started_at, units="mins")))

### Calculating ride_length in secs
all_year_trips <- all_year_trips %>% 
  mutate(ride_length_secs = as.numeric(difftime(all_year_trips$ended_at, all_year_trips$started_at, units="secs")))

### Removing rows with negative ride_lengths
all_year_trips <- all_year_trips %>% 
  filter(ride_length_mins > 0)  

### Removing rows with trips less than one minute
all_year_trips <- all_year_trips %>% 
  filter(ride_length_mins > 1)  


### DATA ANALYSIS

### Summary Statistics of Ride Length
summary(all_year_trips$ride_length_mins)

### Total rides and total number of stations
total_rides <- n_distinct(all_year_trips$ride_id)   ### Counting the total distinct number of rides from the ride_id column
total_stations <- n_distinct(all_year_trips$start_station_name) ### Counting the total distinct number of stations from the start_station_name column

### Number of rides per subscription
total_rides_subscription <- all_year_trips %>% 
                            group_by(subscription) %>% 
                            count(subscription) %>% 
                            rename(number_of_rides = n)

### The average ride time for each subscription type
avg_ridetime_subscription <- all_year_trips %>% 
  group_by(subscription) %>% 
  summarise(avg_time = mean(ride_length_mins)) %>% 
  arrange(desc(avg_time))

### To find the total of rides and avg ride length per weekday for each type of subscription
total_rides_avgridetime_subscription_perday <- all_year_trips %>%
mutate(weekday = wday(started_at, label = TRUE)) %>% 
group_by(subscription, weekday) %>%
  summarise(number_of_rides = n(), average_duration = mean(ride_length_mins)) %>% 		
  arrange(subscription, weekday)

### To find the total of rides and avg ride length per month for each type of subscription
total_rides_avgridetime_subscription_month <- all_year_trips %>%
  mutate(month = month(started_at, label = TRUE)) %>% 
  group_by(subscription, month) %>%
  summarise(number_of_rides = n(), average_duration = mean(ride_length_mins)) %>% 		
  arrange(subscription, month)

### To find the total of rides and avg ride length for a particular hour in a day for each type of subscription
total_rides_avgridetime_subscription_time <- all_year_trips %>%
  mutate(time = hour(started_at)) %>% 
  group_by(subscription, time) %>%
  summarise(number_of_rides = n(), average_duration = mean(ride_length_mins)) %>% 		
  arrange(subscription, time)

### Number of rides for every rideable type in each subscription type
total_rides_subscription_rideabletype <- all_year_trips %>% 
  group_by(subscription) %>% 
  count(rideable_type) %>% 
  rename(number_of_rides = n)


### FURTHER EXPLORATORY ANALYSIS

### Top 10 start stations according number of rides
total_rides_start_station <- all_year_trips %>% 
  group_by(start_station_name) %>% 
  count(start_station_name) %>% 
  rename(number_of_rides = n) %>% 
  arrange(desc(number_of_rides)) %>% 
  head(10)

### Top 10 end stations according number of rides
total_rides_end_station <- all_year_trips %>% 
  group_by(end_station_name) %>% 
  count(end_station_name) %>% 
  rename(number_of_rides = n) %>% 
  arrange(desc(number_of_rides)) %>% 
  head(10)

###  DATA VISUALIZATION

### Total Trips: Casual vs. Member
ggplot(total_rides_subscription, aes( x=number_of_rides, y=subscription, color=subscription, fill=subscription)) + 
  geom_col() + labs(title = "Total Trips: Casual vs. Member")

### Average RideTime: Casual vs. Member
ggplot(avg_ridetime_subscription, aes( x=subscription, y=avg_time, color=subscription, fill=subscription)) + 
  geom_col() + labs(title = "Average RideTime: Casual vs. Member")

### Total Trips In a Weekday: Casual vs. Member
ggplot(total_rides_avgridetime_subscription_perday, aes( x=weekday, y=number_of_rides, color=subscription, fill=subscription)) + 
  geom_col(position = "dodge") + labs(title = "Total Trips In A Weekday: Casual vs. Member")

### Average RideTime In a Weekday: Casual vs. Member
ggplot(total_rides_avgridetime_subscription_perday, aes( x=weekday, y=average_duration, color=subscription, fill=subscription)) + 
  geom_col(position = "dodge") + labs(title = "Average RideTime In A Weekday: Casual vs. Member")

### Total Trips In a Particular Hour: Casual vs. Member
ggplot(total_rides_avgridetime_subscription_time, aes( x=time, y=number_of_rides, color=subscription, fill=subscription)) + 
  geom_line(position = "dodge") + scale_x_continuous(breaks = scales::pretty_breaks(n = 24)) + 
  scale_y_log10() + labs(title = "Total Trips In A Particular Hour: Casual vs. Member")

### Average RideTime In a Particular Hour: Casual vs. Member
ggplot(total_rides_avgridetime_subscription_time, aes( x=time, y=average_duration, color=subscription, fill=subscription)) + 
  geom_smooth(position = "dodge") + scale_x_continuous(breaks = scales::pretty_breaks(n = 24)) + 
  labs(title = "Average Duration In A Particular Hour: Casual vs. Member")

### Total Trips In a Particular Month: Casual vs. Member
ggplot(total_rides_avgridetime_subscription_month, aes(x=month, y=number_of_rides, group=2, position_dodge(width = 0.2), color=subscription)) + 
  geom_line() + facet_wrap(~subscription) +
  labs(title = "Total Trips In A Particular Month: Casual vs. Member")


### Average RideTime In a Particular Month: Casual vs. Member
ggplot(total_rides_avgridetime_subscription_month, aes(x=month, y=average_duration, group=2, position_dodge(width = 0.2), color=subscription)) + 
  geom_line() + facet_wrap(~subscription) +
  labs(title = "Average Duration In A Particular Month: Casual vs. Member")
