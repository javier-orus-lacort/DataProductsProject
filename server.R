library(shiny)
library(datasets)

shinyServer(function(input, output) {

  ## First REACTIVE Operation: To build the formula. It will be used in the 
  ## render statements afterwards to display the outputs:
  formula <- reactive({
    paste("mpg ~", input$variable)
  })
  
  ## Second REACTIVE Operation: To filter the Dataset. It will be used in the 
  ## render statements afterwards to display the outputs:
  filteredData <- reactive({
    switch(input$filter,
           "2" = mtcars,
           "0" = mtcars[mtcars$am %in% input$filter,],
           "1" = mtcars[mtcars$am %in% input$filter,])
  })

  ## Third REACTIVE Operation: To translate the Filter values into text. It 
  ## will be used in the render statements afterwards to display the outputs:
  filteredTrans <- reactive({
    switch(input$filter,
           "2" = "All Transmissions",
           "0" = "Only Automatic Transmissions",
           "1" = "Only Manual Transmissions")
  })
  
  ## Fourth REACTIVE Operation: To fit the Linear Model to get the Regression
  ## Line based on the selections done by the User. It will be used in the 
  ## render statements afterwards to display the outputs:
  fitModel <-reactive({
    lm(as.formula(formula()), filteredData())
  })
  
  ## Output of the selected Variable:
  output$caption1 <- renderText({
    paste("Selected Variable: ", input$variable)
  })
  
  ## Output of the selected Filter:
  output$caption2 <- renderText({
    paste("Selected Filter: ", filteredTrans())
  })

  ## Output the plot together with the Regression Line:
  output$plot <- renderPlot({
    plot(as.formula(formula()), data = filteredData(), 
         col = "black", pch = 16, lwd = 2, type="n",
         main = paste("Plot: ", formula(), ",  Data: ",filteredTrans()))
    
    points(as.formula(formula()), data = (subset(filteredData(), am == 0)), 
                                                 pch = 16, col = "blue")
    points(as.formula(formula()), data = (subset(filteredData(), am == 1)), 
                                                 pch = 16, col = "red")
    
    legend("topright", pch = 16, col = c("blue", "red"), 
           legend = c("Automatic", "Manual"))
    
    ## Adding here the Regression Line to the plot:
    abline(fitModel(), lwd = 2)
  })

  ## Output of the Regression Line Coefficients:
  output$coeff <- renderPrint({
    fitModel()$coefficients                            
  })
})
