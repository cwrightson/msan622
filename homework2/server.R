library(ggplot2)
library(shiny)
library(scales)
# setwd('C:\\Users\\Cole\\Desktop\\Classwork\\MSAN622_Data_Vis\\HW2')
data(movies)
movies$mpaa <- as.character(movies$mpaa)
movies1 <- movies[which(movies$mpaa != '' & movies$budget >= 0 ),]
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
movies1$genre <- as.factor(genre[which(movies$mpaa != '' & movies$budget >= 0 )])

million_formatter <- function(x){
  y <- rep('',length(x))
  for(i in 1:length(x)){
    y[i] <- sprintf("$%.0fM", round(x[i]/1000000))
  }
  if(x[1] == 0 | is.na(x[1])){y[1] <- ''}
  return(y)
}

capitalize <- function(text) { return(paste(toupper(substring(text, 1, 1)), substring(text, 2), sep = "")) }

getPlot <- function(movies1,highlight, genres, colorScheme = 'Default', 
                    dotSize = 5, alphaSize = .6, sortOrder, budget_range, 
                    rating_range, titles_on = 'Off') {
  
  genres_sel <- levels(movies1$genre)
  if(highlight == 'All'){
    highlight_a <- c('PG','PG-13','R','NC-17')
  }
  else{
    highlight_a = highlight
  }
  
  movies1$mpaa <- factor(movies1$mpaa, levels = levels(as.factor(movies1$mpaa))[c(2,3,4,1)])
  mpaa <- levels(movies1$mpaa)
  

  movies1 <- movies1[sortOrder,]

  if(length(genres)>0 ){
    movies2 <- movies1[which(movies1$genre %in% genres),]

  }
  else{
    movies2 <- movies1
  }

  movies_plot_first <- movies2[which(!movies2$mpaa %in% highlight_a),]
  movies_plot_first <- movies2[1,]
  movies_plot_last <- movies2[which(movies2$mpaa %in% highlight_a),]

  palette <- c('#d7b5d8', '#df65b0','#dd1c77','#980043')

  
  if(titles_on == 'On'){
    p <- ggplot(movies2, aes(x = budget, y = rating, color = mpaa, label=title))
    if(length(movies2$budget[which(movies2$budget > budget_range[1] &
                                     movies2$budget < budget_range[2] &
                                     movies2$rating > rating_range[1] &
                                     movies2$rating < rating_range[2])]) < 1){
      p <- p + geom_point(size = dotSize, alpha = alphaSize)
    }
    else{
    p <- p + geom_text(position = position_jitter(w = 1000000, h = 0.3),
                       size = dotSize, alpha = alphaSize)
    }
  }
  else{
    p <- ggplot(movies2, aes(x = budget, y = rating, color = mpaa))
    p <- p + geom_point(size = dotSize, alpha = alphaSize)
  }
  p <- p + ggtitle("Movie Budget vs. Movie Rating by Genre")
  p <- p + xlab("Budget")
  p <- p + ylab("Rating")
  if(rating_range[1] > 0){
    p <- p + scale_y_continuous(expand = c(0,1), limit = rating_range)
  }
  else{
    p <- p + scale_y_continuous(expand = c(0,0), limit = rating_range)
  }
  p <- p + scale_x_continuous(label = million_formatter, limit = budget_range)

  p <- p + theme(axis.ticks.x = element_blank())
  
  p <- p + labs(color = "MPAA Rating")
  
  p <- p + theme(panel.background = element_rect(fill = NA))
  p <- p + theme(legend.key = element_rect(fill = NA))

  p <- p + theme(panel.grid.major = element_line(color = "grey90"))
  p <- p + theme(panel.grid.minor = element_line(color = "grey90", linetype = 3))
  

  p <- p + theme(panel.border = element_blank())
  
  p <- p + theme(legend.direction = "horizontal")
  p <- p + theme(legend.justification = c(0, 0))
  p <- p + theme(legend.position = c(0, 0))
  p <- p + theme(legend.background = element_blank())
    
  
  if(colorScheme != 'Default'){
    palette <- brewer_pal(type = "qual", palette = colorScheme)(4)
  }

  if(highlight != 'All'){
    palette[which(!mpaa %in% highlight)] <- "#EEEEEE"
  }

  
  palette <- palette[which(mpaa %in% unique(movies2$mpaa))]
  p <- p + scale_color_manual(values = palette, labels = mpaa)

  return(p)
}

shinyServer(function(input, output) {
  
  cat("Press \"ESC\" to exit...\n")
  
  sortOrder <- reactive(
    {
      if(input$highlight!='All'){      
      first_datas <- which(movies1$mpaa != input$highlight)
      last_datas <- which(movies1$mpaa == input$highlight)
      desired_order <- append(first_datas,last_datas)
      
      return(desired_order)
      }
      else{
        desired_order <- order(movies1$mpaa)
        return(desired_order)
      }
    }
  )

  output$scatterplot <- renderPlot(
{
  print(getPlot(movies1, input$highlight,input$genres, input$colorScheme, 
                input$dotSize, input$alphaSize,sortOrder(), input$budget_range, 
                input$rating_range, input$titles_on))
}, 
width = 600,
height = 600)
})