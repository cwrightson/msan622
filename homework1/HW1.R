library(ggplot2) 
library(reshape2)
data(movies) 
data(EuStockMarkets)
localpath = 'C:\\Users\\Cole\\Desktop\\Classwork\\MSAN622_Data_Vis\\HW1'
setwd(localpath)

movies1 <- movies[which(movies$budget > 0),]
genre <- rep(NA, nrow(movies))
count <- rowSums(movies[, 18:24])
genre[which(count > 1)] = "Mixed"
genre[which(count < 1)] = "None"
genre[which(count == 1 & movies$Action == 1)] = "Action"
genre[which(count == 1 & movies$Animation == 1)] = "Animation"
genre[which(count == 1 & movies$Comedy == 1)] = "Comedy"
genre[which(count == 1 & movies$Drama == 1)] = "Drama"
genre[which(count == 1 & movies$Documentary == 1)] = "Documentary"
genre[which(count == 1 & movies$Romance == 1)] = "Romance"
genre[which(count == 1 & movies$Short == 1)] = "Short"
movies1$genre <- genre[which(movies$budget > 0)]

eu <- transform(data.frame(EuStockMarkets), time = time(EuStockMarkets))

million_formatter <- function(x){
  y <- rep('',length(x))
  for(i in 1:length(x)){
    y[i] <- sprintf("$%dM", round(x[i]/1000000))
  }
  y[1] <- ''
  return(y)
}
thousand_formatter <- function(x){
  y <- rep('',length(x))
  for(i in 1:length(x)){
    y[i] <- sprintf("%.1fk", x[i]/1000)
  }
  y[1] <- ''
  return(y)
}
thousand_formatter2 <- function(x){
  y <- rep('',length(x))
  for(i in 1:length(x)){
    y[i] <- sprintf("%.0fk", x[i]/1000)
  }
  y[1] <- ''
  return(y)
}


plot1 <- ggplot(movies1, aes(x = budget, y = rating)) + geom_point(size = 3, alpha=.4, color = 'hot pink') +
  ggtitle("Movie Budget vs. Movie Rating") +
  xlab("Budget") + ylab("Rating") + scale_x_continuous(label = million_formatter) +
  scale_y_continuous(expand = c(0,0), limit = c(0,11), breaks = seq(2,10,2)) +
  theme(axis.ticks.x = element_blank())
plot1
ggsave(filename = 'hw1-scatter.png', plot = plot1, 
       scale = 1, width = par("din")[1], height = par("din")[2], units = 'in', dpi = 300)

movies1$genre <- factor(movies1$genre, levels=names(sort(table(movies1$genre), decreasing=TRUE)))
palette1 <- c('#e41a1c','#377eb8', '#4daf4a', '#984ea3', '#ff7f00', '#ffff33', '#a65628', '#f781bf', '#999999')

plot2 <- ggplot(movies1, aes(genre, fill = genre)) + 
  geom_bar(color= 'white') + ggtitle('Movie Genre Frequency') + ylab("") + xlab('') +
  theme(legend.position = "none") + theme(panel.grid.major.x = element_blank(), 
                                          panel.grid.minor.x = element_blank()) +
  scale_y_continuous(label = thousand_formatter, expand = c(0,0), limit = c(0,1900))+
  theme(legend.position = 'none') +
  theme(axis.ticks.x = element_blank()) +
  theme(axis.ticks.y = element_blank()) +
  theme(panel.grid.major.x = element_blank()) +
  theme(axis.text.x = element_text(size = 12)) +
  scale_fill_manual(values = palette1)
plot2
ggsave(filename = 'hw1-bar.png', plot = plot2, 
       scale = 1, width = par("din")[1]*1.75, height = par("din")[2]*2, units = 'in', dpi = 300)

plot3 <- ggplot(movies1, aes(x = budget, y = rating, alpha = 0.5, color= genre)) + 
  geom_point() +
  ggtitle("Movie Budget vs. Movie Rating by Genre") +
  xlab("Budget") + ylab("Rating") +
  facet_wrap(~genre, ncol = 3, scales = 'fixed') + theme(legend.position = "none") +
  scale_color_manual(values = palette1) + 
  scale_x_continuous(label = million_formatter, limit = c(0,200100000)) +
  scale_y_continuous(expand = c(0,0), limit = c(0,11), breaks = seq(2,10,2)) +
  theme(axis.ticks.x = element_blank())+
  theme(panel.grid.minor.y = element_blank())
plot3
ggsave(filename = 'hw1-multiples.png', plot = plot3, 
       scale = 1, width = par("din")[1]*1.5, height = par("din")[2]*1.3, units = 'in', dpi = 300)

palette2 <- c('#984ea3','#e41a1c', '#4daf4a', '#377eb8')
eu$time <- factor(eu$time)
eu_2 <- melt(eu, id = 'time')
plot4 <- ggplot(data=eu_2,aes(x=time, y=value, color = variable, group=variable)) + geom_line() +
  ggtitle('Selected European Stock Indexes') + labs(colour="Market Index") + 
  xlab("Year") + ylab("Index Value") +
  scale_y_continuous(label = thousand_formatter2, expand = c(0,0), 
                     limit = c(0,9000), breaks = seq(0,8700,1000))+
  theme(axis.ticks.y = element_blank())+
  theme(panel.grid.minor.y = element_blank()) +
  scale_x_discrete(breaks=seq(1991,1999)) +
  scale_color_manual(values = palette2)
plot4
ggsave(filename = 'hw1-multiline.png', plot = plot4, 
       scale = 1, width = par("din")[1], height = par("din")[2], units = 'in', dpi = 300)





