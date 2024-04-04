rm(list=ls())
bloodPressure <- readRDS(file=file.path('~', 'bloodPressure.RDS'))

cols <- colnames(bloodPressure)

## Use regex to split the type from the date
matchType <- gregexpr(pattern='[a-z]+[[:space:]]', text=cols, ignore.case=TRUE)
matchDate <- gregexpr(pattern='[[:space:]][a-z0-9-]+', text=cols, ignore.case=TRUE) 
typeList <- unlist(regmatches(cols, matchType))
dateList <- unlist(regmatches(cols, matchDate))

## I'm not sure how to use the reshape methods to split the type from the date
## so I did it manually.
newDf <- data.frame(person = rep(bloodPressure$person, each = length(dateList)), date = rep(dateList, each = nrow(bloodPressure)), type = rep(typeList, each = nrow(bloodPressure)), val = as.vector(unlist(as.vector(bloodPressure[, 2:63]))))

newDf$date <- as.Date(x=newDf$date, format=' %Y-%b-%d')

aggregate(val ~ date + type, data=newDf, FUN=mean)