library(shiny)

#diabetesRisk <- function(glucose) glucose /200
ozone <- function(Solar.R, Wind, Temp){
        y = -64.34208 +  0.05982*Solar.R - 3.33359*Wind + 1.65209*Temp
        return(y)
}
shinyServer(
        function(input, output){
                output$inputValue1 <- renderPrint({input$Solar.R})
                output$inputValue2 <- renderPrint({input$Wind})
                output$inputValue3 <- renderPrint({input$Temp})
                output$prediction <- renderPrint({ozone(input$Solar.R, 
                                                        input$Wind,
                                                        input$Temp)})
        }
        )