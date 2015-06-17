library(ggplot2)

data <- textConnection("Month,Series 1,Series 2
Jan,0.17,5.60
Feb,0.95,8.52
Mar,1.56,8.74
Apr,2.09,1.08
May,2.69,5.54
Jun,2.73,3.03
Jul,3.49,6.00
Aug,3.65,5.78
Sep,4.01,4.32
Oct,4.57,7.56
Nov,5.45,5.90
Dec,6.16,2.43
")

data <- read.csv(data, h=T)
data$Month <- factor(data$Month, data$Month)

p <- ggplot()
p + geom_bar(aes(x=Month, weight=Series.1), data=data) +
  geom_line(aes(x=Month, y=Series.2, group=1), colour="blue", data=data) +
  labs(x="X Label", y="Y Label", title="Chart Title")
# full output: http://www.yaksis.com/static/img/03/large/ColumnAndLineChart.png