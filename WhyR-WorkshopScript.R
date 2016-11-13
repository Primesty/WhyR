
### Welcome to the WhyR Workshop - Take control of your data!! ### Starting right now! :)

## 1. Why R - packages to be used

library(dplyr)
library(ggplot2)
library(scales)
library(ggiraph)
library(RColorBrewer)
library(yarrr)
library(RCurl)
library(findviews)

## 2. How R structures data - the data frame - test

# Working with built-in data sets

## Our R-code will go here...



## Now, that we have a general idea of how our data is structured, lets do some exploratory data analysis

# This is what we are using the ggplot2 package for

### 3. Histogram for quantitative variables



### 4. Barplot for categorical variables



### 5. Working with colors - get brandcolors - woohoo - brandcolors.net (hex-code)


## Colors with RColorBrewer and yarrr



### 6. Boxplots for quantitative variables



### 7. It is getting more intense - we are going to plot the meanHP/cylinder

## Some data-processing to get mean hp (we create a new dataset with meanHP and cyl from mtcars)



## Actual plot



# Saving the plot as a .png file



### 8. Now for the fun part, working with real-life online data (RCurl package) - crime statistics

## Getting the data

# http://www.onthelambda.com/wp-content/uploads/2014/07/CrimeStatebyState.csv

### 9. Plot crime counts per year



### 10. We are getting more selective (only years 2002 and 2003)



### 11. Finally, we are going to plot the top ten of year 2000

