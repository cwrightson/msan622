library(shiny)

#setwd('C:\\Users\\Cole\\Desktop\\Classwork\\MSAN622_Data_Vis\\Project')

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
                   c('World', 'United States')
                 )),
               fluidRow(
                 checkboxGroupInput(
                   "location",
                   "Location",
                   c('Birth', 'High School', 'College', 'NBA'),
                   selected = 'Birth'
                 )),
               fluidRow(
                 radioButtons(
                   "current",
                   "Players to Show",
                   c('All Players', 'Current Players Only'),
                   selected = 'All Players'
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
                   "lines",
                   "Migration",
                   c('Show Migration', 'Hide Migration'),
                   selected = 'Hide Migration'
                 ))
             ),
             conditionalPanel(
               condition="input.conditionedPanels == 'Basketball Hotbeds' | input.conditionedPanels == 'NBA Demogrphics over Time'",
               fluidRow(
                 selectInput(
                   "geo",
                   "Geographic Breakdown",
                   c('City', 'State', 'Country', 'Continent'),
                   selected = 'City'
                 )),
               fluidRow(
                 selectInput(
                   "when",
                   "Level",
                   c('Place of Birth', 'High School', 'College'),
                   selected = 'Place of Birth'
                 )),
               fluidRow(
                 selectInput(
                   "us_int",
                   "Domestic/International",
                   c('All Players', 'US-Born Players Only', 'Foreign-Born Players Only'),
                   selected = 'All Players'
                 )),
               fluidRow(
                 sliderInput("seasons2","Seasons",
                             min = 1947,  max = 2014, value = c(1947, 2014),
                             step = 1, format = '0000', ticks = TRUE
                 ))
      ),
             conditionalPanel(
               condition="input.conditionedPanels == 'Talented Populations'",
               fluidRow(
                 selectInput(
                   "sc",
                   "Location",
                   c('City', 'State'),
                   selected = 'State'
                 )),
               fluidRow(
                 selectInput(
                   "bh",
                   "Level",
                   c('Place of Birth', 'High School'),
                   selected = 'Place of Birth'
                 )),
               fluidRow(
                 sliderInput("zoom.x","X-Axis Limits",
                             min = 0,  max = 40000000, value = c(0, 40000000),
                             step = 100000, format = '00,000,000', ticks = TRUE
                 )),
               fluidRow(
                 sliderInput("zoom.y","y-Axis Limits",
                             min = 0,  max = 400, value = c(0, 400),
                             step = 10, ticks = TRUE
                 ))
#             ),
#       conditionalPanel(
#         condition="input.conditionedPanels == 'NBA Demogrphics over Time'",
#         fluidRow(
#           selectInput(
#             "geo3",
#             "Geographic Breakdown",
#             c('City', 'State', 'Country', 'Continent'),
#             selected = 'City'
#           )),
#         fluidRow(
#           selectInput(
#             "when3",
#             "Level",
#             c('Place of Birth', 'High School', 'College'),
#             selected = 'Place of Birth'
#           )),
#         fluidRow(
#           selectInput(
#             "us_int3",
#             "Domestic/International",
#             c('All Players', 'US-Born Players Only', 'Foreign-Born Players Only'),
#             selected = 'All Players'
#           )),
#         fluidRow(
#           sliderInput("seasons3","Seasons",
#                       min = 1947,  max = 2014, value = c(1947, 2014),
#                       step = 1, format = '0000', ticks = TRUE
#           ))
     )
),

      mainPanel(
        tabsetPanel(
          tabPanel("NBA Player Map", 
                   plotOutput("plot1", 
                              width = "100%", 
                              height = "600px")),
          tabPanel("Basketball Hotbeds", 
                   plotOutput("plot2", 
                              width = "100%", 
                              height = "600px")),
          tabPanel("NBA Demogrphics over Time", 
                   plotOutput("plot3", 
                              width = "100%", 
                              height = "600px")),
          tabPanel("Talented Populations", 
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
