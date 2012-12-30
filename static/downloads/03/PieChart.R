library(ggplot2)

#Pie chart
data <- textConnection("Category,Value
Category A,5
Category B,4
Category C,3
Category D,2
Category E,1
")
data <- read.csv(data, h=T)

p <- ggplot(aes(x=factor(1), fill=Category, weight=Value), data=data)
p + geom_bar(width = 1) +
  coord_polar(theta="y") +
  scale_fill_discrete("Legend Title") +
  labs(x="X Label", y="Y Label", title="An Example Pie Chart")
# full output: http://www.yaksis.com/static/img/03/large/PieChart.png