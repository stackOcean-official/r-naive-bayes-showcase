# TODO set working directory

# Load packages
library(shiny)
library(shinythemes)
library(dplyr)
library(readr)


# set port for shiny server
options(shiny.port = 8000)
options(shiny.host = "0.0.0.0")

# Load model and data
model_nb = readRDS("model/model.rds")
train_features = read.csv("./data/featurenames.csv")


# Define UI
ui <- fluidPage(theme = shinytheme("lumen"),
                titlePanel("Kommtarauswertung und Retourengründe"),
                sidebarLayout(
                  sidebarPanel(
                    
                    #Textinput with default text
                    textInput(inputId = "comment", label = "Schreib einen Kommentar", value = "Die Schuhe sind zu klein")
                  ),
                  
                  # Output: Prediction which topic the comment is mostlikely related to.
                  mainPanel(
                    textOutput(outputId = "predict"),
                    tags$a(href = "https://stackocean.com", "provided by stackOcean", target = "_blank")
                  )
                )
)

# Define server function
server <- function(input, output) {
  
  # Pull in prediction depending on input factors
  output$predict <- renderText({
    toks_test = tokens(corpus(input$comment), remove_punct = TRUE, remove_number = TRUE) %>% 
      tokens_remove(pattern = stopwords("de")) %>% 
      tokens_wordstem()
    dfmat_test = dfm(toks_test)
    dfmat_matched = dfm_match(dfmat_test, features = unlist(train_features))
    trend_text = predict(model_nb, newdata = dfmat_matched, type = "probability")
    paste(trend_text)
  })
}

# Create Shiny object
shinyApp(ui = ui, server = server)
