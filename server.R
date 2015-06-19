library(shiny)

# Define server logic required
shinyServer(function(input, output) {

  library(datasets)
  
  fit <- lm(mpg ~ hp + factor(am), data=mtcars)
  # Using reactive function in order not to calculate twice the prediction value.
  prediction <- reactive ({predict(object = fit, newdata = data.frame(hp=input$hp,am=factor(input$am)))})
  
  # Application to predict a value for mpg (miles per gallon) in the library datasets
  # The inputs are 2 vaiables:
  # - hp: gross horsepower
  # - am: Transmission 0:automatic, 1:manua
  # The application calculates the estimated mpg and writes up the value and it also 
  # plot the calculated point in a plot with the other points in the data.frame 
  
  output$fitPlot <- renderPlot({
    
    library(ggplot2)
      
    g <- ggplot(data=mtcars,aes(y=mpg,x=hp)) + geom_point() 
    g <- g + stat_smooth(aes(group=1),method="lm")
    g <- g + geom_point(data=data.frame(x=c(input$hp),y=c(prediction())),aes(y=y,x=x), color="red",size = 4) 
    g
      
  })
  output$text1 <- renderText({ 
    paste("You have selected", input$hp)
  })
  output$prediction <- renderText({ 
    
    paste("The predicted miles per gallon for ", input$hp," gross horsepower and transmission ",input$am," is: ",round(prediction(),2),"mpg")
  })
})

