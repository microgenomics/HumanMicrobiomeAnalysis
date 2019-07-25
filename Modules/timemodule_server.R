TIMEMSERVER <-function(input, output, session){
  ns<-session$ns
##########################Time
######define ui
timevariables<-reactiveValues(plot=NULL)
reactSampleTime <- reactive({
  sample<-subset(dftime, Software %in% input$Softwaret)
  colnames(sample)[8]<-"Method"
  return(sample)
})
output$Time <- renderPlot({
  if(input$TimeTPR=="Time"){
    timevariables$plot<-ggplot(reactSampleTime(), aes(x=`Depth of Sequencing`, y=Time, colour=Method)) +
      geom_line(size=1) + 
      theme_minimal() +
      scale_y_log10() +
      ggtitle("Time over Depth of Sequencing\n") + ylab("Time log(hours)\n") +
      theme(plot.title = element_text(colour = "darkred",size=14,face = "bold",hjust = 0.5),
            axis.text.x = element_text(angle = 40),
            axis.title.x = element_text(colour = "darkred", size=14,face = "bold"),
            axis.title.y = element_text(colour = "darkred", size=14,face = "bold"),
            legend.title = element_text(colour = "darkred", size=14,face = "bold"))+ 
      scale_colour_manual(values = fixedcolors) +
      labs(x="Depth of Sequencing")
  }else{
    timevariables$plot<-ggplot(reactSampleTime(), aes(x=`Depth of Sequencing`, y=TPR, colour=Method)) +
      geom_line(size=1) +
      theme_minimal() +
      ggtitle("True Positive Rate over Depth of Sequencing\n") + ylab("True Positive Rate\n") +
      theme(plot.title = element_text(colour = "darkred",size=14,face = "bold",hjust = 0.5),
            axis.text.x = element_text(angle = 40),
            axis.title.x = element_text(colour = "darkred", size=14,face = "bold"),
            axis.title.y = element_text(colour = "darkred", size=14,face = "bold"),
            legend.title = element_text(colour = "darkred", size=14,face = "bold")) + 
      scale_colour_manual(values = fixedcolors) + ylim(0,1) +
      labs(x="Depth of Sequencing")
    
  }
  
  timevariables$plot
  
})
output$downloadTime <- downloadHandler(
  filename = function() {paste0("Real_Computing",Sys.Date(),".pdf")},
  content = function(file) {
    ggsave(file,plot=timevariables$plot,device = "pdf",width = 10,height = 8)
  }
)
}