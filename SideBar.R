
## Getting a sample from crimeData

set.seed(666)
crimeSpread <- crimeData[sample(nrow(crimeData), 20, replace = FALSE),]
head(crimeSpread)

# with dplyr
library(dplyr)

set.seed(666)
crimeSpread <- sample_n(crimeData, 20) # default, replace = FALSE
library(xlsx)
write.xlsx(crimeSpread, file = "crimeSpread.xlsx", row.names = FALSE)

## Subsetting and 'subtracting' data from crimeData
library(dplyr)

set.seed(666)
# Make copy of crimeData and create ID variable for crimeData

crimeData2 <- crimeData

crimeData2$ID <- rownames(crimeData2)

# Define data we want to exclude

filterDat <- sample_n(crimeData2, 1422, replace = FALSE) 
# or filterDat <- crimeData2[sample(nrow(crimeData2), 20, replace = FALSE),]

newSet <- filter(crimeData2, !(crimeData2$ID %in% filterDat$ID)) # dplyr 

newSet2 <- crimeData2[!(crimeData2$ID %in% filterDat$ID),]

# both sets -20 rows(obs)

### Un-tidying the data set

library(reshape2)
library(tidyr)

untidyDat <- dcast(crimeSpread, formula = State + Type.of.Crime + Year + Count ~ Crime) # to show how an untidy data
# set looks

write.xlsx(x = untidyDat, file = "untidyDat.xlsx",
           sheetName = "spread2", row.names = FALSE)

spread(crimeSpread, State, Crime) #tidyr

x = sample(rnorm(40, 0, 1), 40)
y = rep(c("one", "two", "three", "four"), 5)
y = sample(y, 20, replace = TRUE)

testData <- data.frame(ID = x, Factor = y)
testData
str(testData)
library(ggplot2)

ggplot(testData, aes(ID)) +
        geom_histogram(aes(y= ..density..), fill = "#fd5c63", color = "black") + #Airbnb red
        stat_function(fun = dnorm, colour = "goldenrod", lwd = 1) +
        geom_density(color = "steelblue", lwd = 1)

saveRDS(testData, file = "testData.rds")

save(testData, file = "testData.RData")

readRDS("testData.rds") # reads the file and plots it but has to be stored in new object
load("testData.RData") # loads the data right away


## Get data from github - does not work on private repos!!!

library(RCurl) # for csv etc

githubURL <- "https://github.com/Primesty/WhyR/blob/master/testData.RData"
load(url(githubURL))

## Subsetting BAWL-R

spread <- read.csv(file.choose(), header = TRUE) # BAWL-R

head(spread)
str(spread)

set.seed(666)
spread2 <- sample(nrow(spread), 100, replace = FALSE)

spread2 <- spread[sample(nrow(spread), 100, replace = FALSE),]
head(spread2)

write.table(spread2, file = "spread2.xls", sep = "\t", row.names = TRUE, col.names = TRUE)
library(xlsx)
write.xlsx(x = spread2, file = "spread2.xlsx",
           sheetName = "spread2", row.names = FALSE)