library(shiny)
shinyUI(fluidPage(
        titlePanel("Diamonds: Predict price from carats"),
        sidebarLayout(
                sidebarPanel(
                        radioButtons("cut", "Select quality of the cut:",
                                     c("All" = "All",
                                       "Fair" = "Fair",
                                       "Good" = "Good",
                                       "Very Good" = "Very Good",
                                       "Premium" = "Premium",
                                       "Ideal" = "Ideal")),
                        radioButtons("color", "Select color of the diamond:",
                                     c("All" = "All",
                                       "D (best)" = "D",
                                       "E" = "E",
                                       "F" = "F",
                                       "G" = "G",
                                       "H" = "H",
                                       "I" = "I",
                                       "J (worst)" = "J")),
                        h3("Slope"),
                        textOutput("slopeOut"),
                        h3("Intercept"),
                        textOutput("intOut"),
                        h3("Observations"),
                        textOutput("counter")
                ),
                mainPanel(
                        plotOutput("plot1", brush = brushOpts(
                                id = "brush1"
                        )),
                        h4("The app shows how to use linear regression to predict price of diamands using carats as input."),
                        h4("The dataset is the diamonds dataset contained in R package ggplot2."),
                        h4("Instructions:"),
                        h6(" 1. Select the quality and the color of diamonds in the left panel"),
                        h6(" 2. Look at the plot on the right, showing the result of the selection and, in the left panel, the number of observations."),
                        h6(" 3. Using the mouse, draw a selection box on the plot."),
                        h6(" 4. Look at the red regression line in the plot and, in the left panel, the slope and the intercept calculated by the model."),
                        h6(" 5. Repeat.")
                )
        )
))