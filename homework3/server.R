library(reshape)
library(ggplot2)
library(scales)
library(GGally)
library(shiny)
library(plyr)

#setwd('C:\\Users\\Cole\\Desktop\\Classwork\\MSAN622_Data_Vis\\HW3')

data(state)
df <- data.frame(state.x77,
                 State = state.name,
                 Abbrev = state.abb,
                 Region = state.region,
                 Division = state.division
)

processData <- function(original) {
  # copy original dataset
  processed <- original
  
  # fix column names (replaces period with space)
  colnames(processed) <- gsub("\\.", " ", colnames(processed))
  
  # discard non-numeric data (optional)
  processed <- processed[sapply(processed, is.numeric)]
  
  # rescale all the values to [0, 1]
  processed <- rescaler(processed, type = "range")
  
  # melt dataset (convert from wide to long format)
  processed$id <- 1:nrow(original)
  processed <- melt(processed, "id")
  
  # convert id column into factor for sorting later
  processed$id <- factor(processed$id,
                         levels = 1:nrow(original), 
                         ordered = TRUE)
  
  return(processed)
}


getBubbleplot <- function(dataset, vector){#xaxis = "Income", yaxis = "Life Exp", 
                          #dotSize = "Population", colorBy = "Region") {
  
  choices <- gsub("\\.", " ", colnames(df))
  vars <- seq(1,12)
  xaxis <- vars[which(choices %in% vector[1][[1]])]
  yaxis <- vars[which(choices %in% vector[2][[1]])]
  colorBy <- vars[which(choices %in% vector[3][[1]])]
  dotSize <- vars[which(choices %in% vector[4][[1]])]
  highlights <- vector[6][[1]]
  
  #print(colorBy)
  #print(highlights)
  
  palette <- c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00', 
               '#ffff33', '#a65628', '#f781bf', '#999999')
  
  if(colorBy == 11){
    palette <- c('#e41a1c', '#e41a1c', '#377eb8', '#377eb8', '#377eb8', 
                 '#4daf4a', '#4daf4a', '#984ea3', '#984ea3')
  }
  
  palette[!seq(1,9) %in% highlights] <- 'grey70'
  
#   print(xaxis)
#   print(yaxis)
#   print(colorBy)
#   print(dotSize)
#   xaxis <- vector[1][[1]]
#   yaxis <- vector[2][[1]]
  #  colorBy <- 12
#   dotSize <- vector[4][[1]]
  df2 <- data.frame('x2' = df[,xaxis], 'y2' = df[,yaxis], 'z2' = df[,dotSize], 'color2' = df[,12])
  
  # Create bubble plot
  p <- ggplot(df2, aes(
    x = x2,
    y = y2,
    color = color2,
    size = z2))
  
  # Give points some alpha to help with overlap/density
  # Can also "jitter" to reduce overlap but reduce accuracy
  p <- p + geom_point(alpha = 0.6)#, position = "jitter")
  
  # Default size scale is by radius, force to scale by area instead
  # Optionally disable legends
  p <- p + scale_size_area(guide = "none")
  p <- p + theme(panel.background = element_rect(fill = NA))
  # p <- p + scale_color_discrete(guide = "none")
  
  # # Tweak the plot limits
  # p <- p + scale_x_continuous(
  #   #limits = c(3, 9),
  #   expand = c(.1, 0))
  # 
  # p <- p + scale_y_continuous(
  #   #limits = c(1, 5),
  #   expand = c(.1, 0))
  
  # Make the grid square
  #p <- p + coord_fixed(ratio = 500/1)
  
  # Modify the labels
  #p <- p + ggtitle("States Dataset")
  p <- p + labs(
    size = names(df)[dotSize],
    color = names(df)[colorBy],
    x = names(df)[xaxis],
    y = names(df)[yaxis])
  
  # Modify the legend settings
  p <- p + theme(legend.position="none")
 #p <- p + theme(legend.margin = unit(0, "pt"))
  
  # Force the dots to plot larger in legend
  #p <- p + guides(colour = guide_legend(override.aes = list(size = 8)))
  
  #Color
  p <- p + scale_color_manual(values = palette)
  
  # Indicate size is petal length
  # p <- p + annotate(
  #   "text", x = 6, y = 4.8,
  #   hjust = 0.5, color = "grey40",
  #   label = "Circle area is proportional to population size.")
  
return(p)
  
  
}


# getHeatmap <- function(dataset, midrange) {
#   # create base heatmap
#   p <- ggplot(dataset, aes(x = id, y = variable))
#   p <- p + geom_tile(aes(fill = value), colour = "white")
#   p <- p + theme_minimal()
#   
#   # turn y-axis text 90 degrees (optional, saves space)
#   p <- p + theme(axis.text.y = element_text(angle = 90, hjust = 0.5))
#   
#   # remove axis titles, tick marks, and grid
#   p <- p + theme(axis.title = element_blank())
#   p <- p + theme(axis.ticks = element_blank())
#   p <- p + theme(panel.grid = element_blank())
#   
#   # remove legend (since data is scaled anyway)
#   p <- p + theme(legend.position = "none")
#   
#   # remove padding around grey plot area
#   p <- p + scale_x_discrete(expand = c(0, 0))
#   p <- p + scale_y_discrete(expand = c(0, 0))    
#   
#   # optionally remove row labels (not useful depending on dataset)
#   p <- p + theme(axis.text.x = element_blank())
#   
#   # get diverging color scale from colorbrewer
#   # #008837 is green, #7b3294 is purple
#   palette <- c("#008837", "#f7f7f7", "#f7f7f7", "#7b3294")
#   
#   if(midrange[1] == midrange[2]) {
#     # use a 3 color gradient instead
#     p <- p + scale_fill_gradient2(low = palette[1], mid = palette[2], high = palette[4], midpoint = midrange[1])
#   }
#   else {
#     # use a 4 color gradient (with a swath of white in the middle)
#     p <- p + scale_fill_gradientn(colours = palette, values = c(0, midrange[1], midrange[2], 1))
#   }
#   
#   return(p)
# }



getScatterplot <- function(dataset, vector){#columns_wanted = c(1:8), colorBy = 12) {
  columns_wanted = vector[5][[1]]
  colorBy = vector[3][[1]]
  highlights <- vector[6][[1]]
  
  #print(colorBy)
  #print(highlights)
  
  palette <- c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00', 
               '#ffff33', '#a65628', '#f781bf', '#999999')
  
  if(colorBy == 'Region'){
    palette <- c('#e41a1c', '#e41a1c', '#377eb8', '#377eb8', '#377eb8', 
                 '#4daf4a', '#4daf4a', '#984ea3', '#984ea3')
  }
  
  palette[!seq(1,9) %in% highlights] <- 'grey70'
  
  p <- ggpairs(dataset, 
               # Columns to include in the matrix
               columns = columns_wanted,
               
               # What to include above diagonal
               # list(continuous = "points") to mirror
               # "blank" to turn off
               upper = "blank",
               
               # What to include below diagonal
               lower = list(continuous = "points"),
               
               # What to include in the diagonal
               diag = list(continuous = "density"),
               
               # How to label inner plots
               # internal, none, show
               axisLabels = "none",
               
               # Other aes() parameters
               colour = 'Division',
               #title = "States Scatterplot Matrix"
  ) 
  
  # Remove grid from plots along diagonal
  for (i in 1:length(columns_wanted)){
    # Get plot out of matrix
    inner = getPlot(p, i, i);
    
    # Add any ggplot2 settings you want
    inner = inner + theme(panel.grid = element_blank()) + 
      theme(panel.background = element_rect(fill = NA)) +
      scale_color_manual(values = palette);
    
    # Put it back into the matrix
    p <- putPlot(p, inner, i, i);
  }
  
  for (i in 1:(length(columns_wanted))){
    for( j in 1:(length(columns_wanted))){
      if(j < i){
        # Get plot out of matrix
        inner = getPlot(p, i, j);
        
        # Add any ggplot2 settings you want
        inner = inner + theme(panel.background = element_rect(fill = NA)) +
          scale_color_manual(values = palette);
        
        # Put it back into the matrix
        p <- putPlot(p, inner, i, j);
      }
    }
  }
  
  # Show the plot
  return(p)
  
}



# getScatterplot <- function(movies1,highlight, genres, colorScheme = 'Default', 
#                     dotSize = 5, alphaSize = .6, sortOrder, budget_range, 
#                     rating_range, titles_on = 'Off') {
#   
#   genres_sel <- levels(movies1$genre)
#   if(highlight == 'All'){
#     highlight_a <- c('PG','PG-13','R','NC-17')
#   }
#   else{
#     highlight_a = highlight
#   }
#   
#   movies1$mpaa <- factor(movies1$mpaa, levels = levels(as.factor(movies1$mpaa))[c(2,3,4,1)])
#   mpaa <- levels(movies1$mpaa)
#   
#   
#   movies1 <- movies1[sortOrder,]
#   
#   if(length(genres)>0 ){
#     movies2 <- movies1[which(movies1$genre %in% genres),]
#     
#   }
#   else{
#     movies2 <- movies1
#   }
#   
#   movies_plot_first <- movies2[which(!movies2$mpaa %in% highlight_a),]
#   movies_plot_first <- movies2[1,]
#   movies_plot_last <- movies2[which(movies2$mpaa %in% highlight_a),]
#   
#   palette <- c('#d7b5d8', '#df65b0','#dd1c77','#980043')
#   
#   
#   if(titles_on == 'On'){
#     p <- ggplot(movies2, aes(x = budget, y = rating, color = mpaa, label=title))
#     if(length(movies2$budget[which(movies2$budget > budget_range[1] &
#                                      movies2$budget < budget_range[2] &
#                                      movies2$rating > rating_range[1] &
#                                      movies2$rating < rating_range[2])]) < 1){
#       p <- p + geom_point(size = dotSize, alpha = alphaSize)
#     }
#     else{
#       p <- p + geom_text(position = position_jitter(w = 1000000, h = 0.3),
#                          size = dotSize, alpha = alphaSize)
#     }
#   }
#   else{
#     p <- ggplot(movies2, aes(x = budget, y = rating, color = mpaa))
#     p <- p + geom_point(size = dotSize, alpha = alphaSize)
#   }
#   p <- p + ggtitle("Movie Budget vs. Movie Rating by Genre")
#   p <- p + xlab("Budget")
#   p <- p + ylab("Rating")
#   if(rating_range[1] > 0){
#     p <- p + scale_y_continuous(expand = c(0,1), limit = rating_range)
#   }
#   else{
#     p <- p + scale_y_continuous(expand = c(0,0), limit = rating_range)
#   }
#   p <- p + scale_x_continuous(label = million_formatter, limit = budget_range)
#   
#   p <- p + theme(axis.ticks.x = element_blank())
#   
#   p <- p + labs(color = "MPAA Rating")
#   
#   p <- p + theme(panel.background = element_rect(fill = NA))
#   p <- p + theme(legend.key = element_rect(fill = NA))
#   
#   p <- p + theme(panel.grid.major = element_line(color = "grey90"))
#   p <- p + theme(panel.grid.minor = element_line(color = "grey90", linetype = 3))
#   
#   
#   p <- p + theme(panel.border = element_blank())
#   
#   p <- p + theme(legend.direction = "horizontal")
#   p <- p + theme(legend.justification = c(0, 0))
#   p <- p + theme(legend.position = c(0, 0))
#   p <- p + theme(legend.background = element_blank())
#   
#   
#   if(colorScheme != 'Default'){
#     palette <- brewer_pal(type = "qual", palette = colorScheme)(4)
#   }
#   
#   if(highlight != 'All'){
#     palette[which(!mpaa %in% highlight)] <- "#EEEEEE"
#   }
#   
#   
#   palette <- palette[which(mpaa %in% unique(movies2$mpaa))]
#   p <- p + scale_color_manual(values = palette, labels = mpaa)
#   
#   return(p)
# }


getParallelcoords <- function(dataset, vector){#columns_wanted = c(1:8), colorBy = 12) {
  columns_wanted = vector[5][[1]]
  vars <- seq(1,12)
  choices <- gsub("\\.", " ", colnames(df))
  colorBy <- vars[which(choices %in% vector[3][[1]])]
  highlights <- vector[6][[1]]
  
  #print(colorBy)
  #print(highlights)
  
  palette <- c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00', 
               '#ffff33', '#a65628', '#f781bf', '#999999')
  
  if(colorBy == 11){
    palette <- c('#e41a1c', '#e41a1c', '#377eb8', '#377eb8', '#377eb8', 
                 '#4daf4a', '#4daf4a', '#984ea3', '#984ea3')
  }
  
  palette[!seq(1,9) %in% highlights] <- 'grey70'
  
  #print(palette)
  
  p <- ggparcoord(data = dataset, 
                  
                  # Which columns to use in the plot
                  columns = columns_wanted, 
                  
                  # Which column to use for coloring data
                  groupColumn = "Division", 
                  
                  # Allows order of vertical bars to be modified
                  order = "allClass",
                  
                  # Do not show points
                  showPoints = FALSE,
                  
                  # Turn on alpha blending for dense plots
                  alphaLines = 0.4,
                  
                  # Turn off box shading range
                  shadeBox = NULL,
                  
                  # Will normalize each column's values to [0, 1]
                  scale = "uniminmax", # try "std" also
                  
                  mapping = aes(size = 2)
  )
  
  # Start with a basic theme
  p <- p + theme_minimal()
  
  #flip axes?
  p <- p + coord_flip()
  
  # Decrease amount of margin around x, y values
  p <- p + scale_y_continuous(expand = c(0.02, 0.02))
  p <- p + scale_x_discrete(expand = c(0.02, 0.02))
  
  # Remove axis ticks and labels
  #p <- p + theme(axis.ticks = element_blank())
  p <- p + theme(axis.title = element_blank())
  #p <- p + theme(axis.text.y = element_blank())
  p <- p + theme(axis.text = element_text(size = 18))
  p <- p + theme(legend.title = element_text(size = 18))
  
  # Clear axis lines
  p <- p + theme(panel.grid.minor = element_blank())
  p <- p + theme(panel.grid.major.y = element_blank())
  
  # Darken vertical lines
  p <- p + theme(panel.grid.major.x = element_line(color = "#bbbbbb"))
  
  # Move label to bottom
  p <- p + theme(legend.position = "bottom")
  
  #color palette
  p <- p + scale_color_manual(values = palette)
  
  # Figure out y-axis range after GGally scales the data
  min_y <- min(p$data$value)
  max_y <- max(p$data$value)
  pad_y <- (max_y - min_y) * 0.1
  
  # Calculate label positions for each veritcal bar
  lab_x <- rep(1:length(columns_wanted), times = 2) # 2 times, 1 for min 1 for max
  lab_y <- rep(c(min_y - pad_y, max_y + pad_y), each = length(columns_wanted))
  
  # Get min and max values from original dataset
  lab_z <- c(sapply(df[, columns_wanted], min), sapply(df[, columns_wanted], max))
  
  # Convert to character for use as labels
  lab_z <- as.character(lab_z)
  
  # Add labels to plot
  #p <- p + annotate("text", x = lab_x, y = lab_y, label = lab_z, size = 6)
  p <- p + theme(legend.text = element_text(size = 18))
  p <- p + theme(legend.position="none")
  # Display parallel coordinate plot
  return(p)

}

getLegend <- function(dataset, vector){
  columns_wanted = vector[5][[1]]
  vars <- seq(1,12)
  choices <- gsub("\\.", " ", colnames(df))
  colorBy <- vars[which(choices %in% vector[3][[1]])]
  highlights <- vector[6][[1]]
  
  #print(colorBy)
  #print(highlights)
  
  palette <- c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00', 
               '#ffff33', '#a65628', '#f781bf', '#999999')
  
  if(colorBy == 11){
    palette <- c('#e41a1c', '#e41a1c', '#377eb8', '#377eb8', '#377eb8', 
                 '#4daf4a', '#4daf4a', '#984ea3', '#984ea3')
  }
  
  palette[!seq(1,9) %in% highlights] <- 'grey70'
  
  #print(palette)
  
  p <- ggparcoord(data = dataset, 
                  
                  # Which columns to use in the plot
                  columns = columns_wanted, 
                  
                  # Which column to use for coloring data
                  groupColumn = "Division", 
                  
                  # Allows order of vertical bars to be modified
                  order = "allClass",
                  
                  # Do not show points
                  showPoints = FALSE,
                  
                  # Turn on alpha blending for dense plots
                  alphaLines = 0.4,
                  
                  # Turn off box shading range
                  shadeBox = NULL,
                  
                  # Will normalize each column's values to [0, 1]
                  scale = "uniminmax", # try "std" also
                  
                  mapping = aes(size = 2)
  )
  
  # Start with a basic theme
  p <- p + theme_minimal()
  
#   #flip axes?
#   p <- p + coord_flip()
#   
#   # Decrease amount of margin around x, y values
#   p <- p + scale_y_continuous(expand = c(0.02, 0.02))
#   p <- p + scale_x_discrete(expand = c(0.02, 0.02))
#   
  # Remove axis ticks and labels
  #p <- p + theme(axis.ticks = element_blank())
  p <- p + theme(axis.title = element_blank())
  #p <- p + theme(axis.text.y = element_blank())
  p <- p + theme(axis.text = element_text(size = 18))
  p <- p + theme(legend.title = element_text(size = 18))
  
  # Clear axis lines
  p <- p + theme(panel.grid = element_blank())
  p <- p + theme(panel.background = element_blank())
  p <- p + theme(panel.border = element_blank())
  
  # Darken vertical lines
  #p <- p + theme(panel.grid.major.x = element_line(color = "#bbbbbb"))
  
  # Move label to bottom
  p <- p + theme(legend.position = "bottom")
  
  #color palette
  p <- p + scale_color_manual(values = palette)
#   
#   # Figure out y-axis range after GGally scales the data
#   min_y <- min(p$data$value)
#   max_y <- max(p$data$value)
#   pad_y <- (max_y - min_y) * 0.1
#   
#   # Calculate label positions for each veritcal bar
#   lab_x <- rep(1:length(columns_wanted), times = 2) # 2 times, 1 for min 1 for max
#   lab_y <- rep(c(min_y - pad_y, max_y + pad_y), each = length(columns_wanted))
#   
#   # Get min and max values from original dataset
#   lab_z <- c(sapply(df[, columns_wanted], min), sapply(df[, columns_wanted], max))
#   
#   # Convert to character for use as labels
#   lab_z <- as.character(lab_z)
#   
#   # Add labels to plot
#   p <- p + annotate("text", x = lab_x, y = lab_y, label = lab_z, size = 6)
  p <- p + theme(legend.text = element_text(size = 12))
  p <- p + theme(axis.line  = element_blank())
  p <- p + theme(axis.text = element_blank())
  p <- p + theme(axis.ticks = element_blank())
  p <- p + theme(legend.title = element_blank())
  # Make the grid square
  p <- p + coord_fixed(ratio = 1/1000)
  
  return(p)
}


sortMelted <- function(original, melted, sort1){#}, sort2) {
  # get sort order of original dataset
  sortOrder <- order(original[[sort1]])#, original[[sort2]])
  
  # sort melted dataframe by modifying factor levels
  melted$id <- factor(melted$id,
                      levels = sortOrder, 
                      ordered = TRUE)
  
  return(melted)
}

melted <- processData(df)

shinyServer(function(input, output) {
  
  cat("Press \"ESC\" to exit...\n")
  
#   sortOrder <- reactive(
# {
#   if(input$highlight!='All'){      
#     first_datas <- which(movies1$mpaa != input$highlight)
#     last_datas <- which(movies1$mpaa == input$highlight)
#     desired_order <- append(first_datas,last_datas)
#     
#     return(desired_order)
#   }
#   else{
#     desired_order <- order(movies1$mpaa)
#     return(desired_order)
#   }
# }
#   )
  choices <- gsub("\\.", " ", colnames(state.x77))
  
  vector <- reactive({
    vars <- seq(1,8)
    vars <- vars[which(choices %in% input$variables)]
    if(length(vars) < 1){
      vars <- seq(1:8)
    }
    
    greyed <- c("New England (Northeast)", "Middle Atlantic (Northeast)",
                "South Atlantic (South)", "East South Central (South)", "West South Central (South)",
                "East North Central (North Central)", "West North Central (North Central)",
                "Mountain (West)", "Pacific (West)")
    vars2 <- seq(1,9)
    vars2 <- vars2[which(greyed %in% input$greys)]
    if(length(vars2) < 1){
      vars2 <- seq(1:9)
    }
    return(c(input$xAxisBy, input$yAxisBy, input$colorBy, input$zAxisBy, list(vars), list(vars2)))
  })
#   reorderRows <- reactive({
#     index1 <- which(choices == input$sort1)
#     #index2 <- which(choices == input$sort2)
#     
#     local <- sortMelted(df, melted, index1)#, index2)
#     return(local)
#   })
  
  output$bubbleplot <- renderPlot(
{
  print(getBubbleplot(df, vector()))#, input$xAxisBy, input$yAxisBy, input$zAxisBy, input$colorBy))
}, 
width = 800,
height = 500)
  
  
#   output$heatmap <- renderPlot({
#     
#     print(getHeatmap(reorderRows(), input$range))
#   }, 
# width = 1250,
# height = 400)
  
  output$scatterplot <- renderPlot(
{
  print(getScatterplot(df, vector()))#,input$variables, input$colorBy))
}, 
width = 800,
height = 500)
  
  output$parallelcoords <- renderPlot(
{
  print(getParallelcoords(df, vector()))#, input$variables, input$colorBy))
}, 
width = 800,
height = 1200)
  
  output$legend <- renderPlot(
{
  print(getLegend(df, vector()))#, input$xAxisBy, input$yAxisBy, input$zAxisBy, input$colorBy))
}, 
width = 1200,
height = 100)
  
  
})




