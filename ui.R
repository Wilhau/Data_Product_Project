library(shiny)

ind <- c("^GSPC", "^DJI", "^IXIC")
names(ind) <- c("S&P 500", "Dow Jones", "NASDAQ")

shinyUI(fluidPage(
  
  titlePanel("Stock Portfolio Optimizer"),
  
  sidebarLayout(
    
    sidebarPanel(
      helpText("When entering the ticker symbols of the securities below, please separate the symbols by comma(,)."),
      textInput("ticker", label="Ticker Symbols", value="MSFT, AAPL, GOOGL"),
      dateRangeInput("date_range", label="Date Range", start="2010-01-01"),
      sliderInput("risk_free", label="Annual Risk Free Rate", min=0.0, max=0.05, value=0.0, step=0.001),
      selectInput("index", label="Stock Index", choices=ind),
      submitButton("Submit")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Summary", helpText("Model Summary:"), verbatimTextOutput("model"), helpText("Optimized Portfolio:"), verbatimTextOutput("portfolio")),
        tabPanel("Plot", plotOutput("plot"), helpText("note: the black dot indicates the optimized portfolio and the line represents the efficient frontier.")), 
        tabPanel("Help", h4("What does this app do?"), 
                 p("This app uses the stockPortfolio package in R to derive an optimized stock portfolio given the choice of stocks. 
                    When the app starts, it goes through the process and calcuate the optimized portfolio based on the default values of the entries on the left. 
                    User can make any change to the entries as desired and then click the Submit button to recalcuate the portfolio. 
                    Once the Submit button is clicked, this app will performs the following 3 steps."),
                 tags$ol(
                   tags$li("It retrieves the historical monthly return data from Yahoo! based on the ticker symbols and date range provided."),
                   tags$li("It develops a model for the portfolio using the Single Index Model with the Risk Free Rate and Stock Index of the choice."),
                   tags$li("It optimizes the model by finding the allocation of the stocks in the portfolio that maximizes return and minimizes risk, 
                           where risk is defined as the standard deviation of the return.")
                  )
                  
                 )
      )
    )
  )
))