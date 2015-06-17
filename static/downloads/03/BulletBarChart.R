library(ggplot2)

# Bullet bar
data <- textConnection("Category,Series 1,Series 2
Category A,6.83,10 
Category B,0.2,.3
Category C,0.49,1 
Category D,2.72,4 
Category E,1.98,2 
Category F,0.15,2 
Category G,2.78,8 
Category H,2.91,7 
Category I,1.14,8 
Category J,2.19,6 
Category K,2.03,6 
Category L,1.44,4 
")

data <- read.csv(data, h=T)
data$Category <- as.factor(data$Category)

p <- ggplot(aes(x=Category, y=Series.2, fill="dark green"), witdh=1, data=data)
p + geom_bar() +
  geom_bar(aes(x=Category, y=Series.1, fill="light green"), width=.4, data=data) +
  scale_fill_identity() +
  coord_flip() +
  labs(x="X Label", y="Y Label", title="An Example Bullet Chart")
# full output: http://www.yaksis.com/static/img/03/large/BulletBarChart.png