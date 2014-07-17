shinyServer(
        function(input, output) {
                data<- reactive({
                                inFile<- input$file
                                if (is.null(inFile))
                                        return(NULL)
                                read.table(inFile$datapath,
                                           header=input$header,
                                           sep = input$sep)
                        })
                
                output$table1<- renderTable({data()
                })
                
                output$m1<- renderText({
                                if(is.null(data())) return(NULL)
                                mean(data()[,1])
                })
                
                output$sd1<- renderText({
                                if(is.null(data())) return(NULL)
                                sd(data()[,1])
                })
                
                output$m2<- renderText({
                                if(is.null(data()[,2])) return(NULL)
                                mean(data()[,2])
                })
                
                output$sd2<- renderText({
                                if(is.null(data()[,2])) return(NULL)
                                sd(data()[,2])
                })
                
                test<- reactive({
                               if(is.null(data()[,1])) return(NULL) 
                               validate(  # not run before clicking PLAY button
                               need(input$button,"")
                               )
                                  t.test(
                                      x=data()[,1],
                                      if(input$sample=="two") y=data()[,2],
                                      alternative=input$altern,
                                      mu=as.numeric(input$mu),
                                      paired=as.logical(input$paired),
                                      var.equal=as.logical(input$var),
                                      conf.level=as.numeric(input$conf))
                })
                
                
                output$statistic<- renderText({
                                        input$button
                                        isolate(
                                               test()$statistic
                                        )
                })
                
                output$pvalue<- renderText({
                                        input$button
                                        isolate(
                                            test()$p.value
                                        )
                })
                
                output$interval<- renderText({
                                        input$button
                                        isolate(
                                              test()$conf.int
                                        )
                })
                
                output$plot1<- renderPlot({
                                    input$button
                                    isolate({
                                                
                                        if(is.null(data())) return(NULL)
                                        n<- length(data()[,1])
                                            par(bg="seashell")
                                            curve(dt(x,n-1),-3.5,3.5,
                                                  main="p-value (in red)",
                                                  cex.main=2, lwd=3, col='blue',
                                                  ylab="Density", cex.lab=1.5,
                                                  xlab="Student-t distribution",
                                                  las=1, asp=4)
                                            abline(h=0)

                                        if( abs(test()$statistic) <= 3.5){
                                            
                                          if(input$altern=="two.sided") {
                                             xx<- c(seq(abs(test()$statistic),
                                                        3.5,by=0.01), 3.5,
                                                    abs(test()$statistic))
                                             m<- length(xx)
                                             polygon(xx,
                                                     c(dt(xx[1:(m-2)],
                                                          n-1),0,0),
                                                     col='red')
                                             yy<- c(seq(-abs(test()$statistic),
                                                        -3.5,by=-0.01), -3.5,
                                                        -abs(test()$statistic))
                                             polygon(yy,
                                                     c(dt(yy[1:(m-2)],n-1),0,0),
                                                     col='red')
                                             curve(dt(x,n-1),-3.5,3.5,lwd=3,
                                                   col='blue', add=T)
                                            }
                                            else if(input$altern=="greater") {
                                                 xx<- c(seq(test()$statistic,
                                                            3.5,by=0.01),3.5,
                                                        test()$statistic)
                                                 m<- length(xx)
                                                 polygon(xx,
                                                         c(dt(xx[1:(m-2)],n-1),
                                                           0,0),
                                                         col='red')
                                                 curve(dt(x,n-1),-3.5,3.5,lwd=3,
                                                       col='blue', add=T)
                                          }
                                          else if(input$altern=="less") {
                                                 xx<- c(seq(test()$statistic,
                                                            -3.5,by=-0.01),
                                                        -3.5,test()$statistic)
                                                 m<- length(xx)
                                                 polygon(xx,
                                                         c(dt(xx[1:(m-2)],n-1),
                                                           0,0),
                                                         col='red')
                                                 curve(dt(x,n-1),-3.5,3.5,lwd=3,
                                                       col='blue', add=T)
                                          }
                                        }
                                        
                                        else { 
                                            if(input$altern=="less") {
                                               xx<- c(seq(-3.5,3.5,by=0.01),
                                                      3.5,-3.5)
                                               m<- length(xx)
                                               polygon(xx,
                                                       c(dt(xx[1:(m-2)],n-1),
                                                         0,0),
                                                       col='red')
                                               curve(dt(x,n-1),-3.5,3.5,lwd=3,
                                                     col='blue', add=T)
                                            }
                                            else return(NULL)
                                        }
                                        
                                    }) # end isolate()
                })

                                        
        })