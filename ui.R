#library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Motor Analysis"),
  
  # Sidebar with a slider input for the number of bins
    
  fluidRow(
    sidebarLayout(
      sidebarPanel(
        numericInput("column",
                    "Select column:",
                    min = 1,
                    max = 86,
                    value = 1)
      ),
      mainPanel(
        plotOutput("distPlot"),
        h4(textOutput("Code")),
        h4(textOutput("Question")),
        h4(textOutput("Type")),
        h4(textOutput("Explain"))
      )
    )
  )
  
))