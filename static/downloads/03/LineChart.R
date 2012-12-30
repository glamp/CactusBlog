library(ggplot2)
library(reshape2)

#Line chart
data <- textConnection("Month,Series 1,Series 2,Series 3,Series 4
Jan,3.01,4.64,9.71,1.56
Feb,3.53,5.22,10.17,2.48
Mar,3.95,5.31,10.62,3.44
Apr,4.51,5.87,11.37,3.51
May,5.37,6.53,12.01,3.84
Jun,6.27,6.85,12.39,4.32
Jul,7.00,7.61,13.27,4.52
Aug,7.09,8.32,13.55,5.49
Sep,7.67,8.53,13.84,5.76
Oct,7.86,9.52,14.12,5.90
Nov,8.28,10.04,14.95,6.12
Dec,9.02,10.55,15.52,6.98
")
data <- read.csv(data, h=T)
data$Month <- factor(data$Month, data$Month)
data.lng <- melt(data, id=c("Month"))
p <- ggplot(aes(x=Month, y=value, group=variable, colour=variable), data=data.lng)
p + geom_line() +
  scale_color_discrete("Legend Title") +
  labs(x="X Label", y="Y Label", title="A Sample Line Chart")
# full output: http://www.yaksis.com/static/img/03/large/LineChart.png