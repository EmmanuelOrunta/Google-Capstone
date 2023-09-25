# INTRODUCTION
This is an optional case study from the Google Data Analytics Course that I recently completed. In this study, I put into practice the Data study Process that I learnt while taking the course by executing real-world responsibilities as a junior data analyst for a fictitious company called Cyclistic.


## BACKGROUND SCENARIO
In this mock data analysis, I'm assuming the role as a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. This company was founded in 2016 with the goal of providing people with alternative modes of transportation using bikes (both classic and electric). Cyclistic has grown their bike-share company to 5,824 geotracked bicycles and 692 stations in Chicago since then. The bikes can be unlocked in one station and locked in another, making it easy to move. This service is currently used by two sorts of members. Casual members (purchase a single or day pass) and annual members (purchase an annual membership). The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, my team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve my recommendations, so they must be backed up with compelling data insights and professional data visualizations.

## BUSINESS QUESTION
Annual members are more profitable than casual members, according to Cyclistic's financial analysts. The company wants to grasp the distinction between the two sorts of members in order to convert casual users into yearly members. My job is to collect and analyze data to answer the question, "What is the difference between casual riders and annual riders?" Lily Moreno (Director of Marketing), Cyclistic's marketing analytics team, and Cyclistic's executive team are all stakeholders.

## DATA PREPARATION AND CLEANING
To solve the business question, I will analyze the data from Cyclistic's database. The dataset contains data from January 2022 to December 2022 and I downloaded Cyclistic’s historical trip data from [here](https://divvy-tripdata.s3.amazonaws.com/index.html). Motivate International Inc. has made the data available under this [license](https://divvybikes.com/data-license-agreement). It is also cited, objective, innovative, up to date, and comprehensive. However, its data privacy policies prevent me from using personally identifiable information on riders.

### Data Transfer And Preparation
RSTUDIO was utilized to import the Excel Workbook files of each month in 2022. The dataset was merged into one dataset labeled all_year_trips. Once the dataset was merged, there were 5,317,314 rows with 7 columns (start_station id, end_station_id, start_lat, star_lng, end_lat, and end_lng were removed since they were not necessary to answering the business question). The columns consisted of ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, and member_casual. Prior to the importation of the datasets into RStudio, Excel was utilized to calculate the weekday on which the rides took place which was stored in form of numbers (1-7) in the day_of_week column and also the ride length which was stored in the ride_length column. 

### Data Cleaning and Transformation
Here is a summary of my cleaning process. You can check out the full code on one of my [GitHub](https://github.com/EmmanuelOrunta/Google-Capstone/blob/main/Capstone%20Script.R) repositories. 

- Columns that were not required for my analysis were removed (start_station_id, end_station_id, start_lat, start_lng, end_lat, and end_lng).
- There were no duplicates when I checked. Each ride_id was distinct.
- The member_casual column was renamed to Subscription.
- Empty rows in the start_station_name and end_station_name were removed because they were needed or useful for our analysis.
- Renaming text strings in day of week column to actual day of the week i.e from 1 to Sunday, 2 to Monday and so on.
- Calculating ride_length in mins and secs from the started_at and ended_at column.
- After Calculating the ride length in secs and mins, ride lengths with negative values were removed as they were not needed for the analysis.
- Trips that lasted less than a minute were eliminated since they indicated that the bike had been stolen or was being serviced.


## ANALYSIS AND VISUALIZATION
The analysis was carried out in RStudio and the data visualizations was also created using RStudio. The following are the steps I carried out during my analysis:

- I performed summary statistics with the business question in mind for this phase, focusing on the distinction between members and casual riders.
- I calculated the total number of rides as well as the total number of stations in Cyclistic.
- 
