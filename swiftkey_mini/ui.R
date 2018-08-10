#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
# Author       Vasudevan Durairaj 
# Date         09/August/2018 

suppressPackageStartupMessages(
    c(library(shiny),
      library(markdown)
    ))

# Define UI for application that predicts Next Word 
shinyUI(navbarPage("Swiftkey Mini App",
                   tabPanel("Predict the Next Word",
                            # Sidebar
                            sidebarLayout(
                                sidebarPanel(
                                    helpText("Type in a partially complete sentence to begin the next word prediction"),
                                    textInput("inputString", "Type in partial sentence here",value = ""),
                                    br(),
                                    br(),
                                    br(),
                                    br()
                                ),
                                mainPanel(
                                    h2("Possible Next Word"),
                                    verbatimTextOutput("prediction"),
                                    strong("Inputted Text:"),
                                    tags$style(type='text/css', '#text1 {background-color: rgba(255,255,0,0.40); color: black;}'), 
                                    textOutput('text1'),
                                    br(),
                                    strong("Prediction Model:"),
                                    tags$style(type='text/css', '#text2 {background-color: rgba(255,255,0,0.40); color: blue;}'),
                                    textOutput('text2')
                                )
                            )
                            
                   ),
                   tabPanel("About the Application",
                            mainPanel(
                                   includeMarkdown("AboutApp.html")
                            )
                   )
)
)