
## Why R - packages to be used

library(dplyr)
library(ggplot2)
library(scales)
library(ggiraph)
library(RColorBrewer)
library(yarrr)
library(animation)
library(gganimate)
library(RCurl)
library(findviews)

# How R structures data - the data frame

data("mtcars", "iris")

head(mtcars)
summary(mtcars)
str(mtcars)
findviews(mtcars)

View(mtcars)
View(iris)
## Built in data sets



### Getting some online data

onlineData <- getURL("http://www.onthelambda.com/wp-content/uploads/2014/07/CrimeStatebyState.csv",
                    ssl.verifyhost=FALSE, ssl.verifypeer=FALSE)

class(onlineData) # needs to be put into a dataframe

crimeData <- read.csv(textConnection(onlineData), header = TRUE)
rm(onlineData)

