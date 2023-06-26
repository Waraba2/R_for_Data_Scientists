library(nycflights13)
library(tidyverse)

nycflights13::flights

View(flights)
# ROWS
# Filtering the data "filter()": filtering consist of keeping the rows based on the values of the columns.
flights |>
  filter( dep_delay > 120)

# You can also use these: >, >=, <, <=, ==, and !=.
# You can also combine conditions with:  & or |.
# Flights that departed on January 1st.
flights |>
  filter(month == 1 & day == 1)

# Flights that departed in January or February.
flights |>
  filter(month == 1 | month == 2)

# Shortcut when combining | and ==: %in%.
# A shorter way to select flights that dparted in January or February.
flights |>
  filter(month %in% c(1, 2))

# To save your results use the <- operator.
jan1 <- flights |>
  filter(month == 1, day == 1)

# Common mistakes
# 1. Avoing using = instead of this ==.
# 2. Using english "or" instead of |. Doesn't throw an error but leads to a different behavior.

# Arranging the data (arrang) changes the order of the rows based on the value of the columns.
# You can arrange using multiple columns it will do it on all the column (I'm 100% sure about this statment.
flights |>
  arrange(year, month, day, dep_time)

# We also arrange in descending order using dec().
flights |>
  arrange(desc(dep_delay))

# Note: The number of rows is not changing since we are doing arrange insted of filtering.

# Distinc (distinct()) finds all the unique rows on the date it also operates on the rows of the data set.
# Remove duplicate rows if any.
flights |>
  distinct()

# Find all unique origin and destination pairs.
# Note: This get rid of all the other columns.
flights |>
  distinct(origin, dest)

# We can do the same from above while keeping all the other columns. Using .keep_all = TRUE
flights |>
  distinct(origin, dest, .keep_all = TRUE)

# All of the distinct flights are on January 1:distinct() will find the first occurrence of
# a unique row in the datasetand discard the rest.If you want to find the number of occurrences instead, you’re better
# offswapping distinct() for count(), and with the sort = TRUE argument you can arrange them in descending order of
# number ofoccurrences. You can decide use .keep_all as well
flights |>
  count(origin, dest, sort = TRUE)

# Exercises1.
# In a single pipeline for each condition, find all flights that meet the condition:

# Had an arrival delay of two or more hours
flights |>
  filter(arr_delay >= 2)
# Flew to Houston (IAH or HOU)
flights |>
  filter(dest %in% c('IAH', 'HOU'))
# Were operated by United(UA), American(AA), or Delta(DL)
flights |>
  filter(carrier %in% c('UA', 'AA', 'DL'))
# Departed in summer (July, August, and September)
flights |>
  filter(month %in% c(7, 8, 9))
# Arrived more than two hours late, but didn’t leave late
flights |>
  filter(arr_delay > 2 & dep_delay <= 0)
# Were delayed by at least an hour, but made up more than 30minutes in flight
?nycflights13::flights

tests <- flights |>
  filter(arr_delay > 1 & air_time > 30)




# 2. Sort flights to find the flights with the longest departure delays.
# Find the flights that left earliest in the morning.
# 3. Sort flights to find the fastest flights. (Hint: Try including a math calculation inside of your function.)
# 4. Was there a flight on every day of 2013?
# 5. Which flights traveled the farthest distance? Which traveled the least distance?
# 6. Does it matter what order you used filter() and arrange() ifyou’re using both? Why/why not? Think about the results
# and howmuch work the functions would have to do.





