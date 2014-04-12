library(reshape)
library(ggplot2)
library(scales)
library(GGally)
library(shiny)
library(plyr)

setwd('C:\\Users\\Cole\\Desktop\\Classwork\\MSAN622_Data_Vis\\HW3')

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


getBubbleplot <- function(dataset, vector){
  
  choices <- gsub("\\.", " ", colnames(df))
  vars <- seq(1,12)
  xaxis <- vars[which(choices %in% vector[1][[1]])]
  yaxis <- vars[which(choices %in% vector[2][[1]])]
  colorBy <- vars[which(choices %in% vector[3][[1]])]
  dotSize <- vars[which(choices %in% vector[4][[1]])]
  highlights <- vector[6][[1]]
  
  
  palette <- c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00', 
               '#ffff33', '#a65628', '#f781bf', '#999999')
  
  if(colorBy == 11){
    palette <- c('#e41a1c', '#e41a1c', '#377eb8', '#377eb8', '#377eb8', 
                 '#4daf4a', '#4daf4a', '#984ea3', '#984ea3')
  }
  
  palette[!seq(1,9) %in% highlights] <- 'grey70'
  
  df2 <- data.frame('x2' = df[,xaxis], 'y2' = df[,yaxis], 'z2' = df[,dotSize], 'color2' = df[,12])
  
  # Create bubble plot
  p <- ggplot(df2, aes(
    x = x2,
    y = y2,
    color = color2,
    size = z2))
  
  # Give points some alpha to help with overlap/density
  p <- p + geom_point(alpha = 0.6)
  
  # Default size scale is by radius, force to scale by area instead
  # Optionally disable legends
  p <- p + scale_size_area(guide = "none")
  p <- p + theme(panel.background = element_rect(fill = NA))
  
  # Modify the labels
  p <- p + labs(
    size = names(df)[dotSize],
    color = names(df)[colorBy],
    x = names(df)[xaxis],
    y = names(df)[yaxis])
  
  # Remove legend
  p <- p + theme(legend.position="none")

  p <- p + scale_color_manual(values = palette)
  
  
return(p)
  
  
}





getScatterplot <- function(dataset, vector){
  columns_wanted = vector[5][[1]]
  colorBy = vector[3][[1]]
  highlights <- vector[6][[1]]
  
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
        
        # remove background and set color
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




getParallelcoords <- function(dataset, vector){
  columns_wanted = vector[5][[1]]
  vars <- seq(1,12)
  choices <- gsub("\\.", " ", colnames(df))
  colorBy <- vars[which(choices %in% vector[3][[1]])]
  highlights <- vector[6][[1]]

  
  palette <- c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00', 
               '#ffff33', '#a65628', '#f781bf', '#999999')
  
  if(colorBy == 11){
    palette <- c('#e41a1c', '#e41a1c', '#377eb8', '#377eb8', '#377eb8', 
                 '#4daf4a', '#4daf4a', '#984ea3', '#984ea3')
  }
  
  palette[!seq(1,9) %in% highlights] <- 'grey70'
  
  
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
  
  #flip axes
  p <- p + coord_flip()
  
  # Decrease amount of margin around x, y values
  p <- p + scale_y_continuous(expand = c(0.02, 0.02))
  p <- p + scale_x_discrete(expand = c(0.02, 0.02))
  
  # Remove axis ticks and labels
  p <- p + theme(axis.title = element_blank())
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
  
  # Add labels to plot as wanted
  p <- p + theme(legend.text = element_text(size = 18))
  p <- p + theme(legend.position="none")
  # Display parallel coordinate plot
  return(p)

}

#make the global legend via an empty plot
getLegend <- function(dataset, vector){
  columns_wanted = vector[5][[1]]
  vars <- seq(1,12)
  choices <- gsub("\\.", " ", colnames(df))
  colorBy <- vars[which(choices %in% vector[3][[1]])]
  highlights <- vector[6][[1]]
  
  
  palette <- c('#e41a1c', '#377eb8', '#4daf4a', '#984ea3', '#ff7f00', 
               '#ffff33', '#a65628', '#f781bf', '#999999')
  
  if(colorBy == 11){
    palette <- c('#e41a1c', '#e41a1c', '#377eb8', '#377eb8', '#377eb8', 
                 '#4daf4a', '#4daf4a', '#984ea3', '#984ea3')
  }
  
  palette[!seq(1,9) %in% highlights] <- 'grey70'
  
  #make the empty plot
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
  p <- p + theme_minimal()
  
  p <- p + theme(axis.title = element_blank())
  p <- p + theme(axis.text = element_text(size = 18))
  p <- p + theme(legend.title = element_text(size = 18))
  p <- p + theme(panel.grid = element_blank())
  p <- p + theme(panel.background = element_blank())
  p <- p + theme(panel.border = element_blank())
  p <- p + theme(legend.position = "bottom")
  p <- p + scale_color_manual(values = palette)
  p <- p + theme(legend.text = element_text(size = 12))
  p <- p + theme(axis.line  = element_blank())
  p <- p + theme(axis.text = element_blank())
  p <- p + theme(axis.ticks = element_blank())
  p <- p + theme(legend.title = element_blank())
  p <- p + coord_fixed(ratio = 1/1000)
  
  return(p)
}

# #put bubbles in order
# sortMelted <- function(original, melted, sort1){
#   # get sort order of original dataset
#   sortOrder <- order(original[[sort1]])#, original[[sort2]])
#   
#   # sort melted dataframe by modifying factor levels
#   melted$id <- factor(melted$id,
#                       levels = sortOrder, 
#                       ordered = TRUE)
#   
#   return(melted)
# }

melted <- processData(df)

shinyServer(function(input, output) {
  
  cat("Press \"ESC\" to exit...\n")
  
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

  
  output$bubbleplot <- renderPlot(
{
  print(getBubbleplot(df, vector()))
}, 
width = 800,
height = 500)
  
  
  output$scatterplot <- renderPlot(
{
  print(getScatterplot(df, vector()))
}, 
width = 800,
height = 500)
  
  output$parallelcoords <- renderPlot(
{
  print(getParallelcoords(df, vector()))
}, 
width = 800,
height = 1200)
  
  output$legend <- renderPlot(
{
  print(getLegend(df, vector()))
}, 
width = 1200,
height = 100)
  
  
})




