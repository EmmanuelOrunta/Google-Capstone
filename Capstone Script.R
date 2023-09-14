
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
