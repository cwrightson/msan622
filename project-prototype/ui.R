library(shiny)

setwd('C:\\Users\\Cole\\Desktop\\Classwork\\MSAN622_Data_Vis\\Project')

players = c('None', 'LeBron James', 'Micheal Jordan', 'Dirk Nowitzki',  'Bill Russell')
locals = c('None', 'Chicago', 'Dallas', 'New York', 'San Francisco' )

shinyUI(
  
  fluidPage(
    fluidRow(
      column(12,offset=2,
             titlePanel("NBA Athletes: From the Driveway to the Hall of Fame"))),
    
    fluidRow(
      column(2,
             conditionalPanel(
               condition="input.conditionedPanels == 'NBA Player Map'",
               fluidRow(
                 radioButtons(
                   "map",
                   "Map",
                   c('World', 'United States', 'User Defined')
                 )),
               fluidRow(
                 radioButtons(
                   "location",
                   "Location",
                   c('Place of Birth', 'High School', 'College', 'NBA', 'All'),
                   selected = 'Place of Birth'
                 )),
               fluidRow(
                 sliderInput("long_range","Latitudes",
                             min = -180,  max = 180, value = c(-180, 180),
                             step = 1, format = '000', ticks = TRUE
                 )),
               fluidRow(
                 sliderInput("lat_range","Logitudes",
                             min = -90,  max = 90, value = c(-60, 85),
                             step = 1, format = '00', ticks = TRUE
                 )),
               fluidRow(
                 sliderInput("seasons1","Seasons",
                             min = 1947,  max = 2014, value = c(1947, 2014),
                             step = 1, format = '0000', ticks = TRUE
                 )),
               fluidRow(
                 selectInput(
                   "player",
                   "Highlight Player",
                   players,
                   selected = 'None'
                 )),
               fluidRow(
                 selectInput(
                   "location",
                   "Highlight Location",
                   locals,
                   selected = 'None'
                 )),
               fluidRow(
                 selectInput(
                   "edges",
                   "Migration",
                   c('Show Migration', 'Hide Migration'),
                   selected = 'Hide Migration'
                 ))
             ),
             conditionalPanel(
               condition="input.conditionedPanels == 'Comparing the Yearly Trends'"
               
             )
      ),

      mainPanel(
        tabsetPanel(
          tabPanel("NBA Player Map", 
                   plotOutput("plot1", 
                              width = "100%", 
                              height = "400px")),
          tabPanel("Basketball Hotbeds", 
                   plotOutput("plot2", 
                              width = "100%", 
                              height = "600px")),
          tabPanel("Salaries over Time", 
                   plotOutput("plot3", 
                              width = "100%", 
                              height = "600px")),
          tabPanel("Pay vs. Play", 
                   plotOutput("plot4", 
                              width = "100%", 
                              height = "600px")),
          id = "conditionedPanels" 
        )
        
      )
    )
  ))

# checkboxInput("smooth", "Smooth"),
# conditionalPanel(
#   condition = "input.smooth == true",
#   selectInput("smoothMethod", "Method",
#               list("lm", "glm", "gam", "loess", "rlm"))
# )
