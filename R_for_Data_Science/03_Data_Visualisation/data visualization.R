library(tidyverse)
# Do cars with big engines use more fuel than cars with small engines?
# What does the relationship between engine size and fuel efficiency look like? 
# Is it positive? Negative? Linear? Nonlinear?
mpg
?mpg

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

# Exercice:
# Run ggplot(data = mpg). What do you see?
ggplot(data = mpg) # I see  a blank screen.
  
# How many rows are in mpg? How many columns?
# mpg has  234 rows and 11 columns
  
# What does the drv variable describe? Read the help for ?mpg to find out.
# the type of drive train, where f = front-wheel drive, r = rear wheel drive, 
# 4 = 4wd

# Make a scatterplot of hwy vs cyl.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = cyl, y = hwy))

# What happens if you make a scatterplot of class vs drv? Why is the plot not 
# useful?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = class))

## Aesthetic mappings:
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

# Mapping the class variable with the size aes. "size" defines the size of the 
# points
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
#> Warning message: Using size for a discrete variable is not advised. 

# Mapping the class variable with the alpha aes. "alpha" defines the transparency
# of the dots.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
#> Warning message:Using alpha for a discrete variable is not advised. 

# Mapping the class variable to "shape" defines the shape of the points.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
#> Warning messages:
#> 1: The shape palette can deal with a maximum of 6 discrete values because more
#> than 6 becomes difficult to discriminate; you have 7. Consider specifying 
#> shapes manually if you must have them. 
#> 2: Removed 62 rows containing missing values (`geom_point()`).

# Setting the aesthetic properties of geom manually.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color="blue")
# The name of a color as a character string.
# The size of a point in mm.
# The shape of a point as a number, as shown in Figure 3.1.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), shape=14)
# : R has 25 built in shapes that are identified by numbers. There are some 
# seeming duplicates: for example, 0, 15, and 22 are all squares. The difference
# comes from the interaction of the colour and fill aesthetics. The hollow 
# shapes (0–14) have a 
determined by colour; the solid shapes (15–20) are
# filled with colour; the filled shapes (21–24) have a 
of colour and are 
# filled with fill.

# Exercises:
# 1. What’s gone wrong with this code? Why are the points not blue?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# In order to make all points the color blue you need to pass the color outside 
# the aesthetic function like this:
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# 2. Which variables in mpg are CAtegorical? Which variables are COntinuous? 
# (Hint: type ?mpg to read the documentation for the dataset). How can you see 
# this information when you run mpg?

?mpg

# manufacturer(manufacturer name) (CA)
# model model name (CA)
# trans type of transmission (CA)
# drv the type of drive train, where f = front-wheel drive, r = rear wheel drive
# , 4 = 4wd (CA)
# fl fuel type (CA)
# class "type" of car (CA)

# displ engine displacement, in litres (C0)
# year year of manufacture (CO)
# cyl number of cylinders (CO)
# cty city miles per gallon (CO)
# hwy highway miles per gallon (CO)

# 3. Map a continuous variable to color, size, and shape. How do these aesthetics 
# behave differently for categorical vs. continuous variables?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = year))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = cal))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = fl))
# COLOR
# Categorical: Giving color a categorical variable, classes the categories by 
# color.
# Continuous: Giving color a numerical variable, leads to having dark blue become
# increasing light from the smallest values to the largest value.
# SIZE
# Advised to use continuous variable, but it will still showcase the same behavior,
# of classifying from small dot to big dot.
# SHAPE
# Only works for categorical variables by giving a shape to each category. It 
# displays only 7 of the categories.

# 4. What happens if you map the same variable to multiple aesthetics?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x =class , y = class, shape = class))
# No errors is caused by doing this but the graphs are not display anything 
# useful.

# 5. What does the stroke aesthetic do? What shapes does it work with? (Hint: 
# use ?geom_point)
ggplot(mtcars, aes(wt, mpg)) +
  geom_point(shape = 7, colour = "black", fill = "white", size = 5, stroke = 3)
# It defines the 
width of the shape. It works with the 
# the 4 that I tried, I am not sure if this is the case for the rest.

# 6. What happens if you map an aesthetic to something other than a variable 
# name, like aes(colour = displ < 5)? Note, you’ll also need to specify x and y.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, colour = displ < 5))
# This turns the points into a series of truth and false depending on the 
# condition (displ < 5)

## COMMON PROBLEMS
# ggplot(mtcars, aes(wt, mpg)) 
# +  geom_point(shape = 21, colour = "black", fill = "white", size = 5, stroke = 5)
# The plus sign is always at same line as the expression.

# Use the ? help to get help about function, skip to the code and see if there 
# is code that looks like what you are trying to do. 

# Use google and stack overflow for more information if the help on R studio is 
# not helpful.

# FACETS:
# They are useful for categorical data, if you want to split your into subsets
# to display.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

# You could have faced on two variables usin facet_grid()
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)
# If you prefer to not facet in the rows or columns dimension, use a  
# + facet_grid(. ~ cyl)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

# Exercises
# 1. What happens if you facet on a continuous variable?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~cty, nrow = 2)
# It works but it doesn't give anything useful

# 2. What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they 
# relate to this plot?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))
# It shows that there is no rear-wheel drive car with 4 or 5 cylinders.

# 3. What plots does the following code make? What does . do?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .) # facet row 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl) # facet column
# 3. Take the first faceted plot in this section:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
# What are the advantages to using faceting instead of the colour aesthetic?
# It allows me to be have subsets

# 4. What are the disadvantages? How might the balance change if you had a larger 
# dataset?
# the disadvantage is when you start having too many subset.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
  
  
# 5. Read ?facet_wrap. What does nrow do? What does ncol do? What other options 
# control the layout of the individual panels? Why doesn’t facet_grid() have 
# nrow and ncol arguments? 
# nrow specifies the number of rows and ncol specifies the number of columns. We 
# cannot use the nrow and n column with facet frip because ist messes with the 
# facet grid structure.
  
# 6. When using facet_grid() you should usually put the variable with more unique 
# levels in the columns. Why?
# I makes it easier to interpret the facet_grid data.

## GEOMETRIC OBJESTS:
# Using geom to plot different graph of the same data.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

# Every geom take the mapping argument but you shouldn't use the smae aesthetic 
# for all geom type. For example you can not use shape for a line instead you 
# use the linetype aesthetis
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# There is about 40 geom function, you can find all of them at cheatsheet ggplot2.

# In ggplot2, certain geoms such as geom_smooth() can display multiple rows of 
# mdata using a single geometric object. I can achieve this by using the group 
# aestetic
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )

# In order to have multiple geoms in one plot add the geom to the ggplot.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

# To make changing the code easier you can pass in the aesthetic to ggplot, and
# all your geoms can get acces to it.
ggplot(data = mpg , mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()
# This does the same thing that the previous code chunck does.

# In order to apply different aesthetics to different layers.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

# Exercises
# 1. What geom would you use to draw a line chart? A boxplot? A histogram? An 
# area chart?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_line() # for a line 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_boxplot(mapping = aes(group = class)) # boxplot
ggplot(data = mpg, mapping = aes(x = displ)) +
  geom_histogram() # for a histogram takes either x or y aesthetic.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_area() # for an area chart.
  
# 2. Run this code in your head and predict what the output will look like. Then
#, run the code in R and check your predictions.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE, ) # It shows the class for the lines and the points at 
                          # the same time. Like I predicted dope.

# 3. What does show.legend = FALSE do? What happens if you remove it? Why do you
# think I used it earlier in the chapter?
# It gets rid of the legend of the geom_smooth() leaving the legend of the goeom
# _point() intact.


# 4. What does the se argument to geom_smooth() do?
# It deals with the light gray band that is the standard error of the 
# geom_smooth() line.
  
# 5. Will these two graphs look different? Why/why not?
  
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# There will be no difference because passing the aesthetic to ggplot applies it 
# to all the geoms unless you over-write it.

# 6. Recreate the R code necessary to generate the following graphs.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(mapping = aes(group = drv ), se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(linetype = drv))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(shape = 21, size = 7, color = "white", stroke = 2) +
  geom_point(mapping = aes(color = drv), size = 5) 
  
# STATISTICAL TRANSFORMATIONS:
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

# The algorithm used to calculate new values for a graph are call stat transform
# ation
?geom_bar()

# You can use geom_bar and stat_count interchabgably
ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))
# Every geom has a default stat and each stat has a default geom. This means 
# that you can use geom most of the time without worrying about the underlying 
# stat except in 3 situations.

# 1. You might want to override the default stat model:
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")
# This means you can change from the default count model to a frequency using 
# stat = "identity".

# 2. overide count in aestetic
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))

# 3. You can also use summarize which summarizes the y value of each x axis.
ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median,
  ) 

# 1.
ggplot(data = diamonds) +
  geom_pointrange(
    mapping = aes(cut, y = depth),
    stat = "summary",
    fun.min = min,
    fun.max = max,
    fun = median,
  )

# What does geom_col() do? How is it different to geom_bar()?



ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop..))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))

# Group make sure the correct plot is plot.
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

# whith the fill yuou need to normalize it. this allows me to have the count of 
# each color 
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..count.. / sum(..count..), fill = color))

# POSITION ADJUSTEMENTS:

# This has an impact on the the 
color of the bars
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, colour = cut))
# And this onr fills the bars with color
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

# using a variable like clarity with the geom_bar showcases a different behavior
#. It combines clarity whith cut variable.
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))f
# The stacking is perfor automatically by position adjustment. You can use 
# "identity", "dodge", or "fill" to override it.
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 1/5, position = "identity")
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) +
  geom_bar(fill = NA, positon = "identity")
# This identity positon is more useful for 2d geoms.

# Position = "fill" does the same thing as stacked bar it but each bar has the 
# same height it makes it easier to see proportions. 
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

# position = "dodge" put overlapping objects directly beside one another, making
# it easier to compare individual values.
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

# Use the positon = "jitter" to avoid overfitting. It add random noise to the 
# scatterplot.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

# Exercises
# What is the problem with this plot? How could you improve it?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point(position = "jitter")
# We are overploting it was improved by introducing randomness using "jitter" to
# see more obsevations

# 2.What parameters to geom_jitter() control the amount of jittering?
# in geom_jitter() doc the arguments width and height of the jitter
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point(position = position_jitter(height = 0, width = 0)) # Default values 
# that can be changed depending on you.

# geom_count size the points based on the number of observations. The bigger 
# points have the most observation.
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_count()

# The geom_count() geom does not change x and y coordinates of the points. 
# However, if the points are close together and counts are large, the size of 
# some points can itself create overplotting. For example, in the following 
# example, a third variable mapped to color is added to the plot. In this case, 
# geom_count() is less readable than geom_jitter() when adding a third variable 
# as a color aesthetic.
ggplot(data = mpg, mapping = aes(x = cty, y = hwy, color = class)) +
  geom_jitter()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy, color = class)) +
  geom_count()

# To solve this problem you can combine geom_count and geom_jitter 
ggplot(data = mpg, mapping = aes(x = cty, y = hwy, color = class)) +
  geom_count(position = "jitter") # Now geom_count is more readbable.
# Note: There is no universal solution to overploting. The approch is going to
# depand on the data and data scientist solving it.

# What’s the default position adjustment for geom_boxplot()? Create a 
# visualization of the mpg dataset that demonstrates it.
# It is doged2.
ggplot(data = mpg, mapping = aes(x = drv, y = hwy, colour = class)) +
  geom_boxplot()

# using position = "identity" overlap the boxes.
ggplot(data = mpg, aes(x = drv, y = hwy, colour = class)) +
  geom_boxplot(position = "identity")

# COORDINATE SYSTEMS
# They are one of the most complicated concepts in ggplot2.
# coord_flip() interchanges the x axis with the y axis.
ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_boxplot()

ggplot(data = mpg, aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()

# coord_quickmap() sets the aspect ration of maps.
nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_quickmap()

# coord_polar() uses polar coordinates. Polar coordinates reveal an interesting 
# connection between a bar chart and a Coxcomb chart.

bar <- ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip() 
bar + coord_polar()

# Exercises
# 1. Turn a stacked bar chart into a pie chart using coord_polar().
ggplot(mpg, aes(x = factor(1), fill = drv)) +
  geom_bar(width = 1) +
  coord_polar(theta = "y")
#you get a bul eye chart by omitting the theta = y 
ggplot(mpg, aes(x = factor(1), fill = drv)) +
  geom_bar(width = 1) +
  coord_polar()
# 2. What does labs() do? Read the documentation.
?labs()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip() +
  labs(
    y = "Highway MPG",
       x = "Class",
       title = "Highway MPG by car class",
       subtitle = "1999-2008",
       caption = "Source: http://fueleconomy.gov"
    )
# It modifies  the axis, legend and plot labels.


# 3. What’s the difference between coord_quickmap() and coord_map()?

# 4.What does the plot below tell you about the relationship between city and 
# highway mpg? Why is coord_fixed() important? What does geom_abline() do?

# The xlab(), ylab(), and x- and y-scale functions can add axis titles. 
# The ggtitle() function adds plot titles.

p <- ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline()
p + coord_fixed()

p







      




  