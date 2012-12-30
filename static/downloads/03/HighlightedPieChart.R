library(ggplot2)
library(reshape2)
data <- textConnection("Category\tValue
Category A\t5
Category B\t4
Category C\t3
Category D\t2
Category E\t1
")
data <- read.table(data, sep="\t", h=T)

#Highlighted Pie
p <- ggplot(aes(x=factor(1), colour=Category, fill=ifelse(Category=="Category B", "blue", "grey"),
                weight=Value), data=data)
p + geom_bar(width = 1) +
  coord_polar(theta="y") +
  scale_fill_identity("Legend Title") +
  labs(x="X Label", y="Y Label", title="An Example Pie Chart w/ Highlighted Piece")
