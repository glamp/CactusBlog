library(ggplot2)
library(reshape2)

# Stacked column chart w/ volume
data <- textConnection("Month,Item A,Item B,Item C,Negative Item D
Jan,0.08,0.51,1.31,-1.90
Feb,1.00,1.32,1.18,-1.61
Mar,1.71,1.95,1.02,-1.56
Apr,2.08,2.02,1.53,-1.66
May,2.25,2.10,1.18,-1.57
Jun,2.99,2.62,1.30,-1.10
Jul,3.02,3.24,1.57,-1.75
Aug,3.50,4.09,1.46,-1.05
Sep,3.72,4.90,1.49,-1.46
Oct,4.54,5.11,1.07,-1.58
Nov,5.16,5.85,1.73,-1.98
Dec,5.57,6.74,1.93,-1.73
")
data <- read.csv(data, h=T)
data$Month <- factor(data$Month, data$Month)
data.lng <- melt(data, id=c("Month"))
data.notNegD <- subset(data.lng, variable!="Negative.Item.D")
data.onlyNegD <- subset(data.lng, variable=="Negative.Item.D")

p <- ggplot(aes(x=Month, weight=value, fill=variable),
            data=data.notNegD)
p + geom_bar() +
  geom_bar(aes(x=Month, ymin=-value, ymax=0), data=data.onlyNegD) + 
  labs(x="X label", y="Y Label", title="An Example Stacked Column Volume Chart")
# full output: http://www.yaksis.com/static/img/03/large/StackedColumnVolumeChart.png