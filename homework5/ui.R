library(shiny)

#setwd('C:\\Users\\Cole\\Desktop\\Classwork\\MSAN622_Data_Vis\\HW5')
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
series <- names(df)[c(1:4,7)]

shinyUI(
  
  fluidPage(
            fluidRow(
                     column(12,offset=2,
                            titlePanel("Road Casualties in Great Britain 1969-84"))),
  
  fluidRow(
    column(2,
             conditionalPanel(
               condition="input.conditionedPanels == 'Injuries and Deaths of Time'",
               fluidRow(
                 checkboxGroupInput(
                   "series",
                   "Series to Plot",
                   series,
                   selected = series
                 )),
               fluidRow(
                 sliderInput("time_range1","Dates to Plot",
                             min = 1969.0,  max = 1984.917, value = c(1980.0, 1984.917),
                             step = 1/12, format = '0000', ticks = TRUE
                 ))#,
             ),
             conditionalPanel(
               condition="input.conditionedPanels == 'Comparing the Yearly Trends'",
               selectInput(
                           "column",
                           "Variable to Plot",
                           choices = series,
                           selected = "Car Drivers"
                         ),
               sliderInput("time_range2","Years to Plot",
                           min = 1969,  max = 1984, value = c(1969,1984),
                           step = 1, format = '0000', ticks = TRUE
               ),
               selectInput(
                 "highlight1",
                 "Year to Highlight",
                 choices = seq(1969,1984),
                 selected = 1983
               ),
               selectInput(
                 "highlight2",
                 "Other Year to Compare",
                 choices = seq(1969,1984),
                 selected = 1982
               )
             )
             ),
#            column(3,
#                   fluidRow(
#                     selectInput(
#                       "series",
#                       "Series to Plot",
#                       choices = 'Income',
#                       selected = "Income"
#                     )
#                   ),
#                   fluidRow(
#                     selectInput(
#                       "yAxisBy",
#                       "y-Axis:",
#                       choices = 'Life Exp',
#                       selected = "Life Exp"
#                     )
#                   ),
#                   fluidRow(
#                     selectInput(
#                       "zAxisBy",
#                       "Dot size:",
#                       choices = 'Population',
#                       selected = "Population"
#                     )
#                   )
                  
#           ),

    #column(10,
      mainPanel(
        tabsetPanel(
          tabPanel("Injuries and Deaths of Time", 
                   plotOutput("mainPlot", 
                              width = "100%", 
                              height = "400px"), 
                   plotOutput("overviewPlot", 
                              width = "100%", 
                              height = "100px")),
          #tabPanel("Summary", verbatimTextOutput("summary")),
          tabPanel("Comparing the Yearly Trends", 
                   plotOutput("plot2", 
                               width = "100%", 
                               height = "600px")),
          id = "conditionedPanels" 
        )
        
      )
    #)
  )
))

# checkboxInput("smooth", "Smooth"),
# conditionalPanel(
#   condition = "input.smooth == true",
#   selectInput("smoothMethod", "Method",
#               list("lm", "glm", "gam", "loess", "rlm"))
# )
