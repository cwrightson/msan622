library(ggplot2)
library(shiny)
#library(scales)
#setwd('C:\\Users\\Cole\\Desktop\\Classwork\\MSAN622_Data_Vis\\HW2')
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

shinyUI(
  # We will create a page with a sidebar for input.
  pageWithSidebar(
    # Add title panel.
    headerPanel("Movie Genres"),
    
    # Setup sidebar widgets.
    sidebarPanel(

      # Add true/false checkbox for sorting.
      radioButtons(
        "highlight",
        "MPAA Rating",
        c("All", "PG", "PG-13", "R", "NC-17")#,
      ),
      
      
      checkboxGroupInput(
        "genres",
        "Genres",
        c("Action", "Animation", "Comedy", "Drama", "Documentary", "Romance", "Short", "Mixed"),
        selected = c("Action", "Animation", "Comedy", "Drama", "Documentary", "Romance", "Short", "Mixed")
      ),

      selectInput(
        # This will be the variable we access later.
        "colorScheme",
        # This will be the control title.
        "Color Scheme:",
        # This will be the control choices.
        choices = c("Default", "Accent", "Set1", "Set2", "Set3", "Dark2", "Pastel1", "Pastel2")
      ),
       sliderInput("dotSize", "Dot Size:",  
                    min = 1, max = 10, value = 5),
      
      sliderInput("alphaSize", "Opacity:",  
                  min = 0.1, max = 1.0, value = .6, step= 0.1),
      
      sliderInput("budget_range","Budget Range:",
        min = 0,  max = 200000000, value = c(0, 200000000),
                  step = 1000000, format = '$0', ticks = TRUE),
      
      sliderInput("rating_range","Rating Range:",
                  min = 0,  max = 10, value = c(0, 10),
                  step = .25, format = '0.00'),
      
      selectInput(
        # This will be the variable we access later.
        "titles_on",
        # This will be the control title.
        "Display Movie Titles:",
        # This will be the control choices.
        choices = c("Off", "On")
      ),

      width = 2,
      # Add a download link
      HTML("<p align=\"center\">[ <a href=\"https://github.com/msan622/lectures/tree/master/ShinyDemo/demo1\">download source</a> ]</p>")
    ),
    
#     # Setup main panel.
#     mainPanel(
#       # Create a tab panel.
#       tabsetPanel(
#         # Add a tab for displaying the histogram.
#         tabPanel("Scatterplot", plotOutput("scatterplot"), width = 10),
#         
#         # Add a tab for displaying the table (will be sorted).
#         tabPanel("Table", tableOutput("table"))
#       )
#     )
    mainPanel(plotOutput("scatterplot"), width = 10)
  )
)