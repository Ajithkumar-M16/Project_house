###Install all the required packages and load them.
install.packages("tidyverse")
library(tidyverse)

###Importing data
library(readr) # These 3 lines of importing data code can be automatically done by Rstudio. 
sample_trip <- read_csv("sample_trip.csv")
View(sample_trip)
# sliced the dataset and formed a new table that has 75000 rows
sample_trip <- slice(trips_2020_q1, 1:75000)
head(sample_trip)
# saved the 75000 row data in a .csv file
write.csv(sample_trip, "sample_trip.csv", row.names = FALSE)

###Data wrangling
# removed null values and duplicates and saved to the same dataset
sample_trip <- unique(na.omit(sample_trip))
# to trim the extra spaces in the dataset
sample_trip[] <- lapply(sample_trip,trimws)
# to check the datatype of each column
sapply(sample_trip,class)
head(sample_trip)
# calculate the difference of two POSIXct data and mutate into new column
sample_trip <- sample_trip %>% mutate(time_diff <- ended_at - started_at)
# need to change the title of the column
names(sample_trip)[14] <- "time_diff"
# separate the POSIXct datatype column  into two columns
sample_trip <- separate(sample_trip, started_at, into = c("s_date","s_time"), sep = " ")
sample_trip <- separate(sample_trip, ended_at, into = c("e_date","e_time"), sep = " ")
# after the two columns formed, their datatype was 'char' . they need to be changed respectively.
sample_trip$s_date <- as.Date(sample_trip$s_date, format = "%Y-%m-%d")
sample_trip$e_date <- as.Date(sample_trip$e_date, format = "%Y-%m-%d")
view(sample_trip)

###Data manipulation and Data visualization
#arranged the s_date column to find the starting date and ending date
data_wrang_sample_trip <- sample_trip %>% arrange(s_date)
# saving the sample_trip dataset after the cleansing process for accessibility purpose
write.csv(data_wrang_sample_trip, "data_wrang_sample_trip.csv", row.names = FALSE)
#grouped the dataset based on date and found out the total_no_of_riders & total_time per day
grouped <- data_wrang_sample_trip %>%   # new sample table in the name of data_wrang_sample_trip(wrangled table)
  group_by(s_date) %>%
  summarise(time_mins = (sum(time_diff))/60, count = n())
print(grouped)
# need to visualize the grouped table to get conclusion
ggplot(data = grouped) + geom_line(mapping = aes(x = s_date, y = count)) #to get the graph contains period trend line with count
#forming a table with only the members (without new table or calc)
only_member <- data_wrang_sample_trip %>% filter(member_casual == "member") #table for members
glimpse(only_member)
#getting the graph for members
member_data_m <- only_member %>%  
  arrange(s_date) %>%
  group_by(s_date) %>%
  summarise(time_mins = (sum(time_diff))/60, count = n())
ggplot(data = member_data_m) + geom_line(mapping = aes(x= s_date, y= count))
#we can get graph for casual riders as well
only_casual <- data_wrang_sample_trip %>% filter(member_casual == "casual") #table for casuals
glimpse(only_casual)
member_data_c <- only_casual %>%
  arrange(s_date) %>%
  group_by(s_date) %>%
  summarise(time_mins = (sum(time_diff))/60, count_c = n())
ggplot(data = member_data_c) + geom_line(mapping = aes(x= s_date, y= count_c))
## to get two line charts together in a graph
# first,form a new table that has x common and y both values
# merge both the tables using the common s_date column
new_mem_cas <- merge(member_data_m, member_data_c, by = "s_date")   # new table formed
view(new_mem_cas)
# graphical representation of two lines
ggplot(data = new_mem_cas, aes(x = s_date)) + geom_line(aes(y = count), color = "white") +
  geom_line(aes(y = count_c), color = "white") + theme_dark()
# graphical representation of line and scatter plot
ggplot(data = grouped, aes(x = s_date,y = count)) + geom_point(color = "blue") + geom_line(color = "blue")
# graphical representation using the bar chart
# creating new column by converting the date into day by using the weekdays()
new_mem_cas$name_day <- weekdays(new_mem_cas$s_date)
view(new_mem_cas)
ggplot(data = new_mem_cas, aes(x = s_date, y = count)) + geom_bar(stat = "identity", fill = "white", color = "blue") + 
  theme_dark() + geom_text(aes(label = name_day),color = "yellow", angle = 90)
## new calculations made: station_id that are most used(top 7) found them and made a map using leaflet
# top used stations
free <- data_wrang_sample_trip %>%
  count(start_station_id) # count() is used to count the no.of.occurrences of each value in a data frame column.
free1 <- data_wrang_sample_trip %>%
  count(end_station_id)
names(free)[2] <- "no_of_start_station_riders"
names(free1)[2] <- "no_of_end_station_riders"
names(free)[1] <- "station_id"
names(free1)[1] <- "station_id"
freed <- merge(free, free1, by = "station_id")
view(freed)
# 'freed' table contains no_of_start and end_station_riders
# picking top 7 by arranging in descending order. Getting their lat&long manually
map <- data.frame(station_id = c(192,77,91,133,195,174,43), latitude = c(41.8793,41.8822,41.8834,41.8892,41.8847,41.8821,41.8840), 
                  longitude = c(-87.6399,-87.6411,-87.6412,-87.6385,-87.6195,-87.6398,-87.6247))
# using Leaflet() marking these lat&longitudes
library(leaflet)
ak <- leaflet(data = map) %>%
  addTiles() %>%
  addMarkers(~longitude, ~latitude, popup = ~station_id, label = ~station_id)
ak
