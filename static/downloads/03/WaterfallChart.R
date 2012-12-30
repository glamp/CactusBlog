library(ggplot2)
library(reshape2)

data <- textConnection("Step\tValue\tChange
Start	100	
Step 1	80	20
Step 2	70	10
Step 3	62	8
Step 4	52	10
Final result	52	
")
data <- read.table(data, h=T, sep="\t")
data$id <- 1:nrow(data)

naChange <- is.na(data$Change)
data[naChange,]$Change <- data[is.na(data$Change),]$Value
data[naChange,]$Value <- 0

data$start <- data$Value
data$end <- data$start+data$Change

p <- ggplot(data, aes(Step, fill = "blue")) 
p + geom_rect(aes(x = Step, xmin = id - 0.45, xmax = id + 0.45,
                  ymin = start, ymax = end)) +
    scale_fill_identity("Metric Name") + 
    labs(x="X Label", y="Y Label", title="Waterfall Chart Example")
