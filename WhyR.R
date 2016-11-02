
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

findviews(mtcars) # gives you a great overview of categorical and continous variables

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

## Get brandcolors - woohoo - brandcolors.net (hex-code)
        
myColors <- c("#1da1f2", "#fd5c63", "#003a70")
names(myColors) <- levels(mtcars2$gear)
names(myColors) <- c("4", "3", "5") # change the level-colors according to order

## Add an example with RColorBrewer

display.brewer.all()

piratepal(palette = "all")

myColors2 <- brewer.pal(3, "Pastel1")

myColors3 <- unname(piratepal(palette = "google"))

ggplot(mtcars2, aes(gear, hp)) +
        geom_boxplot(aes(fill = gear), col = "orange", show.legend = TRUE) +
        scale_fill_manual(name = "Gears", values = myColors3) +
        coord_flip() +
        stat_summary(fun.y=mean, geom="point", shape=16, size=2, col = "yellow") +
        stat_boxplot(geom = "errorbar", col = "red", lty = 2) +
        theme(axis.text = element_text(size = 12),
                panel.grid.major = element_line(color = "grey"),
                panel.grid.minor = element_line(color = "grey"), # element_blank() gets rid of minor grid
                panel.background = element_rect(fill = "white", color = "black"))+
        ggtitle("Boxplot of HP/Gears") +
        xlab("Gears") +
        ylab("Horsepower")


### It is getting more intense - we are going to plot the meanHP/cylinder

## Some data-processing to get mean hp (we create a new dataset with meanHP and cyl from mtcars)

meanHp <- mtcars %>%
        group_by(cyl) %>%
        filter(!is.na(hp)) %>%
        summarize(avg_hp = mean(hp, na.rm=TRUE))


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

### Plot crime counts per year

head(crimeData)

str(crimeData)

crimeCountYear <- crimeData %>%
        group_by(Year) %>%
        summarize(CountYear = sum(Count))

ggplot(crimeCountYear, aes(Year, CountYear)) +
        geom_line()

crimeCountYear2 <- crimeData %>%
        group_by(Year, Type.of.Crime) %>%
        summarize(CountYear = sum(Count))

ggplot(crimeCountYear2, aes(Year, CountYear, col = Type.of.Crime)) +
        geom_line() +
        geom_point() +
        scale_color_manual(values = brewer.pal(2, "Paired")) +
        geom_smooth(method = "loess", na.rm = TRUE) +
        scale_x_continuous(breaks = c(1960, 1965, 2000)) +
        scale_y_continuous(labels = comma)


crime2000 <- crimeData %>% filter(Year == 2002) %>% group_by(State) %>% summarize(counts = sum(Count)) %>% arrange(desc(counts)) %>% filter(counts > 350445)
head(crime2000,10)

library(scales) # for label formatting
library(RColorBrewer)

crime <-ggplot(crime2000, aes(reorder(State,counts), counts)) + geom_bar(stat = "identity", aes(fill = State)) + 
        scale_fill_manual(values = brewer.pal(10, "Paired"), guide = FALSE) +
        theme(axis.text.x  = element_text(angle=45, vjust=0.5, size=10), axis.title.x = element_blank()) +
        scale_y_continuous(labels = comma, breaks = c(0, 250000, 500000, 750000, 1000000, 1250000)) + #scales (comma, scientific)
        geom_text(aes(State, counts, label = counts), vjust = -0.5) +
        ggtitle("Top 10 states by total crimes") +
        ylab("Totals")

ggsave(crime, filename = "crimePlot.png")