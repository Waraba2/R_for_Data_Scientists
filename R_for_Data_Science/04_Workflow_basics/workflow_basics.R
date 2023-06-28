# workflow: basics
# coding basics:
# using R as a calculator

1 / 200 * 30
(59 + 73 + 2) / 3
sin(pi / 2)

x <- 3 * 4

# Alt + for the <- assignement operator
# Code is miserable to read on a good day, so giveyoureyesabreak and use spaces.

# Object names must start with a letter, and can only contain letters, 
# numbers, _ and ..
x

this_is_a_really_long_name <- 2.5

this_is_a_really_long_name

# (cmd/ ctrl/ up) shows previous commands like in 

r_rocks <- 2 ^ 3

r_roCks # R is case sensitive this will not work

# CALLING FUNCTIONS:
seq(1, 10)

# to combine the assignment with the printing behavior on the same line do this.
y <- seq(1, 10, length.out = 5) 
y

# Achieve the same thing by putting it inside parenthesis.
(y <- seq(1, 10, length.out = 5))

# Exercises
# 1. Why does this code not work?
my_variable <- 10
my_varıable
#> Error in eval(expr, envir, enclos): object 'my_varıable' not found
#> Its because of the naming of the variables are different.

# 2. Tweak each of the following R commands so that they run correctly:
library(tidyverse)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
filter(year == 1999)

mpg

# alt shift K to get all the shortcuts of r studio

