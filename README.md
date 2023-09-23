# INTRODUCTION
This is an optional case study from the Google Data Analytics Course that I recently completed. In this study, I put into practice the Data study Process that I learnt while taking the course by executing real-world responsibilities as a junior data analyst for a fictitious company called Cyclistic.


## BACKGROUND SCENARIO
In this mock data analysis, I'm assuming the role as a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. This company was founded in 2016 with the goal of providing people with alternative modes of transportation using bikes (both classic and electric). Cyclistic has grown their bike-share company to 5,824 geotracked bicycles and 692 stations in Chicago since then. The bikes can be unlocked in one station and locked in another, making it easy to move. This service is currently used by two sorts of members. Casual members (purchase a single or day pass) and annual members (purchase an annual membership). The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, my team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve my recommendations, so they must be backed up with compelling data insights and professional data visualizations.

## BUSINESS QUESTION
Annual members are more profitable than casual members, according to Cyclistic's financial analysts. The company wants to grasp the distinction between the two sorts of members in order to convert casual users into yearly members. My job is to collect and analyze data to answer the question, "What is the difference between casual riders and annual riders?" Lily Moreno (Director of Marketing), Cyclistic's marketing analytics team, and Cyclistic's executive team are all stakeholders.

## DATA PREPARATION AND CLEANING
To solve the business question, I will analyze the data from Cyclistic's database. The dataset contains data from January 2022 to December 2022 and I downloaded Cyclistic’s historical trip data from [here](https://divvy-tripdata.s3.amazonaws.com/index.html). Motivate International Inc. has made the data available under this [license](https://divvybikes.com/data-license-agreement). It is also cited, objective, innovative, up to date, and comprehensive. However, its data privacy policies prevent me from using personally identifiable information on riders.

### Preparation
RSTUDIO was utilized to import the Excel Workbook files of each month in 2022. The dataset was merged into one dataset labeled all_year_trips. Once the dataset was merged, there were 5,317,314 rows with 7 columns (start_station id, end_station_id, start_lat, star_lng, end_lat, and end_lng were removed since they were not necessary to answering the business question).
