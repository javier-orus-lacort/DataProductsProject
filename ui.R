library(shiny)

shinyUI(fluidPage(
  
  titlePanel(strong("ANALYSIS OF MILES PER GALLON")),
  
  sidebarLayout(
    sidebarPanel(     
      
      ## We explain here where the Application Documentation can be located in the
      ## same Application Page:
      h3(strong("APPLICATION DOCUMENTATION:")),
      p(strong('Please scroll down to the bottom of this Page and you will find 
               the complete Application Documentation and the Description of 
               the Dataset where this Application is based on.')),

      
      ## Instructions are given here for the User:
      h3(strong("APPLICATION INSTRUCTIONS:")),
      p(strong("Please select here the Variable and the Filter that you wish to 
                apply in your analysis.")),
      p(strong("You can select and change them in whatever order you prefer 
               and as many times as you need:")),
      
      ## Variable Selection
      radioButtons("variable", label = h3(strong("Select the Variable:")),
                   choices = list(
                     "cyl  -- Number of Cylinders" = "cyl",
                     "disp -- Displacement (cu.in.)" = "disp",
                     "hp   -- Gross Horsepower" = "hp",
                     "drat -- Rear Axle Ratio" = "drat",
                     "wt   -- Weight (1000 lbs)" = "wt",        
                     "qsec -- 1/4 Mile Time" = "qsec",
                     "vs   -- V/S" = "vs",  
                     "gear -- Number of Forward Gears" = "gear",
                     "carb -- Number of Carburetors" = "carb"),
                   selected = "wt"),
      
      ## Filter Selection:
      radioButtons("filter", label = h3(strong("Select the Filter:")),
                   choices = list(
                     "All Transmissions" = 2,
                     "Only Automatic Transmissions" = 0,
                     "Only Manual Transmissions" = 1),
                   selected = 2)              
    ),
    
    mainPanel(
      
      ## We show the Selections here:
      h3(strong(textOutput("caption1"))),
      h3(strong(textOutput("caption2"))),
      
      ## We plot the Data and Regression Line according to the Selections here:
      plotOutput("plot"),
      
      ## We show the Regression Line Coefficients here:
      h3(strong("Intercept and Slope of the fitted Regression Line:")),
      verbatimTextOutput("coeff"),
      
      br(),
      
      h3(strong("APPLICATION DOCUMENTATION")),
      p("This Application is based on the", strong("mtcars"), " Dataset, 
        available in the ", strong("datasets"), "package within R."),
      p("The", strong("mtcars"), " Dataset is a data frame with 32 Observations 
        on 11 Variables, recapping technical information for 32 different cars. 
        The variables are:"),
      p(strong("mpg"), ": Miles per Gallon;", 
        strong("cyl"), ": Number of Cylinders;", 
        strong("disp"),": Displacement (cu.in.);",
        strong("hp"),  ": Gross Horsepower;",
        strong("drat"),": Rear Axle Ratio;", 
        strong("wt"),  ": Weight (1000 lbs);",
        strong("qsec"),": 1/4 Mile Time;",
        strong("vs"),  ": V/S;",
        strong("am"),  ": Transmission (0=Automatic, 1=Manual);",
        strong("gear"),": Number of Forward Gears;",
        strong("carb"),": Number of Carburetors."),
      
      p("The Application allows the User to investigate the correlation between 
        Miles per Gallon variable", strong("mpg"), " and other variables in the 
        ", strong("mtcars"), " Dataset, with the possibility of comparing such 
        correlation separately by different Transmission Types too."),
      
      p("The User can do two selections:"),
      
      p("- The variable to be used to compare with Miles per Gallon: This 
        variable is used to plot Miles per Gallon (y-axis) against this variable 
        (x-axis) and, moreover, to fit and plot the Regression Line between them."),
      p("- The Transmission Type filter to consider: This filter is used to 
        consider the whole", strong("mtcars"), " Dataset, or to subset that just 
        to only consider the cases having Automatic or Manual Transmission Types."),
      
      p("Based on both selections done by the User, the Application does the following:"),
      
      p("- It shows the selections done by the User, both Variable and Filter selections."), 
      p("- It plots the selected Data."),
      p("- It plots the corresponding Regression Line for the selected Data."),
      p("- It shows the Intercept and Slope of the fitted Regression Line afterwards.")
      
    )
  )
))
