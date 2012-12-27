

fdir <- "/Users/glamp/repository/blog/CactusBlog/postcode/chart-chooser"

library(ggplot2)
library(reshape2)
#Line chart
data <- textConnection("Month\tSeries 1	Series 2	Series 3	Series 4
Jan	3.01	4.64	9.71	1.56
Feb	3.53	5.22	10.17	2.48
Mar	3.95	5.31	10.62	3.44
Apr	4.51	5.87	11.37	3.51
May	5.37	6.53	12.01	3.84
Jun	6.27	6.85	12.39	4.32
Jul	7.00	7.61	13.27	4.52
Aug	7.09	8.32	13.55	5.49
Sep	7.67	8.53	13.84	5.76
Oct	7.86	9.52	14.12	5.90
Nov	8.28	10.04	14.95	6.12
Dec	9.02	10.55	15.52	6.98
")
data <- read.table(data, sep="\t", h=T)
data$Month <- factor(data$Month, data$Month)
data.lng <- melt(data, id=c("Month"))
p <- ggplot(aes(x=Month, y=value, group=variable, colour=variable), data=data.lng)
p + geom_line() +
  xlab("X Label") + 
  ylab("Y Label") +
  scale_color_discrete("Legend Title") +
  theme(title="An Example Line Chart")
ggsave(filename=paste(fdir, "LineChart.png", sep="/"))

# Bar chart
data <- textConnection("Month\tSeries 1	Series 2	Series 3	Series 4
Jan	7.41	9.38	5.52	6.25
Feb	5.74	8.27	7.29	3.39
Mar	6.52	5.42	7.51	6.20
Apr	2.02	0.70	0.24	1.88
May	7.90	0.35	9.99	6.84
Jun	3.22	8.01	0.91	1.61
Jul	1.43	8.54	8.08	7.62
Aug	9.80	7.79	8.71	8.21
Sep	2.36	8.17	5.70	4.48
Oct	4.39	9.71	7.19	4.96
Nov	3.24	0.26	7.65	1.37
Dec	8.44	7.78	9.44	3.65
")
data <- read.table(data, sep="\t", h=T)
data$Month <- factor(data$Month, data$Month)
data.lng <- melt(data, id=c("Month"))
p + geom_bar(position="dodge") +
  coord_flip() +
p <- ggplot(aes(x=Month, weight=value, fill=variable), data=data.lng)
  xlab("X Label") +
  ylab("Y Label") + 
  opts(title="An Example Bar Chart")
ggsave(filename=paste(fdir, "LineChart.png", sep="/"))

#Stacked Bar
data <- textConnection("Month\tSeries 1	Series 2	Series 3	Series 4
Jan	7.41	9.38	5.52	6.25
Feb	5.74	8.27	7.29	3.39
Mar	6.52	5.42	7.51	6.20
Apr	2.02	0.70	0.24	1.88
May	7.90	0.35	9.99	6.84
Jun	3.22	8.01	0.91	1.61
Jul	1.43	8.54	8.08	7.62
Aug	9.80	7.79	8.71	8.21
Sep	2.36	8.17	5.70	4.48
Oct	4.39	9.71	7.19	4.96
Nov	3.24	0.26	7.65	1.37
Dec	8.44	7.78	9.44	3.65
")
data <- read.table(data, sep="\t", h=T)
data$Month <- factor(data$Month, data$Month)
data.lng <- melt(data, id=c("Month"))

p <- ggplot(aes(x=Month, weight=value, fill=variable), data=data.lng)
p + geom_bar() + 
  coord_flip() +
  xlab("X Label") +
  ylab("Y Label") + 
  scale_x_discrete("Legend Title") + 
  opts(title="An Example Stacked Bar Chart")
ggsave(filename=paste(fdir, "StackedBar.png", sep="/"))


# Bullet bar
data <- textConnection("Category\tSeries 1	Series 2
Category A	 6.83 	 10 
Category B	 0.01 	 0 
Category C	 0.49 	 1 
Category D	 2.72 	 4 
Category E	 1.98 	 2 
Category F	 0.15 	 2 
Category G	 2.78 	 8 
Category H	 2.91 	 7 
Category I	 1.14 	 8 
Category J	 2.19 	 6 
Category K	 2.03 	 6 
Category L	 1.44 	 4 
")

data <- read.table(data, sep="\t", h=T)
data$Category <- as.factor(data$Category)

p <- ggplot(aes(x=Category, y=Series.2, fill="dark green"), witdh=1, data=data)
p + geom_bar() +
  geom_bar(aes(x=Category, y=Series.1, fill="light green"), width=.4, data=data) +
  scale_fill_identity() +
  coord_flip() +
  xlab("X Label") + 
  ylab("Y Label") +
  opts(title="An Example Bullet Chart")
ggsave(filename=paste(fdir, "BulletBarChart.png", sep="/"))



#Pie chart
data <- textConnection("Category\tValue
Category A	5
Category B	4
Category C	3
Category D	2
Category E	1
")
data <- read.table(data, sep="\t", h=T)

p <- ggplot(aes(x=factor(1), fill=Category, weight=Value), data=data)
p + geom_bar(width = 1) +
  coord_polar(theta="y") +
  xlab("X Label") + 
  ylab("Y Label") +
  scale_fill_discrete("Legend Title") +
  opts(title="An Example Pie Chart")
ggsave(filename=paste(fdir, "PieChart.png", sep="/"))

#Highlighted Pie
p <- ggplot(aes(x=factor(1), colour=Category, fill=ifelse(Category=="Category B", "blue", "grey"),
                weight=Value), data=data)
p + geom_bar(width = 1) +
  coord_polar(theta="y") +
  scale_fill_identity("Legend Title") +
  xlab("X Label") + 
  ylab("Y Label") +
  opts(title="An Example Pie Chart w/ Highlighted Piece")
ggsave(filename=paste(fdir, "HighLightedPie.png", sep="/"))


#Scatter plot
data <- textConnection("Month\tSeries 1\tSeries 2	Series 3	Series 4
Jan	7.41	9.38	5.52	6.25
Feb	5.74	8.27	7.29	3.39
Mar	6.52	5.42	7.51	6.20
Apr	2.02	0.70	0.24	1.88
May	7.90	0.35	9.99	6.84
Jun	3.22	8.01	0.91	1.61
Jul	1.43	8.54	8.08	7.62
Aug	9.80	7.79	8.71	8.21
Sep	2.36	8.17	5.70	4.48
Oct	4.39	9.71	7.19	4.96
Nov	3.24	0.26	7.65	1.37
Dec	8.44	7.78	9.44	3.65
")
data <- read.table(data, sep="\t", h=T)
data$Month <- factor(data$Month, data$Month)

p <- ggplot(aes(x=Series.1, y=Series.2), data=data)
p + geom_point() +
  xlab("X Label") + 
  ylab("Y Label") +
  opts(title="An Example Scatter Plot")
ggsave(filename=paste(fdir, "Scatterplot.png", sep="/"))


# Stacked column chart w/ volume
data <- textConnection("Month\tItem A	Item B	Item C	Negative Item D
Jan	0.08	0.51	1.31	-1.90
Feb	1.00	1.32	1.18	-1.61
Mar	1.71	1.95	1.02	-1.56
Apr	2.08	2.02	1.53	-1.66
May	2.25	2.10	1.18	-1.57
Jun	2.99	2.62	1.30	-1.10
Jul	3.02	3.24	1.57	-1.75
Aug	3.50	4.09	1.46	-1.05
Sep	3.72	4.90	1.49	-1.46
Oct	4.54	5.11	1.07	-1.58
Nov	5.16	5.85	1.73	-1.98
Dec	5.57	6.74	1.93	-1.73
")
data <- read.table(data, sep="\t", h=T)
data$Month <- factor(data$Month, data$Month)
data.lng <- melt(data, id=1)

p <- ggplot(aes(x=Month, weight=value, fill=variable),
            data=subset(data.lng, variable!="Negative.Item.D"))
p + geom_bar() +
  geom_bar(aes(x=Month, ymin=-value, ymax=0), subset(data.lng, variable=="Negative.Item.D")) +
  geom_line(aes(x=Month, y=value, fill="Total", group=1),
            data=aggregate(value ~ Month, data=data.lng, sum)) +
  xlab("X Label") + 
  ylab("Y Label") +
#   scale_fill_continuous("Legend Title") + 
  opts(title="An Example Stacked column chart w/ volume")
ggsave(filename=paste(fdir, "StackedVolumeChartwLine.png", sep="/"))


data <- textConnection("Stage\tValue	Change
Start	100	
Step 1	80	20
Step 2	70	10
Step 3	62	8
Step 4	52	10
Final result\t52\t
")

data <- read.table(data, sep="\t", h=T)
data$Stage <- factor(data$Stage, data$Stage)
data

p <- ggplot(aes(ymin=Value, ymax=Value-Change), data=data)
p + geom_rect() +
  xlab("X Label") + 
  ylab("Y Label") +
  opts(title="Chart Title")


data <- textConnection("Month\tSeries 1	Series 2
Jan	0.17	5.60
Feb	0.95	8.52
Mar	1.56	8.74
Apr	2.09	1.08
May	2.69	5.54
Jun	2.73	3.03
Jul	3.49	6.00
Aug	3.65	5.78
Sep	4.01	4.32
Oct	4.57	7.56
Nov	5.45	5.90
Dec	6.16	2.43
")

data <- read.table(data, sep="\t", h=T)
data$Month <- factor(data$Month, data$Month)
data

p <- ggplot()
p + geom_bar(aes(x=Month, weight=Series.1), data=data) +
  geom_line(aes(x=Month, y=Series.2, group=1), colour="blue", data=data) +
  xlab("X Label") + 
  ylab("Y Label") +
  opts(title="Chart Title")
ggsave(filename=paste(fdir, "ColumnAndLine.png", sep="/"))


#Bubble Chart
data <- textConnection("  Series 1	Series 2	Value
Jan	3.9543031342	3.9562676987	4.1058940301
Feb	9.9728079932	2.9912424739	7.7609955473
Mar	2.9840194434	3.8122830028	9.0522239916
Apr	2.4148084549	3.0404574145	0.7286977116
May	5.685720793	0.9677886777	7.222444592
Jun	9.9094119668	5.6243130472	7.6263150014
Jul	7.4870035704	7.8294275608	5.4762881855
Aug	4.0690666856	9.1890754923	9.9755757954
Sep	8.8038171316	0.7918713801	9.5024713082
Oct	5.7545989705	8.982290877	8.0353516852
Nov	7.5449426472	5.3628405277	0.155836856
Dec	7.8511308506	3.2607904961	9.1500398843
")

data <- read.table(data, sep="\t", h=T)
data$Month <- factor(data$Month, data$Month)
data

p <- ggplot(aes(x=Series.1, y=Series.2, size=Value, colour="blue"), data=data)
p + geom_point() +
  scale_colour_identity() +
  scale_size_continuous('Legend Title', range = c(0, 20)) +
  xlab("X Label") + 
  ylab("Y Label") +
  opts(title="An Example Bubble Chart")
ggsave(filename=paste(fdir, "BubbleChart.png", sep="/"))



