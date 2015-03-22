
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI (
        pageWithSidebar (
                headerPanel ("Shiny Application"),

                sidebarPanel (
                        strong(helpText ("Project Description")),
                        helpText ("shiny application with associated supporting documentation"),
#                        selectInput ("Distribution",
#                                     "Please Select Distribution Type",
#                                     choices = c("Normal", "Exponential")
#                        ),
#                        sliderInput ("sampleSize",
#                                     "Please select sample size: ",
#                                     min = 100,
#                                     max = 5000,
#                                     value = 1000,
#                                     step = 100
#                        ),
#                        conditionalPanel (condition = "input.Distribution == 'Normal'",
#                                          textInput ("mean",
#                                                     "Please select the mean",
#                                                     10),
#                                          textInput ("sd",
#                                                     "Please select the Standard Deviation",
#                                                     3)
#                        ),
#                        conditionalPanel (condition = "input.Distribution == 'Exponential'",
#                                          textInput ("lambda",
#                                                     "Please select exponential lambda: ",
#                                                     1)
#                        ),
#                        selectInput ("var",
#                                     "1. Select the variable from the iris dataset",
#                                     choices = c("Sepal.length" = 1,
#                                                 "Sepal.width" = 2,
#                                                 "Petal.Lenght" = 3,
#                                                 "Petal.width" = 4),
#                                     selected = 3
#                        ),

                        selectInput (inputId = "data1",
                                     label = "Select the Dataset of your choice",
                                     choices = c ("iris",
                                                  "mtcars",
                                                  "trees")),
                        uiOutput ("vx"), # vx is coming from renderUI in server.r
                        uiOutput ("vy"), # vy is coming from renderUI in server.r
                        sliderInput ("bins",
                                     "1. Select the density for histogram",
                                     min = 50,
                                     max = 250,
                                     value = 150
                        ),
                        radioButtons ("color",
                                       "2. Select the colour of histogram",
                                       choices = c("Dark Green",
                                                   "Dark Red",
                                                   "Dark Orange"),
                                       selected = "Dark Green"
                        ),
                        radioButtons ("graphictype",
                                      "3. Select the type of graphic",
                                      choices = c("BarPlot",
                                                  "BoxPlot",
                                                  "DotPlot",
                                                  "LineChart",
                                                  "ScatterPlot"),
                                      selected = "BarPlot"
                        )
                ),

                mainPanel (
                        #plotOutput ("myPlot"),

                        tabsetPanel (type = "tab",
                                     tabPanel ("Dinamyc Plot",
                                               plotOutput ("dynplot")
                                     ),
                                     tabPanel ("Structure",
                                               verbatimTextOutput ("str")
                                     ),
                                     tabPanel ("Summary",
                                               verbatimTextOutput ("sum")
                                     ),
                                     tabPanel ("Data",tableOutput ("datax")
                                     )
#                                     tabPanel ("Plot",
#                                               plotOutput ("myhist")
#                                        )
                        )
                )
        )

)

