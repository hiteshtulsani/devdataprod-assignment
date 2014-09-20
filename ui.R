library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Basic Regression"),
  sidebarPanel(
    h3('Regression Inputs'),
    selectInput("dataset", "DataSets:",
                choices = c("mtcars", "galton", "diamond")),
    #Dynamic Controls - Varible list based on Dataset selected
    uiOutput("outcomeControl"),    
    uiOutput("predictorControl"),
    p('Source code @ ',
      a('GitHub', href="https://github.com/skahali/devdataprod-assignment", target="_blank"))
  ),
  mainPanel(
    h3("Regression Outcomes"),
    tabsetPanel(
      # Welcome Tab to Get Started and Help Documentations
      tabPanel("Welcome", 
               h3('Welcome to Basic Regression Application'),
               p("This application is part of Coursera Developing Data Product Course"),
               p("The purpose of this application is to helps you do basic exploratory analysis and Regression Analysis."),
               p("This application can be extended to do quick Regression Analysis and get basic idea of data along with any Data Science Activity."),
               h4('Help - How to use this application'),
               h5("Using Application"),
               p(HTML("<ol>"),
                 HTML("<li>From Left Side bar select the DataSet you want to observe.</li>"),
                 HTML("<li>Pick the desired Outcome(Y) variable for that Dataset</li>"),
                 HTML("<li>Pick the desired Predictor(X) variable for Outcome varible.</li>"),
                 HTML("<li>Goto Regression Tab to see the Exploratory Analysis on Data and Best Fit Regression Summary.</li>"),
                 HTML("<li>Goto Data Tab to see the data represented by the Dataset.</li>"),
                 HTML("</ol>")
               ), 
               h5("User Interface Components"),
               p("The Application Layout consists of:"),
               p(HTML("<ol>"),
                 HTML("<li>Side Bar - Regression Input Form</li>"),
                 HTML("<li>Main Panel - Regression Outcomes</li>"),
                 HTML("</ol>")
                 ), 
               h5("Side Bar - Regression Input Form"),
               p("Form to allow you to select Data Set and Variables to do Regression."),
               p(HTML("<table>"),
                 HTML("<tr>"),
                 HTML(" <td><b>DataSets</b></td>"),
                 HTML(" <td>Allows you to select one of the Datasets to do analysis.<br/>Available Choices are: mtcars, galton and diamond</td>"),
                 HTML("</tr>"),
                 HTML("<tr>"),
                 HTML(" <td><b>Select Outcome(Y)</b</td>"),
                 HTML(" <td>The outcome variable for prediction. List is loaded based on DataSet is selected</td>"),
                 HTML("</tr>"),
                 HTML(" <td><b>Select Predictor(X)</b></td>"),
                 HTML(" <td>The variable that predicts the outcome. List is loaded based on DataSet is selected. This list exclude the variable already selected as outcome as variable predicting itself don't make sense.</td>"),
                 HTML("</tr>"),
                 HTML("</table>")
               ), 
               h5("Main Panel - Regression Outcomes"),
               p("The Main Panel is used to display the Regression and Exploratory Analysis done on the selected data. Please see the information on tabs below:"),
               p(HTML("<table>"),
                 HTML("<tr>"),
                 HTML(" <td><b>Welcome</b></td>"),
                 HTML(" <td>Welcome Screen, briefly describing the application and this also contain help/user guide documentation for this application.</td>"),
                 HTML("</tr>"),
                 HTML("<tr>"),
                 HTML(" <td><b>Regression</b</td>"),
                 HTML(" <td>Displays Exploratory Analysis, and Summerizes the Regression From Origin for the Outcome and Predictor variables.</td>"),
                 HTML("</tr>"),
                 HTML(" <td><b>Data</b></td>"),
                 HTML(" <td>Tabular view of the Dataset Selected, So that users can view the data in the dataset.</td>"),
                 HTML("</tr>"),
                 HTML("</table>")
               ) 
               
      ), 
      tabPanel("Regression",
               h4("Exploratory Analysis"),
               plotOutput("histPlot"),
               h4('Summary of Regression Through Origin lm(I(outcome - mean(outcome)) ~ I(predictor - mean(predictor)))'),
               verbatimTextOutput("summary")
      
               ), 
      tabPanel("Data", dataTableOutput("table"))
    )
    
  )
))