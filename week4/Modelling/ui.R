library(shiny)
shinyUI(fluidPage(
  titlePanel("Modelling using the correct formula"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider_x", "Choose of a value of X to predict", 3, 18, value = 10, step = 0.1),
      checkboxInput("show_linear", "Show/Hide Linear Fit", value = TRUE),
      checkboxInput("show_quadratic", "Show/Hide Quadratic Fit", value = TRUE),
    ),
    mainPanel(
      plotOutput("plot1"),
      h4("Expected Value:"),
      textOutput("expected"),
      h4("Quadratic fit prediction:"),
      textOutput("quadratic"),
      h4("Linear fit prediction:"),
      textOutput("linear")
    )
  )
))