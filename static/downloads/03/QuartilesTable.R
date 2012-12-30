library(hwriter)

fdir <- "/Users/glamp/repository/blog/CactusBlog/static/img/03/large"

data <- textConnection("Name,AB,AVG,HR,BB,K
Nomar Garciaparra,305,334,12,28,17
Albert Pujols,291,330,32,57,26
Scott Hatteberg,268,321,9,43,21
Lance Berkman,335,316,26,50,64
Travis Hafner,325,311,29,72,74
Justin Morneau,337,309,25,27,60
Lyle Overbay,357,305,16,34,57
Paul Konerko,348,302,24,39,56
Nick Johnson,324,302,14,63,53
Shea Hillenbrand,296,301,12,14,40
Adrian Gonzalez,338,299,18,21,62
Jim Thome,317,297,32,61,99
Kevin Youkilis,353,289,11,60,76
Mike Jacobs,296,284,14,30,63
Todd Helton,292,284,11,59,37
Todd Walker,297,283,5,35,26
Ryan Howard,342,281,31,37,104
Doug Mientkiewicz,307,280,4,35,49
Prince Fielder,358,279,17,29,82
Michael Cuddyer,299,271,12,37,71
Chris Shelton,332,271,16,31,92
Adam LaRoche,293,270,17,33,72
Mark Teixeira,383,269,13,53,75
Conor Jackson,276,264,8,40,37
Jeff Conine,280,261,7,26,38
Nick Swisher,337,258,21,62,90
Jason Giambi,294,255,28,68,74
Carlos Delgado,336,250,24,39,84
Adam Dunn,349,246,30,73,113
Brad Wilkerson,280,239,15,37,99
Richie Sexson,361,224,19,35,99")

data <- read.csv(data, h=T)

data$Name_cell_color <- "white"
for(col in names(data[,c(-1, -7)])) {
  ntiles <- quantile(data[,c(col)], probs=c(.25, .75))
  color_col <- paste(col, "cell_color", sep="_")
  columnData <- data[,c(col)]
  data[,c(color_col)] <- ifelse(columnData<=ntiles[1], "red",
                                ifelse(columnData>=ntiles[2], "green",
                                       "white"))
}

# transpose the color columns of the data frame and convert it to a list
# goes from dataframe to matrix to dataframe to list
# see http://stackoverflow.com/questions/3492379/data-frame-rows-to-a-list
row.colours <- as.list(as.data.frame(t(data[1:nrow(data),7:12])))

hwrite(data[1:nrow(data), 1:6],
       paste(fdir, "QuartilesTable.html", sep="/"),
       center=TRUE,
       row.bgcolor=row.colours)
# full output: http://www.yaksis.com/static/img/03/large/QuartilesTable.html





