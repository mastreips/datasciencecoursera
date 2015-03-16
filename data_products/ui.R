library(shiny)

shinyUI(pageWithSidebar(
        
        headerPanel("Ozone Prediction"),
        
        
        sidebarPanel(
                numericInput("Solar.R", 'Solar Radiation (Langleys) (Min=20 Max=340)', 
                             207, min=20, max =340, step=20),
             
                numericInput("Wind", 'Wind (mph) (Min=2, Max=20)', 9, min=2, max =20, step=5),
                numericInput("Temp", 'Temp (degrees F) (Min=50, Max=100)', 79, min=50, max =100, step=5),
                submitButton('Submit')
                ),

        
        mainPanel(
                h3('Instructions'),
                p('This linear model predicts the amount of Ozone in parts per billion in New York
                  City based on three parameters: Solar Radiation, Wind and Temperature.  The model 
                  uses default values of Solar.R (207), Wind (9) and Temp (79) which can be changed
                  by entering a number between the designated Min and Max for each parameter. Values
                  can also be incremented using the "up" and "down" arrows in each field. Once you 
                  have entered in the values you wish to use in the prediction model press the 
                  "Submit" button. The parameter values will be submitted to the shiny server to
                  run the prediction model, the results of which will be displayed under the " Results
                  of Prediction" section of this web page, along with the parameter values that
                  were submitted.'),
                tags$br(),
                h4('You entered Solar Radition:'),
                verbatimTextOutput("inputValue1"),
                h4('You entered Wind:'),
                verbatimTextOutput("inputValue2"), 
                h4('You entered Temp:'),
                verbatimTextOutput("inputValue3"),
                h4('Which resulted in a prediction of NYC Mean Ozone PPB '),
                verbatimTextOutput("prediction"),
                
                tags$br(),
                h4('Model and Source'),
                p('The model is y = -64.34208 +  0.05982*Solar.R - 3.33359*Wind + 1.65209*Temp'),
                p('R-sqaured = 0.6059, Adj R-squared = 0.5948'),
                p('The data were obtained from the New York State Department of Conservation (ozone data)
                  and the National Weather Service (meteorological data).'),
                
                tags$br(),
                h4('References'),
                p('Chambers, J. M., Cleveland, W. S., Kleiner, B. and Tukey, P. A. (1983)
                Graphical Methods for Data Analysis. CA: Wadsworth.')
                
                )
        
        
        ))

