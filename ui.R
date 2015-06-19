library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("mtcars prediction (mpg ~ hp + am)"),

  # Sidebar with a slider input for horsepower
  sidebarLayout(
    sidebarPanel(
      h5("Input variables for prediction"),
      sliderInput("hp",
                  "Gross horsepower:",
                  min = 20,
                  max = 500,
                  value = 150),
      selectInput("am", label = h5("Transmission"), 
                         choices = list("Automatic/0" = 0, "Manual/1" = 1), selected = 1)
      #,submitButton('Submit')
      
    ),

    # Show a numeric value for the prediction and a plot 
    mainPanel(
      
      p("This application allows you to predict the miles per gallon using the type of transmission and gross horsepower as inputs."),
      p("You have to choose both variables from the left panel"),
      p("Use the slider to select the input gross horsepower and the select button to select the type of transmission and the select button to select the type of transmission"),
      p("As a result, you will see in the right panel the estimated mpg values for those variables and a plot representing the original data and a red point for the estimated values."),
      
      br(),
      strong(textOutput("prediction")),
      br(),
      br(),
      plotOutput("fitPlot"),
      p("The blue line is the regression using only horsepower without the transmission variable."),
      p("The red point is the estimated miles per gallon using both horsepower and transmission.")
      
      
    )
  )
))
