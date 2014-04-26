library(reshape)
library(ggplot2)
library(scales)
library(GGally)
library(shiny)
library(plyr)

data(Seatbelts)
df <- data.frame(Seatbelts)
t <- seq(as.Date("1969/1/1"), by = "month", length.out = 12*16)
m <- factor(months(t), levels = months(t)[seq(1,12)])
y <- factor(as.POSIXlt(t)$year + 1900)
m <- m
fraction <- rep(seq(0,11),16)/12
t <- as.POSIXlt(t)$year + 1900+fraction
df['Month'] <- m
df['Year'] <- y
df['Time'] <- t
names(df) <- c('Car Drivers Killed Only', 'Car Drivers', 'Front-seat Passengers',
               'Rear-seat Passengers', 'Distance Driven', 'Petrol Price', 'Van Drivers Killed', 
               'Law Enacted', 'Month', 'Year', 'Time')


getPlot2 <- function(df, column = 'Car Drivers Killed Only', time_range = c(1969,1984), 
                     highlight1 = 1983, highlight2 = 1982){
  
  start = time_range[1]
  end = time_range[2]
  #print(start)
  #print(end)
  #print(as.numeric(highlight1))
  #print(as.numeric(highlight2))
  
  df_melt3 <- melt(df, id = c("Year", 'Month'))
  #print(df_melt[1,])
  df_melt4 <- df_melt3[which(df_melt3$variable == column),]
  df_melt4$value <- as.numeric(df_melt4$value)
  df_melt4 <- df_melt4[which(df_melt4$Year %in% seq(start,end)),]
  
  ymin <- 0
  ymax <- max(round_any(df_melt4$value, 100, f = ceiling))
  
  
  
  palette <- c('grey30','grey30','grey30','grey30','grey30','grey30','grey30','grey30',
               'grey30','grey30','grey30','grey30','grey30','grey30','grey30','grey30')
  palette[as.numeric(highlight1)-start+1] <- 'red'
  palette[as.numeric(highlight2)-start+1] <- 'orange'
  
  alphas <- rep
  alphas[as.numeric(highlight1)-start+1] <- 1.0
  alphas[as.numeric(highlight2)-start+1] <- 1.0
  
  p <- ggplot(df_melt4, aes(x=Month , y=value, group = Year, color = Year))
  
  p <- p + geom_line(size = 1, alpha = alphas)
  
  p <- p + scale_x_discrete(
    #limits = range(xmin,xmax),
    expand = c(0, 0.2))#,
    #breaks = seq(round(xmin), round(xmax)))
  
  p <- p + scale_y_continuous(
    limits = c(ymin, ymax+300),
    expand = c(0, 0),
    breaks = seq(0, ymax, round_any((ymax/10),100, f = ceiling)))
  
  p <- p + theme(axis.title = element_blank())
  
  p <- p + theme_minimal()
  p <- p + theme(panel.border = element_blank())
  p <- p + theme(axis.title = element_blank())
  
  p <- p + theme(panel.grid = element_line(color = 'grey90', linetype = 3))
  
  p <- p + theme(
    #legend.text = element_text(
    #colour = "white",
    #face = "bold"),
    legend.title = element_blank(),
    legend.background = element_blank(),
    legend.direction = "horizontal", 
    legend.position = c(.5, .925),
    legend.justification = c(.5, .5))#,
  #legend.key = element_rect(
  # fill = NA,
  # colour = "white",
  # size = 1))
  p <- p + scale_color_manual(values = palette)
  
  return(p)
}

plotOverview <- function(df, series, time_range){#start = 1969, num = 12) {
  
  #print(series)
  #print(time_range)
  
  start = time_range[1]
  end = time_range[2]
  
  
  df_melt <- melt(df, id = "Time")
  #print(df_melt[1,])
  if(length(series) > 0){
  df_melt2 <- df_melt[which(df_melt$variable %in% series),]
  df_melt2$value <- as.numeric(df_melt2$value)
  }
  else{
    series = c('Car Drivers Killed Only', 'Car Drivers', 'Front-seat Passengers',
               'Rear-seat Passengers', 'Van Drivers Killed')
    df_melt2 <- df_melt[which(df_melt$variable %in% series),]
    df_melt2$value <- as.numeric(df_melt2$value)
  }
  #num=12
  #start=1969
  
  xmin <- start
  xmax <- end
  
  ymin <- -5
  ymax <- max(round_any(df_melt2$value, 100, f = ceiling))
  
  p <- ggplot(df_melt2, aes(x = Time, y = value, group = variable))
  
  p <- p + geom_rect(
    xmin = xmin, xmax = xmax,
    ymin = ymin, ymax = ymax,
    fill = 'grey')
  
  p <- p + geom_line()
  
  p <- p + scale_x_continuous(
   limits = range(1969,1985),
   expand = c(0, 0),
   breaks = seq(1969, 1985, by = 2))
  
  p <- p + scale_y_continuous(
    limits = c(ymin, ymax),
    expand = c(0, 0),
    breaks = seq(0, ymax, round_any((ymax/10),100, f = ceiling)))
  
  p <- p + theme(panel.border = element_rect(
    fill = NA, colour = 'grey'))
  
  p <- p + theme(axis.title = element_blank())
  p <- p + theme(panel.grid = element_blank())
  p <- p + theme(axis.ticks.y = element_blank())
  p <- p + theme(axis.text.y = element_blank())
  p <- p + theme(panel.background = element_blank())
  p <- p + theme(panel.border = element_blank())
  
  return(p)
}

getPlot1 <- function(df, series, time_range){ #start = 1969, num = 12) {
  
  #print(series)
  #print(time_range)
  
  start = time_range[1]
  end = time_range[2]
  
  df_melt <- melt(df, id = "Time")
  if(length(series) > 0){
    df_melt2 <- df_melt[which(df_melt$variable %in% series),]
    df_melt2$value <- as.numeric(df_melt2$value)
  }
  else{
    series = c('Car Drivers Killed Only', 'Car Drivers', 'Front-seat Passengers',
               'Rear-seat Passengers', 'Van Drivers Killed')
    df_melt2 <- df_melt[which(df_melt$variable %in% series),]
    df_melt2$value <- as.numeric(df_melt2$value)
  }
  #print(df_melt2[1,])
  xmin <- start
  xmax <- end
  
  ymin <- 0
  ymax <- max(round_any(df_melt2$value, 100, f = ceiling))
  

  palette <- c('Car Drivers Killed Only' = '#e41a1c', 'Car Drivers' = '#377eb8',
               'Front-seat Passengers' = '#4daf4a','Rear-seat Passengers' = '#984ea3', 
               'Van Drivers Killed' = '#ff7f00')
  palette <- palette[which(names(palette) %in% series)]
  #palette <- c('#e41a1c', '#377eb8','#4daf4a','#984ea3', '#ff7f00')
  
  p <- ggplot(
    df_melt2,
    aes(x = Time, y = value, 
        group = variable,
        color = variable))
  
  p <- p + geom_line(size = 3)
  
#   minor_breaks <- seq(
#     floor(xmin), 
#     ceiling(xmax), 
#     by = 1/ 12)
    #print(xmax)
    #print(xmin)  
  
  p <- p + scale_x_continuous(
    limits = range(xmin,xmax),
    expand = c(0, 0),
    breaks = seq(round(xmin), round(xmax)))
  
  p <- p + scale_y_continuous(
    limits = c(ymin, ymax+300),
    expand = c(0, 0),
    breaks = seq(0, ymax, round_any((ymax/10),100, f = ceiling)))
  
  p <- p + theme(axis.title = element_blank())
  
  p <- p + theme_minimal()
  p <- p + theme(panel.border = element_blank())
  p <- p + theme(axis.title = element_blank())
  
  p <- p + theme(panel.grid = element_line(color = 'grey90', linetype = 3))
  
  p <- p + theme(
    #legend.text = element_text(
      #colour = "white",
      #face = "bold"),
    legend.title = element_blank(),
    legend.background = element_blank(),
    legend.direction = "horizontal", 
    legend.position = c(.5, .90),
    legend.justification = c(.5, .5))#,
    #legend.key = element_rect(
     # fill = NA,
     # colour = "white",
     # size = 1))
  p <- p + scale_color_manual(values = palette)
  
  return(p)
}


shinyServer(function(input, output) {
  
  cat("Press \"ESC\" to exit...\n")
  
  
  
  
#   output$plot1 <- renderPlot(
# {
#   print(getplot1(df))#df, vector()))
# }, 
# width = 800,
# height = 400)
  
  
  output$plot2 <- renderPlot(
{
  print(getPlot2(df, input$column, input$time_range2, input$highlight1, input$highlight2))#df, vector()))
}, 
width = 800,
height = 400)
  
  output$mainPlot <- renderPlot({
    print(getPlot1(df, input$series, input$time_range1))#input$start, input$num))
  }, 
  width = 1000,
  height = 420)
  
  output$overviewPlot <- renderPlot({
    print(plotOverview(df, input$series, input$time_range1))#input$start, input$num))
  },
  width = 1000,
  height = 100)
  
})



