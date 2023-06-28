# PREREQUESITS:
library(nycflights13)
library(tidyverse)

# FASMSG:
# FILTERING ROWS WITH filter().
filter(flights, month == 1, day == 1)

# dyplr never modifies its data if you want to save your changes, do this:
jan1 <- filter(flights, month == 1, day == 1)

# R either print out the result or save it in a variable. To do both wrap the 
# assignment in a parenthesis.
(dec25 <- filter(flights, month == 12, day == 25))

# COMPARISONS:
# R provides the standard suite: >, >=, <, <=, != (not equal), and == (equal).
# Avoid newbie mistake of doing this: 
# filter(flights, month = 1)
#> Error in `filter()`:
#> ! We detected a named input.
#> ℹ This usually means that you've used `=` instead of `==`.
#> ℹ Did you mean `month == 1`?

# Surprise:
sqrt(2) ^ 2 == 2

1 / 49 * 49 == 1

# Computers use finite precision arithmetic (they obviously can’t store an 
# infinite number of digits!) so remember that every number you see is an 
# approximation. Instead of relying on ==, use near():
near(sqrt(2) ^ 2, 2)
near(1 / 49 * 49, 1)

# LOGICAL OPERATORS: & is “and”, | is “or”, and ! is “not”.
# y & !x: everything that is  y and not x.
# x & y: everything that is y and x.
# x & !y: everything that is x and not y
# x: everything that is x.
# xor(x, y) everything that is not x or y.
# y: everything that is y.
# x | y: everything that is x or y.

# Flights that departed in November or December:
filter(flights, month == 11 | month == 12)

# To not be redundent with month we can use the %in% operator, the shortcut for
# is ctrl shift I
nov_dec <- filter(flights, month %in% c(11, 12))

# Sometimes you can simplify complicated subsetting by remembering De Morgan’s 
# law: !(x & y) is the same as !x | !y, and !(x | y) is the same as !x & !y. For
# example, if you wanted to find flights that weren’t delayed (on arrival or 
# departure) by more than two hours, you could use either of the following two 
# filters:
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

# Missing values:
# almost every opertion with NA leads to NA
NA > 5
10 == NA
NA + 10
NA / 2

# The most confusing case is this
NA == NA
#>[1] NA

# It makes sense to get NA:
# Let x be Mary's age. We don't know her age.
x <- NA
# Let y be JOHN age. We don't know his age.
y  <- NA
# Is John and Mary the same age?
x == y
# We don't know.

# If you want to know a value is missing use the is.na()
is.na(x)

# filter only includes rows wher the condition is true; anything that is false 
# or a missinging value are not included.
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)

# EXERCISES:
# 1. Find all flights that
#   1 .Had an arrival delay of two or more hours
filter(flights, arr_delay >= 2)
#   2. Flew to Houston (IAH or HOU)
filter(flights, dest %in% c("IAH", "HOU"))	
#   3. Were operated by United, American, or Delta
filter(flights, carrier %in% c("UA", "AA", "DL"))
#   4. Departed in summer (July, August, and September)
filter(flights, month %in%  7:9)
#   5. Arrived more than two hours late, but didn’t leave late
filter(flights, arr_delay > 120, dep_delay <= 0)
#   6. Were delayed by at least an hour, but made up over 30 minutes in flight
filter(flights, dep_delay >= 60, dep_delay - arr_delay > 30)
#   7. Departed between midnight and 6am (inclusive)
summary(flights$dep_time)
filter(flights, dep_time <= 600 | dep_time == 2400)
filter(flights, dep_time %% 2400 <= 600) # same as previous.
# 2. Another useful dplyr filtering helper is between(). What does it do? Can you 
# use it to simplify the code needed to answer the previous challenges?
filter(flights, between(month, 7, 9))
  
# 3. How many flights have a missing dep_time? What other variables are missing? 
# What might these rows represent?
filter(flights, is.na(dep_time))
summary(flights)
  
# 4. Why is NA ^ 0 not missing? Why is NA | TRUE not missing? Why is FALSE & NA 
# not missing? Can you figure out the general rule? (NA * 0 is a tricky 
# counterexample!)\
NA ^ 0 # Everything powered to 0 is 1.
NA | TRUE # NA | TRUE is TRUE because anything or TRUE is TRUE. If the missing 
# value were TRUE, then TRUE | TRUE == TRUE, and if the missing value was FALSE,
# then FALSE | TRUE == TRUE.
NA & FALSE # For NA | FALSE, the value is unknown since TRUE | FALSE == TRUE, 
# but FALSE | FALSE == FALSE.

# ARRANGE ROWS WITH arrange()
# arrange behaves approximatly like filter but intead of selecting the rows it
# order them. 
# If you provide more than one column name, each additional column will be used 
# to break ties in the values of preceding columns:
arrange(flights, year, month, day)

# To arrange in descending order.
arrange(flights, desc(dep_delay))

# Missing values are always sorted at the end.
df <- tibble(x = c(5, 2, NA))

arrange(df, x)

arrange(df, desc(x))

# Exercises
# 1. How could you use arrange() to sort all missing values to the start? 
# (Hint: use is.na()).

arrange(df, desc(is.na(x)), x)

# 2. Sort flights to find the most delayed flights. Find the flights that left 
# earliest.
arrange(flights, desc(dep_delay))
arrange(flights, dep_delay)

# 3. Sort flights to find the fastest (highest speed) flights.
arrange(flights, air_time)
head(arrange(flights, desc(distance / air_time)))
# 4. Which flights travelled the farthest? Which travelled the shortest?
arrange(flights, desc(dep_delay))
arrange(flights, desc(air_time))
arrange(flights, air_time)

# SELECT COLUMNS WITH select():

select(flights, year, month, day) # select using the column names.

select(flights, year:day) # select using a range of column.

select(flights, -(year:day)) # select everything except the column on between 
# year and day (inclusive)

# Some helper functions to use with select:
select(flights, starts_with("c"))

select(flights, ends_with("y"))

select(flights, contains("arr"))

select(flights, matches("(.)\\1")) # use regular expression

select(flights, num_range("x", 1:3)) # x1, x2, x3

?select# get more detail

# we can use select to rename columns names but it is not recommended to do so. 
# Instead we use rename which is way better.
(rename(flights, tail_num = tailnum))

# Another dope select can do is use the everything function 
select(flights, time_hour, air_time, everything())
select(flights, year:day, everything())
select(flights,everything(), year:day)

# Exercises
# 1.Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time,
# and arr_delay from flights.
select(flights, dep_time, dep_delay, arr_time, arr_delay) # name
select(flights, "dep_time", "dep_delay", "arr_time", "arr_delay")# or string
select(flights, 4, 6, 7, 9) # using the column numbers NOT RECOMMENDED BECAUSE 
# THE DATA CHANGES 
# Or using the any_of or all_of
select(flights, all_of(c("dep_time", "dep_delay", "arr_time", "arr_delay")))

select(flights, any_of(c("dep_time", "dep_delay", "arr_time", "arr_delay")))

variables <- c("dep_time", "dep_delay", "arr_time", "arr_delay")
select(flights, all_of(variables))

# Using starts_with
select(flights, starts_with("dep_"), starts_with("arr_"))

# Using regex matches.
select(flights, matches("^(arr|dep)_(time|delay)$")) 

# using the bang bang operator:
variables <- c("dep_time", "dep_delay", "arr_time", "arr_delay")
select(flights, !!variables)

# What happens if you include the name of a variable multiple times in a 
#select() call?
select(flights, year, month, year, month) # using a variable multiple times 
# doesn't add the column multiple times
select(flights, arr_delay, everything())
  
# What does the any_of() function do? Why might it be helpful in conjunction with this vector?
  
  vars <- c("year", "month", "day", "dep_delay", "arr_delay")
  select(flights, one_of(vars))
  select(flights, any_of(vars))
  select(flights, all_of(vars))
  # all_of raises an error if one of the variables is not found and any_of 
  # ignores it.
# Does the result of running the following code surprise you? How do the select
# helpers deal with case by default? How can you change that default?
  select(flights, contains("TIME")) # it is not case sensisitive.
# In order to make it case sensitive.
  select(flights, contains("TIME", ignore.case = FALSE))
  
# ADD NEW VARIABLES WITH mutate():
flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time
                      )
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60
       )
  

# Referring to variables just created
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
       )

# If you want to only keep the variables you just made use transmute
transmute(flights_sml,
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gian_per_hour = gain / hours
          )

# USEFUL CREATION FUNCTIONS
transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100)
# you can also use log2() there is other log but log2() is advised.

# We also have lag and lead they are called offsets.
(x <- 1:10)

lag(x)
lead(x)
# Cumulative and rolling aggregates: cumsum(), cumprod(), cummin(), cummax(); 
# and dplyr provides cummean()
cumsum(x)
cummean(x)

# cumsum(), cumprod(), cummin(), cummax(); and dplyr provides cummean()
# For ranking we have min_rank
y <- c(1, 2, 2, NA, 3, 4) 
min_rank(y) # ascending order.
min_rank(desc(y)) # descending order.

#If min_rank() doesn’t do what you need, look at the variants row_number(), 
# dense_rank(), percent_rank(), cume_dist(), ntile(). See their help pages for
# more details.
row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)

# Exercises
# 1. Currently dep_time and sched_dep_time are convenient to look at, but hard
# to compute with because they’re not really continuous numbers. Convert them 
# to a more convenient representation of number of minutes since midnight.
flights_time <- mutate(flights, 
       dep_time_mins = (dep_time %/% 100 * 60 + dep_time %% 100) %% 1440,
       sched_dep_time_mins = (sched_dep_time %% 100 * 60 + 
                               sched_dep_time %% 100) %% 1440)
# Select only relevant column.
select(
  flights_time, dep_time, dep_time_mins, sched_dep_time, sched_dep_time_mins
)

time2mins <- function(x) {
  (x %/% 100 * 60 + x %% 100) %% 1440
}
flights_time_2 <- mutate(flights, 
                         dep_time_mins = time2mins(dep_time),
                         sched_dep_time_mins = time2mins(sched_dep_time))
# Select only relevant column.
select(
  flights_time_2, dep_time, dep_time_mins, sched_dep_time, sched_dep_time_mins
)


# 2. Compare air_time with arr_time - dep_time. What do you expect to see? What 
# do you see? What do you need to do to fix it?
flights_airtime <- mutate(flights, 
                         dep_time = time2mins(dep_time),
                         arr_time = time2mins(arr_time),
                         air_time_diff = air_time - arr_time + dep_time
                         )
nrow(filter(flights_airtime, air_time_diff != 0))
ggplot(flights_airtime, aes(x = air_time_diff)) +
  geom_histogram(binwidth = 1)

# 3. Compare dep_time, sched_dep_time, and dep_delay. How would you expect those
# three numbers to be related?
flights_deptime <- 
  mutate(flights,
         dep_time_min = time2mins(dep_time),
         sched_dep_time_min = time2mins(sched_dep_time),
         dep_delay_diff = dep_delay - dep_time_min + sched_dep_time_min)
filter(flights_deptime, dep_delay_diff != 0)

ggplot(
  filter(flights_deptime, dep_delay_diff > 0),
  aes(y = sched_dep_time_min, x = dep_delay_diff)
) + 
  geom_point()

# 4. Find the 10 most delayed flights using a ranking function. How do you want
# to handle ties? Carefully read the documentation for min_rank().
rankme <- tibble(
  x = c(10, 5, 1, 5, 5)
)

rankme <- mutate(rankme,
                 x_row_number = row_number(x),
                 x_min_rank = min_rank(x),
                 x_dense_rank = dense_rank(x),
                 ) 
arrange(rankme, x)

# 5. What does 1:3 + 1:10 return? Why?

# 6. What trigonometric functions does R provide?

# GROUP BY AND SUMMARIZE():
# summarize collapse data frames into a single row.
summarize(flights, delay = mean(dep_delay, na.rm = TRUE)) # the na.rm = True 
# removes Na rows.
View(flights)

# Using summarize() by itself is not much useful by itself. Summmarize becomes 
# better when coupled with group_by() function. We can do things like group the 
# data frame per day and get the average dep_delay in each day.
by_day <- group_by(flights, year, month, day) 
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE)) # group_by usually goes
# with summarize.

# Combining multiple operations with the pipe
# The relationship between the distance and average delay for each location
by_dest <- group_by(flights, dest)
delay <- summarize(by_dest,
    count = n(),
    dist  = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  )
delay <- filter(delay, count > 20, dest != "HNL") # > 20 delays location excluding HNL.
  ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)
  
# Even though we grouped flights by destination, summarize to compute distance,
# average delay and number of flights and remove noisy point an Honolulu airport
# which is too far. This way of doing things is very frustrating a better way is
# by using the pipr operator.
delays <- flights %>% 
  group_by(dest) %>% 
  summarize(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL") %>% 
  ggplot(mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# Missing Values
flights %>% 
  group_by(year, month, day) %>% 
  summarize(delay = mean(dep_delay))  # Without na.rm = TRUE (remove NA)

# have NA in some rows as soon as one observation in NA everything becomes NA.
# Something and NA output NA.
flights %>% 
  group_by(year, month, day) %>% 
  summarize(delay = mean(dep_delay, na.rm = TRUE)) # Now NA rows are not 
# included in the calculation of the mean mean(dep_delay)

# In case NA means cancelled flights we can remove cancelled flights.
not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize(delay = mean(dep_delay))

# COUNTS:
# It is advised to include count when you do aggregation, or count non missing
# values using sum(!is.na(x)). This is done to make sure you don't draw 
# conclusions with small amount of data. We are looking at planes identified by
# their tail number that have the highest average delay.
delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarize(
    delay = mean(arr_delay)
    )

ggplot(data = delays, mapping = aes(x = delay)) +
  geom_freqpoly(binwidth = 10) 
# There some planes with an average delay of 300 minutes. This is a little more
# nuance. Let's see what we get if we plot a scatter plot of flights vs average
# delay
delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarize(
    delay = mean(arr_delay),
    n = n()
  )

ggplot(data = delays, mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/10) # There is way more variation in delay time when 
# their is less flights. 
# OFTEN DO THIS: whenever you plot a mean (or other summary) vs. group size, 
# you’ll see that the variation decreases as the sample size increases.

# We can now filter the groups with the smallest observations
delays %>% 
  filter(n > 25) %>% 
  ggplot(mapping = aes( x = n, y = delay)) +
  geom_point(alpha = 1/10)

# How does the average performance of batters is related to the number of times 
# they are at bat. Lahman data is used to compute the bathing average(number of 
# hits / number of attempts) of every major League baseball player.
batting <- tibble(Lahman::Batting)

batters <- batting %>% 
  group_by(playerID) %>% 
  summarize(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )

batters %>% 
  filter(ab > 100) %>% 
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point() +
  geom_smooth(se = FALSE) # As we get more sample the variation in the batting
# average get smaller, And we also see that people with high bathing average 
# get picked more because each team has the privilege to choose their players.
# It is not surprising that they choose the most skilled player more.

# we have ranking involved in  this situation. If you sort in desc(ba) people
# with best batting average are clearly lucky not skilled.(Like the sarcasm.)
batters %>% 
  arrange(desc(ba))

# Useful Summary functions:
# Learned mean(x) which is the sum divided by the length. The median(x) is where
# 50% of x is above and the other 50% bellow.
# It is some time useful to use subsetting when doing aggregation
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0])
  )

# Measures of spread 
# sd(x): the root mean squared error or standard deviation is the standard
# measure of spread..
# IQR(x): the interquartile range. (more robust)
# mad(x): the median absolute deviation.( more robust)
not_cancelled %>% 
  group_by(dest) %>% 
  summarize( distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))

# Measures of rank
# min(x): minimum
# max(x): mazimum
# quantile(x, 0.25): will find a value of x that is greater than 25% of the 
# values, and less than the remaining 75%.
# Where do the first and last flight leave everyday?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize(
    first = min(dep_time),
    last = max(dep_time)
  )

# Measures of position:
# first(x)
# nth(x, 2)
# last(x)
# x[1], x[2], x[length(x)]
not_cancelled %>%
  group_by(year, month, day) %>% 
  summarize(
    first_dep = first(dep_time),
    last_dep = last(dep_time)
  )

# These fuctins are complementary to the rank
not_cancelled %>% 
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time))) %>% 
  filter(r %in% range(r))

# Counts
# n(): counts
# sum(!is.na(x)):to count the number on non missing values.
# n_distinct(x): to count the number of distinct values.
# Which destinations have the most carrier?
not_cancelled %>% 
  group_by(dest) %>% 
  summarize(carriers = n_distinct(carrier)) %>% 
  arrange(desc(carriers))

# Counts are so useful that dplyr provides a simpler help function if all you 
# want is count.
not_cancelled %>% 
  count(dest)

# You can optionally provide a weight variable. For example, you could use this
# to “count” (sum) the total number of miles a plane flew:
not_cancelled %>% 
  count(tailnum, wt = distance)

# Count and proportion of logical values.
# sum(x > 10), mean(y == 0)
#  When used with numeric functions, TRUE is converted to 1 and FALSE to 0. This
# makes sum() and mean() very useful: sum(x) gives the number of TRUEs in x, and
# mean(x) gives the proportion.
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize(n_early = sum(dep_time < 500))

# What proportion of flights are delayed by more than an hour.
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize(hour_prop = mean(arr_delay > 60))

# Grouping Multiple variables.
# When you group variables, each summary pells of one level of the grouping.
daily <- group_by(flights,year, month, day)
(per_day <- summarize(daily, flights = n()))

(per_month <- summarize(per_day, flights = sum(flights)))

(per_year <- summarize(per_month, flights = sum(flights))) # We have data for 
# only one year.

# Ungrouping:
daily %>% 
  ungroup() %>%             # No longer grouped by date
  summarize(flights = n())  # All flights

# Exercises:
  


  

  

  










 







