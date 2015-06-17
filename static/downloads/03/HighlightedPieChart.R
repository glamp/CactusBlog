library(ggplot2)

data <- textConnection("Category,Value
Category A,5
Category B,4
Category C,3
Category D,2
Category E,1
")
data <- read.csv(data, h=T)

#Highlighted Pie
p <- ggplot(aes(x=factor(1), colour=Category, fill=ifelse(Category=="Category B", "blue", "grey"),
                weight=Value), data=data)
p + geom_bar(width = 1) +
  coord_polar(theta="y") +
  scale_fill_identity("Legend Title") +
  labs(x="X Label", y="Y Label", title="An Example Pie Chart w/ Highlighted Piece")
# full output: http://www.yaksis.com/static/img/03/large/HighlightedPieChart.png