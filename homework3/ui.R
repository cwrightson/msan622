library(shiny)


data(state)
df <- data.frame(state.x77,
                 State = state.name,
                 Region = state.region,
                 Division = state.division
)
sortChoices <- gsub("\\.", " ", colnames(state.x77))
greyed <- c("New England (Northeast)", "Middle Atlantic (Northeast)",
            "South Atlantic (South)", "East South Central (South)", "West South Central (South)",
            "East North Central (North Central)", "West North Central (North Central)",
            "Mountain (West)", "Pacific (West)")


# this is using shiny version 0.9+
shinyUI(fluidPage(
  fluidRow(
    column(12,offset=4,
           titlePanel("The States Data Set"))),
     absolutePanel(height=2,
       plotOutput("legend")),
          fluidRow(br(),br(),br(),br(),br(),br(),
            column(6,
                   
           fluidRow(
             column(12,
                    plotOutput("bubbleplot"))
             ),
                   
  fluidRow(
             column(width = 12,
                    plotOutput("scatterplot")
                    )
             )
                   ),
            column(width = 5,
                   plotOutput("parallelcoords")
            )
          ),

    fluidRow(br(),
      column(3,
             helpText(paste("Bubble Plot Controls")),
             fluidRow(
               selectInput(
                 "xAxisBy",
                 "x-Axis:",
                 choices = sortChoices,
                 selected = "Income"
               )
             ),
             fluidRow(
               selectInput(
                 "yAxisBy",
                 "y-Axis:",
                 choices = sortChoices,
                 selected = "Life Exp"
               )
             ),
             fluidRow(
               selectInput(
                 "zAxisBy",
                 "Dot size:",
                 choices = sortChoices,
                 selected = "Population"
               )
             )
             
      ),
      column(3,
             checkboxGroupInput(
               "variables",
               "Stats to Plot:",
               sortChoices,
               selected = c("Population", "Income", "Life Exp")
             )),
      column(3,
             checkboxGroupInput(
               "greys",
               "Regional Division to Show:",
               greyed,
               selected = greyed
             )),
      column(2,
             fluidRow(
               selectInput(
                 "colorBy",
                 "Color By:",
                 choices = c("Region", "Division")
               )
             ))
    )
  
))

