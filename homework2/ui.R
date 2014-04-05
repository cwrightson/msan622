library(shiny)

shinyUI(

  pageWithSidebar(

    headerPanel("Visualizing the Movies Data Set"),
    
    sidebarPanel(    
      
      checkboxGroupInput(
        "genres",
        "Genres",
        c("Action", "Animation", "Comedy", "Drama", "Documentary", "Romance", "Short", "Mixed"),
        selected = c("Action", "Animation", "Comedy", "Drama", "Documentary", "Romance", "Short", "Mixed")
      ),
      
      radioButtons(
        "highlight",
        "MPAA Rating",
        c("All", "PG", "PG-13", "R", "NC-17")
      ), 
      
      sliderInput("budget_range","Budget Range:",
        min = 0,  max = 200000000, value = c(0, 200000000),
                  step = 1000000, format = '$0', ticks = TRUE),
      
      sliderInput("rating_range","Rating Range:",
                  min = 0,  max = 10, value = c(0, 10),
                  step = .25, format = '0.00'),
      
      selectInput(
        "titles_on",
        "Display Movie Titles:",
        choices = c("Off", "On")
      ),
      
      sliderInput("alphaSize", "Opacity:",  
                  min = 0.1, max = 1.0, value = .6, step= 0.1),
      
      sliderInput("dotSize", "Dot Size:",  
                  min = 1, max = 10, value = 5),
      
      selectInput(
        "colorScheme",
        "Color Scheme:",
        choices = c("Default", "Accent", "Set1", "Set2", "Set3", "Dark2", "Pastel1", "Pastel2")
      ),

      width = 2,
      HTML("<p align=\"center\">[ <a href=\"https://github.com/cwrightson/msan622/tree/master/homework2\">download source</a> ]</p>")
    ),
    

    mainPanel(plotOutput("scatterplot"), width = 10)
  )
)