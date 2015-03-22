
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

# Load shiny package
library(shiny)
# Load the ggplot2 package
library (ggplot2)
# Load the car package
library (car)
# Load the RcppEigen package
library (RcppEigen)
# Load the iris dataset
# data (iris)

# beginning of the shiny server function
shinyServer (function(input, output, session) {

        colm <- reactive ({
                get(input$data1)
        })

        # The following reactive function would retrun the column variable names
        #   corresponding to the dataset selected
        var <- reactive ({
                switch (
                        input$data1,
                        "iris" = names (iris),
                        "mtcars" = names (mtcars),
                        "trees" = names (trees)
                )
        })

        dataset <- reactive ({
                switch (
                        input$data1,
                        "iris" = iris,
                        "mtcars" = mtcars,
                        "trees" = trees
                )
        })

        graph <- reactive ({
                switch (
                        input$graphictype,
                        "BarPlot" = "BarP",
                        "BoxPlot" = "BoxP",
                        "DotPlot" = "DP",
                        "LineChart" = "LC",
                        "ScatterPlot" = "SP"
                )
        })

        datax <- reactive ({get(input$variablex)})
        datay <- reactive ({get(input$variabley)})

        # vx and vy are the output variables from rederUI containing the list
        #   of variable names in a dorp down / select Input UI
        # renderUI is used in server side and is used along with uiOutput in the ui.r
        # uiOutput is userd in ui.R to display the selectInput widget dynamically using
        #   the output variable vx & vy
        # using vx and vy in the ui.R we will dynamically carete the drop down
        #   with the columns names based on the dataset
        output$vx <- renderUI ({
                selectInput ("variablex",
                             "Select the First (X) variable",
                             choices = var ())
        })

        output$vy <- renderUI ({
                selectInput ("variabley",
                             "Select the Second (Y) variable",
                             choices = var ())
        })

        # renderPlot is used to plot the ggplot and the plot output will be stored
        #   in the output variable p
        output$dynplot <- renderPlot ({
                attach (get (input$data1))

                if (graph() == "BarP"){
                        barplot (colm()[, input$variablex],
                                 colm()[, input$variabley],
                                 col = input$color,
                                 main = input$variablex,
                                 xlab = input$variablex,
                                 ylab = input$variabley,
                                 density = input$bins
                        )
                }
                else {
                        if (graph() == "BoxP"){
                                boxplot (colm()[, input$variablex] ~ colm()[, input$variabley],
                                         col = input$color,
                                         main = input$variablex,
                                         xlab = input$variablex,
                                         ylab = input$variabley
                                )
                        }
                        else {
                                if (graph() == "DP"){
                                        plot (x = get (input$variablex),
                                              y = get (input$variabley),
                                              xlab = input$variablex,
                                              ylab = input$variabley,
                                              main = input$variablex,
                                              col = input$color
                                        )
                                }
                                else {
                                        if (graph() == "LC"){
                                                par (pch = 22,
                                                     col = input$color
                                                )
                                                #par (mfrow = c (2, 4))
                                                #opts = get (input$variabley)

                                                #for (i in 1:length (input$variablex)) {
                                                        plot (x = get (input$variablex),
                                                              y = get (input$variabley),
                                                              main = input$variablex,
                                                              col = input$color,
                                                              type = "o"
                                                        )

                                                        lines (input$variablex,
                                                               input$variabley,
                                                               type = "o", lty = 1
                                                               #lwd = 1.5
                                                        )
                                                #}
                                        }
                                        else {
                                                if (graph() == "SP"){
                                                        plot (x = get (input$variablex),
                                                              y = get (input$variabley),
                                                              xlab = input$variablex,
                                                              ylab = input$variabley,
                                                              main = input$variablex,
                                                              col = input$color
                                                        )
                                                        abline (lm(get (input$variablex) ~ get (input$variabley)),
                                                                col = "dark grey")
                                                        lines (lowess (get (input$variabley), get (input$variablex)),
                                                               col = input$color
                                                        )
                                                }
                                        }
                                }

                        }
                }

                legend ("topright",
                        input$variablex,
                        input$variabley,
                        border = "black"
                )


                #ggplot (get (input$data1),
                #        aes_string (input$variablex,
                #                    input$variabley)
                #        ) +
                #        geom_point()
                #ggplot (get (input$data1),
                #        aes (x = get (input$variablex),
                #             y = get (input$variabley)
                #        ),
                #        environment = environment()
                #) +
                #geom_point(col = input$color)
                #hist (dataset()[, colm()],
                #      breaks = seq (0,
                #                    max (dataset()[, colm()]),
                #                    l = 50,#input$bins+1),
                #      col = input$color,
                #      main = "Histogram of iris dataset",
                #      xlab = names (dataset()[colm()]),
                #      xlim = c(0,
                #               max (dataset()[, colm()])
                #               )
                #      )
                #print (colm()[input$variablex])
        })





#        output$myPlot <- renderPlot ({
#                distType <- input$Distribution
#                size <- input$sampleSize

#                if (distType == "Normal"){
#                        randomVec <- rnorm (size,
#                                            mean = as.numeric(input$mean),
#                                            sd = as.numeric (input$sd))
#                }
#                else {
#                        randomVec <-rexp (size,
#                                           rate = 1/as.numeric (input$lambda))
#                }

#                hist (randomVec,
#                      col = "blue")
#        })

#        output$text1 <- renderText ({
                #colm = as.numeric (input$var)
#                paste ("Data set variable/column name is",
#                       names (iris[colm()])
#                )
#        })

        #output$text1 <- renderPlot ({
        #        hist (dynplot,
        #              col = input$color)
        #})

        #output$text2 <- renderText ({
        #        paste ("Color of histogram is",
        #               input$radio
        #        )
        #})

        #output$text3 <- renderText ({
        #        paste ("Number of histogram BINs is",
        #               input$bin
        #        )
        #})

        output$sum <- renderPrint ({
                summary (dataset())
        })

        output$str <- renderPrint ({
                str (dataset())
        })

        output$datax <- renderTable ({
                #colm <- as.numeric (input$var)
                dataset()[input$variablex]#[colm()]
        })

#        output$datay <- renderTable ({
#                #colm <- as.numeric (input$var)
#                dataset()[input$variabley]
#        })

#        output$myhist <- renderPlot ({
                #colm <- as.numeric (input$var)

#                hist (dataset()[, colm()],
#                      breaks = seq (0,
#                                   max (dataset()[, colm()]),
#                                   l = 50),#input$bins+1),
#                      col = input$color,
#                      main = "Histogram of iris dataset",
#                      xlab = names (dataset()[colm()]),
#                      xlim = c(0,
#                               max (dataset()[, colm()]))
#                )
#        })
})
