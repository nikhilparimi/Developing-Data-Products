library(shiny)
x_values <- seq(3, 18, by = 0.1)
y_values <- -0.5 * x_values^2 + 10 * x_values - 18
set.seed(123)
noise <- rnorm(length(y_values), mean = 0, sd = 1)
y_noisy <- y_values + noise
data <- data.frame(x = x_values, y = y_noisy)
data$x2 <- (data$x)^2

shinyServer(function(input, output) {
  fit_linear <- lm(y~x, data = data)
  fit_quad <- lm(y~x+x2, data = data)
  
  linear_pred <- reactive({
    x_input <- input$slider_x
    predict(fit_linear, newdata = data.frame(x = x_input))
  })
  
  quadratic_pred <- reactive({
    x_input <- input$slider_x
    predict(fit_quad, newdata = data.frame(x = x_input, x2 = x_input^2))
  })
  
  
  output$plot1 <- renderPlot({
    x_input <- input$slider_x
    
    plot(data$x, data$y, xlab = "x", 
         ylab = "y", pch = 16)
    if(input$show_linear){
      abline(fit_linear, col = "red", lwd = 2)
    }
    if(input$show_quadratic){
      predicted_vals <- predict(fit_quad,list(x=data$x, x2=data$x2))
      lines(data$x, predicted_vals, col = "blue", lwd = 2)
    }
    legend("topright", c("Linear Fit", "Quadratic Fit"), col = c("red", "blue"), lwd = 2, bty = "n", cex = 1.2)
    points(x_input, linear_pred(), col = "red", pch = 16, cex = 2)
    points(x_input, quadratic_pred(), col = "blue", pch = 16, cex = 2)
  })
  
  output$linear <- renderText({
    paste("Y = ", round(linear_pred(), 2))
  })
  
  output$quadratic <- renderText({
    paste("Y = ", round(quadratic_pred(), 2))
  })
  
  output$expected <- renderText({
    x_input <- input$slider_x
    y_val <- -0.5 * x_input^2 + 10 * x_input - 18
    paste("Y = ", round(y_val, 2))
  })
})