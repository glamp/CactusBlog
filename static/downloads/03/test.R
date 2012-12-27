
library(ggplot2)
library(reshape2)

p <- ggplot(aes(x=x), data=data)
p + geom_histogram()


