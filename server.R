library(shiny)
library(UsingR)
shinyServer(
  function(input, output) {
    #Load the Appropriate Dataset
    datasetInput <- reactive({
      switch(input$dataset,
             "mtcars" = mtcars,
             "galton" = galton,
             "diamond" = diamond)
    })

    # Return the outcome column data from the dataset
    outcomeVar <- reactive({
      datasetInput()[,names(datasetInput()) == input$outcomeInput]
    })

    # Set the outcome column to Origin
    outcomeOrigin <- reactive({
      outcomeVar() - mean(outcomeVar())
    })
    
    # Set the predictor column to Origin
    predictorVar <- reactive({
      datasetInput()[,names(datasetInput()) == input$predictorInput]
    })

    # Return the predictor column data from the dataset
    predictorOrigin <- reactive({
      predictorVar() - mean(predictorVar())
    })
    
    # Fit the Predictor and Outcome Through Origin 
    fitOriginVar <- reactive({
      lm(I(outcomeOrigin())~ I(predictorOrigin()) - 1)
    })
    
    
    # Generate the Title text for Main Panel
    output$dataTitle = renderText("Main Output")
    
    # Generate a Datatable for View Tab, so that user can view the selected dataset data.
    # customize the length drop-down menu; display 10 rows per page by default
    output$table = renderDataTable({
      datasetInput()
    }, options = list(aLengthMenu = c(5,10, 25, 50), iDisplayLength = 5))
    
    
    # Generate a Outcome variable list
    output$outcomeControl <- renderUI({
      selectInput("outcomeInput", "Select Outcome(Y)", names(datasetInput()))
    })
    
    # Generate a predictor variable list
    # And Discard the Variable selected as out come
    output$predictorControl <- renderUI({
      predList <- names(datasetInput())
      predList <- predList[predList != input$outcomeInput]
      selectInput("predictorInput", 
                  "Select Predictor(X)", predList)
    })
    
    # Generate a multiple select predictor variable list, if we want to do multiple regression
    # in future
#     output$multipleControl <- renderUI({
#       #checkboxGroupInput("predictorInput", "Choose Cities", cities)
#       checkboxGroupInput("multipleInput", "Choose Multiple", names(datasetInput()))
#     })
    
    # Generate a summary of fit through origin
    output$summary <- renderPrint({
      summary(fitOriginVar())
    })
    # Generate a plot 
    output$histPlot <- renderPlot({
      freqData <- as.data.frame(table(outcomeVar(), predictorVar()))
      par(mfrow=c(2,2))
      # Histogram Outcome
      hist(outcomeVar(), 
           xlab = input$outcomeInput, 
           main = paste("Histogram of Outcome"),
           col="blue",breaks=100)
      
      # Histogram Predictor
      hist(predictorVar(), 
           xlab = input$outcomeInput, 
           main = paste("Histogram of Predictor"),
           col="blue",breaks=100)    
      
      # Plot Outcome and Predictor 
      plot(predictorVar(),outcomeVar(),
           xlab = input$predictorInput,
           ylab = input$outcomeInput,
           main = paste("Compare Outcome vs Predictor"),
           pch = 21, col = "black", bg = "lightblue",
           cex = .15 * freqData$freq)
      
      # Plot Outcome and Predictor with Best Fit
      plot(predictorVar(),outcomeVar(),
           xlab = input$predictorInput,
           ylab = input$outcomeInput,
           main = paste("Visualize Best Fit Line"),
           pch = 21, col = "black", bg = "lightblue",
           cex = .05 * freqData$freq 
           )
      lm1 <- lm(outcomeVar() ~ predictorVar())
      lines(predictorVar(),lm1$fitted,col="red",lwd=3)
      
      })
    
  }
)
