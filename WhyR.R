
## Why R - packages to be used

library(dplyr)
library(ggplot2)
library(scales)
library(ggiraph)
library(RColorBrewer)
library(yarrr)
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


### Play around with colors a little - get Twitter blue, Facebook blue, (brandcolors.net)

library(dplyr)
meanHp <- mtcars %>%
        group_by(cyl) %>%
        filter(!is.na(hp)) %>%
        summarise(avg_hp = mean(hp, na.rm=TRUE))
library(ggplot2)

p1 <- ggplot(meanHp, aes(avg_hp, cyl, label = round(avg_hp, 2))) +
        geom_line(lwd = 2, col = "tomato") +
        geom_text(check_overlap = TRUE) + # the text and label add-ons overwrite the points! 
        geom_label(color = "black", bg = "lightgrey") +
        ggtitle("Average hp/cylinder") +
        ylab("Cylinders") +
        xlab("Average hp") +
        scale_x_continuous(breaks=seq(0,220,20)) + # set tick marks manually
        theme(
                axis.text = element_text(size = 14),
                panel.grid.major = element_line(color = "grey"),
                panel.grid.minor = element_line(color = "bisque"), # element_blank() gets rid of minor grid
                panel.background = element_rect(fill = "lightblue"))

ggsave(p1, filename = "AvgHP.png")

### 3. Getting some online data (RCurl package)

onlineData <- getURL("http://www.onthelambda.com/wp-content/uploads/2014/07/CrimeStatebyState.csv",
                    ssl.verifyhost=FALSE, ssl.verifypeer=FALSE)

class(onlineData) # needs to be put into a dataframe

crimeData <- read.csv(textConnection(onlineData), header = TRUE)
rm(onlineData) # removes onlineData

