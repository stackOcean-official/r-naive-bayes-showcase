# TODO set working directory

# Load packages
library(shiny)
library(shinythemes)
library(dplyr)
library(readr)

#to implement in shinygedöns
input = c("die schuhe sind zu klein")
toks_test = tokens(corpus(input), remove_punct = TRUE, remove_number = TRUE) %>% 
  tokens_remove(pattern = stopwords("de")) %>% 
  tokens_wordstem()
dfmat_test = dfm(toks_test)

train_features = read.csv("./data/featurenames.csv")
dfmat_matched = dfm_match(dfmat_test, features = unlist(train_features))
predicted_class = predict(model_nb, newdata = dfmat_matched, type = "probability")

# set port for shiny server
options(shiny.port = 8000)
options(shiny.host = "0.0.0.0")

# Load model
lin_mod = readRDS("model/model.rds")

# Define UI
ui <- fluidPage(theme = shinytheme("lumen"),
                titlePanel("Comment topic prediciton"),
                sidebarLayout(
                  sidebarPanel(
                    
                    # Select whether it's weekend - does nothing at the moment because weekday not part of lin_mod
                    checkboxInput(inputId = "weekend", label = strong("Is it weekend?"), value = FALSE),
                    
                    # slider to adjust sun minutes, wind speed and maximum temperature
                    sliderInput(inputId = "sun", label = "Sun minutes:", min = 0, max = 1440, value = 50, step = 10, animate = animationOptions(interval = 100)),
                    sliderInput(inputId = "wind", label = "Windspeed:", min = 0, max = 63, value = 8, step = 1, animate = animationOptions(interval = 100)),
                    sliderInput(inputId = "temp", label = "Maximun Temperature:",min = 0, max = 50, value = 20, step = 1, animate = animationOptions(interval = 100))
                  ),
                  
                  # Output: Prediction how many sun chairs will be needed.
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
    trend_text <- round(predict(lin_mod, data.frame(max_temp = input$temp, sun_mins = input$sun, wspd = input$wind, weekend = input$weekend)))
    paste(trend_text, "beach chairs need to be set up today. This is only a demo. The data were randomly generated and the prediction does not necessarily make sense.")
  })
}

# Create Shiny object
shinyApp(ui = ui, server = server)