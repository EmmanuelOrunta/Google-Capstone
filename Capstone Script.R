
### Installing required packages and libraries
install.packages("tidyverse")
install.packages("lubridate")
library(tidyverse)
library(lubridate)



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