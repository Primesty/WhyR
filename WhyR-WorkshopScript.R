
### Welcome to the WhyR Workshop - Take control of your data!! ### Starting right now! :)

## 1. Why R - installing and loading the necessary packages to be used

install.packages('dplyr', 'scales', 'RColorBrewer', 'yarrr', 'RCurl', 'findviews')
install.packages('ggplot2')

library(dplyr)
library(ggplot2)
library(scales)
library(RColorBrewer)
library(yarrr)
library(RCurl)
library(findviews)

## 2. How R structures data - the data frame - test

# Working with built-in data sets

## Our R-code will go here...

data('mtcars')

head(mtcars, 10) # gives us the first six rows alt. head(mtcars, 10)

tail(mtcars)

summary(mtcars) # summary stats

str(mtcars) # structure of your data set

## Now, that we have a general idea of how our data is structured, lets do some exploratory data analysis

# This is what we are using the ggplot2 package for

### 3. Histogram for quantitative variables


### 4. Barplot for categorical variables



### 5. Working with colors - get brandcolors - woohoo - brandcolors.net (hex-code)


## Colors with RColorBrewer and yarrr


### 6. Now for the fun part, working with real-life online data (RCurl package) - crime statistics

## Getting the data

# http://www.onthelambda.com/wp-content/uploads/2014/07/CrimeStatebyState.csv

onlineData <- getURL("http://www.onthelambda.com/wp-content/uploads/2014/07/CrimeStatebyState.csv",
                     ssl.verifyhost=FALSE, ssl.verifypeer=FALSE)

class(onlineData) # needs to be put into a dataframe

crimeData <- read.csv(textConnection(onlineData), header = TRUE)

rm(onlineData) # removes onlineData so we can keep everything nice and clean

### 7. Plot crime counts per year




### 8. We are getting more selective (only years 2002 and 2003)



### 9. Finally, we are going to plot the top ten of year 2000


### 10. Gimmick - plotting with emojis

