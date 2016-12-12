
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

ggplot(mtcars, aes(hp)) +
        geom_histogram(binwidth = 10, fill = "blue", col = "black")+
        ggtitle("Histogram HP") +
        xlab("Horsepower") +
        ylab("Counts") +
        theme(plot.title =element_text(hjust=0.5))

ggplot(mtcars, aes(hp)) +
        geom_histogram(aes(y = ..density..), fill = "#fd5c63", binwidth = 10, col = "black") +
        stat_function(fun = dnorm, color = "goldenrod", lwd = 1,
                      args=list(mean = mean(mtcars$hp), sd = sd(mtcars$hp))) +
        geom_density(color = "steelblue", lwd = 1, fill = "steelblue", alpha = .5) +
        labs(subtitle = "test", caption = 'test') + 
        theme(plot.caption = element_text(hjust=0.5), plot.subtitle = element_text(hjust = 0.5))

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

onlineData <- getURL("http://www.onthelambda.com/wp-content/uploads/2014/07/CrimeStatebyState.csv",
                     ssl.verifyhost=FALSE, ssl.verifypeer=FALSE)

class(onlineData) # needs to be put into a dataframe

crimeData <- read.csv(textConnection(onlineData), header = TRUE)

rm(onlineData) # removes onlineData so we can keep everything nice and clean

### 9. Plot crime counts per year

head(crimeData)

str(crimeData)

crimeCountYear <- crimeData %>%
        group_by(Year) %>%
        summarize(CountYear = sum(Count))

ggplot(crimeCountYear, aes(Year, CountYear)) +
        geom_line(color = "red", lwd = 2) +
        scale_y_continuous(labels = comma)


### 10. We are getting more selective (only years 2002 and 2003)



### 11. Finally, we are going to plot the top ten of year 2000


### 12. Gimmick - plotting with emojis

