library(shiny)
#library(ggplot2)

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
# levels(highlights) <- append(levels(highlights), 'All')
# highlights <- levels(highlights)

# this is using shiny version 0.9+
shinyUI(fluidPage(
#   titlePanel("Visualizing the States Data Set"),
#   #plotOutput("heatmap"),
#   plotOutput("bubbleplot"),
#   plotOutput("scatterplot"),
#   plotOutput("parallelcoords"),
#  div("Low values are green, mid values are white, and high values are purple.", align = "center"),
  fluidRow(
    column(12,offset=4,
           titlePanel("The States Data Set"))),
     absolutePanel(height=2,
       plotOutput("legend")),
          fluidRow(br(),br(),br(),br(),br(),br(),
            column(6,
                   
           fluidRow(
#              column(2, 
#                     fluidRow(
#                       selectInput(
#                         "colorBy",
#                         "Group By:",
#                         choices = c("Region", "Division")
#                       )
#                     ),
#                     fluidRow(
#                       selectInput(
#                         "xAxisBy",
#                         "x-Axis:",
#                         choices = sortChoices,
#                         selected = "Income"
#                       )
#                     ),
#                     fluidRow(
#                       selectInput(
#                         "yAxisBy",
#                         "y-Axis:",
#                         choices = sortChoices,
#                         selected = "Life Exp"
#                       )
#                     ),
#                     fluidRow(
#                       selectInput(
#                         "zAxisBy",
#                         "Dot size:",
#                         choices = sortChoices,
#                         selected = "Population"
#                       )
#                              )
#                    ),
             column(12,
                    plotOutput("bubbleplot"))
             ),
                   
  fluidRow(
#              column(2, 
#                     fluidRow(
#                       column(6,
#                       br(),
#                       checkboxGroupInput(
#                       "variables",
#                       "Stats to Plot:",
#                       sortChoices,
#                       selected = c("Population", "Income", "Life Exp")
#                     )),
#                       column(6,
#                       br(),
#                       checkboxGroupInput(
#                         "highlight",
#                         "Regions:",
#                         highlights,
#                         selected = highlights
#                       ))
#                     )
#              ),
             column(width = 12,
                    plotOutput("scatterplot")
                    )
             )
                   ),
            column(width = 5,
                   plotOutput("parallelcoords")
            )
          ),
#   absolutePanel(height=2,
#     plotOutput("legend")),
    fluidRow(br(),#br(),br(),br(),br(),br(),
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
           
#              plotOutput("parallelcoords")
#            ),
#   fluidRow(
#     column(6, 
#            selectInput(
#              "colorBy",
#              "Group By:",
#              choices = c("Region", "Division")
#            ),
#            br(),
#            checkboxGroupInput(
#              "variables",
#              "Stats to Plot:",
#              sortChoices,
#              selected = c("Population", "Income", "Life Exp")
#            )
#            ),
#     column(6,
#            sliderInput(
#              "range",
#              "Gradient Range:",
#              min = 0,
#              max = 1,
#              value = c(0.40, 0.60),
#              step = 0.05,
#              format = "0.00",
#              ticks = TRUE),
#            br(),
#            helpText(paste("This will control the",
#                           "middle break points for the color",
#                           "gradient. The selected range will",
#                           "become white.")))
#   )
#     ))
             
    
    
    
#     column(6,
#            sliderInput(
#              "range",
#              "Gradient Range:",
#              min = 0,
#              max = 1,
#              value = c(0.40, 0.60),
#              step = 0.05,
#              format = "0.00",
#              ticks = TRUE),
#            br(),
#            helpText(paste("This will control the",
#                           "middle break points for the color",
#                           "gradient. The selected range will",
#                           "become white."))
#    )
  
  
  
#     column(3,
#            radioButtons(
#              "sort1",
#              "Sort By:",
#              sortChoices,
#              selected = c("Population")
#            )
#     )#,
  
  
  
#     column(3,
#            radioButtons(
#              "sort2",
#              "Sort By:",
#              sortChoices,
#              selected = c("Population")
#            )
#     )#,
#     column(3,
#            selectInput(
#              "colorScheme",
#              "Color Scheme:",
#              choices = c("Default", "Accent", "Set1", "Set2", "Set3", "Dark2", "Pastel1", "Pastel2")
#            ),
#     ),
#     column(3,
#            HTML("<p align=\"center\">[ <a href=\"https://github.com/cwrightson/msan622/tree/master/homework3\">download source</a> ]</p>")
#     )
  
  
  
#  ))
#))

# shinyUI(
#   
#   pageWithSidebar(
#     
#     headerPanel(),
#     
#     sidebarPanel(    
      
#       checkboxGroupInput(
#         "genres",
#         "Genres",
#         c("Action", "Animation", "Comedy", "Drama", "Documentary", "Romance", "Short", "Mixed"),
#         selected = c("Action", "Animation", "Comedy", "Drama", "Documentary", "Romance", "Short", "Mixed")
#       ),
      
#       radioButtons(
#         "highlight",
#         "MPAA Rating",
#         c("All", "PG", "PG-13", "R", "NC-17")
#       ), 
      
#       sliderInput("budget_range","Budget Range:",
#                   min = 0,  max = 200000000, value = c(0, 200000000),
#                   step = 1000000, format = '$0', ticks = TRUE),
      
#       sliderInput("rating_range","Rating Range:",
#                   min = 0,  max = 10, value = c(0, 10),
#                   step = .25, format = '0.00'),
      
#       selectInput(
#         "titles_on",
#         "Display Movie Titles:",
#         choices = c("Off", "On")
#       ),
      
#       sliderInput("alphaSize", "Opacity:",  
#                   min = 0.1, max = 1.0, value = .6, step= 0.1),
      
#       sliderInput("dotSize", "Dot Size:",  
#                   min = 1, max = 10, value = 5),
      
#       selectInput(
#         "colorScheme",
#         "Color Scheme:",
#         choices = c("Default", "Accent", "Set1", "Set2", "Set3", "Dark2", "Pastel1", "Pastel2")
#       ),
      
#       width = 2,
#       HTML("<p align=\"center\">[ <a href=\"https://github.com/cwrightson/msan622/tree/master/homework3\">download source</a> ]</p>")
#     ),
#     
#     
#     mainPanel(plotOutput("heatmap"), width = 10),
#     
#     mainPanel(plotOutput("scatterplot"), width = 10),
#     
#     mainPanel(plotOutput("parallelcoords"), width = 10)
#   )
# )


