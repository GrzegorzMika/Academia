#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Ideas
# 1. Change mean and variance to be more user-friendly -> defined via +- some number of elements
# 2. possibility to  change the value in "more than 0"
# 3. unclear descriptions of fields
# 4. Nicer GUI?


# Define UI for application that draws a histogram
shinyUI(
  pageWithSidebar(
    headerPanel("Stock Management"),
    sidebarPanel(
      numericInput("n", "Number of components (history)", 30,
        min = 1, max = 100
      ),
      numericInput("y", "Number of broken components (history)", 3,
        min = 1, max = 100
      ),
      numericInput("n_tilde", "Number of components", 10,
        min = 1, max = 100
      ),
      numericInput("n_stock", "Number of components in stock", 0,
        min = 1, max = 100
      ),
      sliderInput("mean_prior",
        "Mean prior:",
        value = 0.5,
        min = 0,
        max = 1
      ),
      sliderInput("var_prior",
        "Variance prior:",
        value = 0.1,
        min = 0,
        max = 0.25
      )
    ),
    mainPanel(
      plotOutput("PosteriorPred"),
      textOutput("text1")
    )
  )
)
