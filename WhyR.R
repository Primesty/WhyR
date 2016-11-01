
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

# Histogram for quantitative variables

hist(mtcars$hp, col = "blue")

ggplot(mtcars, aes(hp)) +
        geom_histogram(binwidth = 10, fill = "red", col = "black") +
        ggtitle("Histogram HP") +
        xlab("Horsepower") +
        ylab("Counts")

ggplot(mtcars, aes(hp)) +
        geom_histogram(aes(y = ..density..), fill = "#fd5c63", binwidth = 10, col = "black") +
        stat_function(fun = dnorm, color = "goldenrod", lwd = 1,
                      args=list(mean = mean(mtcars$hp), sd = sd(mtcars$hp))) +
        geom_density(color = "steelblue", lwd = 1, fill = "steelblue", alpha = .5)

# Barplot for categorical variables

mtcars2 <- mtcars
mtcars2 <- mutate(mtcars, gear = as.factor(gear))

ggplot(mtcars2, aes(gear)) +
        geom_bar(fill = "red", col = "black") +
        

# Boxplots for quantitative variables

myColors <- c("#1da1f2", "#fd5c63", "#003a70")
names(myColors) <- levels(mtcars2$gear)
names(myColors) <- c("4", "3", "5") # change the level-colors according to order


ggplot(mtcars2, aes(gear, hp)) +
        geom_boxplot(aes(fill = gear), col = "orange", show.legend = FALSE) +
        scale_fill_manual(name = "Test", values = myColors) +
        coord_flip() +
        stat_summary(fun.y=mean, geom="point", shape=16, size=2, col = "yellow") +
        stat_boxplot(geom = "errorbar", col = "red", lty = 2, lwd = 1) +
        theme(axis.text = element_text(size = 12),
                panel.grid.major = element_line(color = "grey"),
                panel.grid.minor = element_line(color = "grey"), # element_blank() gets rid of minor grid
                panel.background = element_rect(fill = "white", color = "black"))+
        ggtitle("Boxplot of HP/Gears") +
        ylab("Gears") +
        xlab("Horsepower")

### Play around with colors a little - get Twitter blue, Facebook blue, (brandcolors.net)

library(dplyr)
meanHp <- mtcars %>%
        group_by(cyl) %>%
        filter(!is.na(hp)) %>%
        summarize(avg_hp = mean(hp, na.rm=TRUE))
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

