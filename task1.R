rm(list=ls())
require('lubridate')

data(federalistPapers, package='syllogi')

## Get each individual piece of data from the list
number <- sapply(federalistPapers, function(x) x$meta$number)
author <- snakecase::to_upper_camel_case(sapply(federalistPapers, function(x) x$meta$author))
journal <- snakecase::to_upper_camel_case(sapply(federalistPapers, function(x) x$meta$journal))
date <- do.call('c', lapply(federalistPapers, function(x) as.Date(x$meta$date)))

infoDf <- data.frame(num=number, author=author, journal=journal, date=date)

dayOfTheWeek <- wday(na.omit(date),label=TRUE)

table(wday(infoDf$date, label=TRUE), infoDf$author)

idList <- 1:length(federalistPapers)

newDf <- (tidyr::pivot_wider(data.frame(author=author, date=date, id=idList), names_from='author', values_from='date'))
newDf <- as.data.frame(newDf)

