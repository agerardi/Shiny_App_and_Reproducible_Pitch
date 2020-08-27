library(shiny)
library(ggplot2)
data(diamonds)

#my_diamonds <- diamonds[sample(nrow(diamonds), 5000),]
my_diamonds <- diamonds

shinyServer(function(input, output) {
       my_diamonds <- reactive({
             if(input$cut == "All") {
                   if(input$color == "All") {
                        diamonds
                   } else {
                        subset(diamonds, color==input$color)
                   }
             } else {
                   if(input$color == "All") {
                        subset(diamonds, cut==input$cut)
                   } else {
                        subset(diamonds, cut==input$cut & color==input$color)
                   }
             }
        })
       
        model <- reactive({
                    brushed_data <- brushedPoints(my_diamonds(), input$brush1,
                                                  xvar = "carat", yvar = "price")
                    if(nrow(brushed_data) < 2){
                         return(NULL)
                    }
                    lm(price ~ carat, data = brushed_data)
        })
        output$cut_value <- renderText({input$cut})
        output$color_value <- renderText({input$color})
        output$counter <- renderText({nrow(my_diamonds())})
        output$slopeOut <- renderText({
                if(is.null(model())){
                        "No Model Found"
                } else {
                        model()[[1]][2]
                }
        })
        output$intOut <- renderText({
                if(is.null(model())){
                        "No Model Found"
                } else {
                        model()[[1]][1]
                }
        })
        output$plot1 <- renderPlot({
                plot(my_diamonds()$carat, my_diamonds()$price, xlab = "Carat",
                     ylab = "Price", main = "Diamonds",
                     cex = 1.5, pch = 16, bty = "o", xlim=c(0, 5), ylim=c(0, 20000))
                if(!is.null(model())){
                        abline(model(), col = "red", lwd = 2)
                }
        })
})