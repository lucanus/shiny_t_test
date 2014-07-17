shinyUI(
        navbarPage(h1("Test t", style='color:magenta'),
                   
                # this is the First Panel of the page
                tabPanel(h3("Read Data"),
                         
                fluidPage(
                
                fluidRow(   # first row
                        column(4,
                               fileInput("file", h3("Select the data file",
                                                    style='color:red'),
                                         accept=c('text/csv',
                                                  'text/comma-separated-values',
                                                  'text/plain', '.csv'))
                        ),
                        column(8,
                               helpText(
                                   h4("Variables must be stored in columns:
                                           one column for each variable."),
                                   h4("This app treats only the first two
                                          columns:"),
                                   h4("- first column stores the variable X;"),
                                   h4("- second column stores the variable Y."),
                                   h3("If necessary rearrange your file."),
                                   style='color:red'
                                   )
                        )),  # first row end 
                        
                fluidRow(   # second row
                        column(4,
                               radioButtons("sep",
                                            h4("Choose the field separator character",
                                               style='color:blue'),
                                            c("blank" = " ",
                                              "tab" = "\t",
                                              "comma" = ",",
                                              "semicolon" = ";"))
                        ),
                        column(4,
                               checkboxInput("header",
                                             h4("Tick off if there is a header",
                                                style='color:blue'), FALSE)
                               
                        )), # second row end
                
                fluidRow(   # third row
                        column(12,
                               tableOutput('table1')
                         ))  # third row end
                )),  # First Panel end
                
                # this is the Second Panel of the page
                tabPanel(h3("Test options and Summary"),
                
                fluidPage(
                
                fluidRow(  # first row
                        column(3,
                               h4("mean of X"),
                               textOutput('m1')
                        ),
                        column(3,
                               h4("mean of Y"),
                               textOutput('m2')
                        )), # first row end
                
                br(),
                
                fluidRow(  # second row
                        column(3,
                               h4("std deviation of X"),
                               textOutput('sd1')
                        ),
                        column(3,
                               h4("std deviation of Y"),
                               textOutput('sd2')
                        )),  # second row end
                
                br(),
                
                fluidRow(  # third row
                        column(12, h3("Set up the test options",
                                      style='color:red'), align='center'
                        )
                ),
                
                fluidRow(  # fourth row
                        column(4,
                               radioButtons("sample", h4("One/Two Sample",
                                                         style='color:blue'),
                                            c("One Sample"="one",
                                              "Two Sample"="two")),
                               helpText(
                                       h6("One-Sample test is always performed
                                          on mean(X)."),
                                       h6("Two-Sample test is performed on
                                          mean(X) minus mean(Y)."),
                                       style='color:red'
                                       )
                        ),
                        
                        column(4,
                               textInput("mu", h4("Mean Null Hypothesis",
                                                  style='color:blue'), 0),
                               helpText(
                                       h6("Specify the value of the Null
                                          Hypothesis."),
                                       h6("For Two-Sample test, the value 0 of
                                          Null Hypothesis is equivalent to
                                          hypothesize mean(X) = mean(Y)."),
                                       style='color:red'
                               )
                        ),
                        
                        column(4,
                               radioButtons("altern",h4("Alternative",
                                                        style='color:blue'),
                                            c("Two Sided"="two.sided",
                                              "Less"="less",
                                              "Greater"="greater")),
                               helpText(
                                       h6("For Two-Sample test and value 0 of
                                          Null Hypothesis, \"Less\" corresponds
                                          to an Alternative Hypothesis
                                          of mean(X) < mean(Y)."),
                                       style='color:red'
                               )
                        )
                ),  # fourth row end
                
                br(),
                
                fluidRow(  # fifth row
                        column(4,
                               radioButtons("paired", h4("Paired",
                                                         style='color:blue'),
                                            c("FALSE"="FALSE",
                                              "TRUE"="TRUE")),
                               helpText(
                                       h6("Tick off TRUE if X and Y are
                                          referred to a same variable in two 
                                          different times (eg. before and after
                                          a treatment)."), style='color:red'
                               )
                        ),
                        
                        column(4,
                               radioButtons("var", h4("Equal Variance",
                                                      style='color:blue'),
                                            c("TRUE"="TRUE",
                                              "FALSE"="FALSE"))
                        ),
                        
                        column(3,
                               sliderInput("conf", h4("Confidence Level",
                                                      style='color:blue'), min=0.5,
                                           max=1, value=0.95, step=0.01),
                               helpText(
                                       h6("State the Confidence Level for the
                                          Confidence Interval of the mean."),
                                       style='color:red'
                               )
                        )
                        
                ),  # fifth row end
                
                fluidRow(  # sixth row
                        column(12, h3("Click PLAY to run", align='center',
                                     style='color:green'),
                               actionButton("button", h4("PLAY",
                                                        style="color:green")),
                               align='center'
                        )
                ),  # sixth row end

                br(),
                
                fluidRow(  # seventh
                        column(4,
                               h4("Value of t-statistics"),
                               textOutput('statistic')
                        ),
                        
                        column(4,
                              h4("Value of p-value"),
                              textOutput('pvalue')
                        ),
                        
                        column(4,
                              h4("Confidence interval limits"),
                              textOutput('interval')
                        )
                ),  # seventh row end
                
                br(),
                
                fluidRow(  # eighth row
                        column(12,
                               plotOutput("plot1"))
                )   # eighth row end
                
                )) # Second Panel end
))
