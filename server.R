library(shiny)
library(stockPortfolio)


shinyServer(function(input, output) {

  pReturn <- reactive({
    getReturns(c(input$index, trimws(unlist(strsplit(input$ticker, split=",")))), start = input$date_range[1], end = input$date_range[2])
  })
  
  pModel <- reactive({
    stockModel(pReturn(), Rf=input$risk_free/12, index=1, model="SIM")
  })
 
  pOptimized <- reactive({
    optimalPort(pModel())
  })
  
  output$model <- renderPrint({
    print(pModel()) 
  })  
  
  output$portfolio <- renderPrint({
    print(pOptimized())
  })  
  
  output$plot <- renderPlot({
    plot(pOptimized(), addNames=TRUE)
    portPossCurve(pModel(), add=TRUE, effFrontier=TRUE)

  })
  
})