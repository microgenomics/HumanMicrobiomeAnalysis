SEMSERVER<- function(input, output, session){
  ns<-session$ns
  
####################################RELATIVE ROOT MEAN SQUARE
sevariables<-reactiveValues(plotxdom=NULL, plotxsof=NULL)
reactSampleRMS <- reactive({
  sample<-subset(drms, Species %in% input$speciesQrms)
  sample<-subset(sample, `Depth of Sequencing` %in% input$DeepSrms)
  sample<-subset(sample, Dominance %in% input$Dominancerms)
  sample<-sample[c(which(sample["Read Length"] == input$ReadLrms)),]
  sample<-subset(sample, Software %in% input$Softwarerms)
  colnames(sample)[8]<-"Method"
  return(sample)
  
})
output$RRMSEplot <- renderPlot({
  sevariables$plotxdom <- ggplot(data = reactSampleRMS(), aes(x=RRMSE, y=AVGRE, color=Method, shape=Species)) +
    scale_shape(solid = FALSE) + theme_minimal() +
    geom_point(aes(size=`Depth of Sequencing`)) +
    xlim(input$Xlimit) + ylim(0,2) +
    ggtitle("Error according to dominance\n") + xlab("\nRRMSE") + ylab("AVGRE\n") +
    theme(plot.title = element_text(colour = "darkred",size=15,face = "bold",hjust = 0.5),
          axis.title.x = element_text(colour = "darkred", size=15,face = "bold"),
          axis.title.y = element_text(colour = "darkred", size=15,face = "bold"),
          legend.title = element_text(colour = "darkred", size=15,face = "bold"))+ 
    scale_colour_manual(values = fixedcolors) +
    scale_size_discrete(labels=c("100000"="100 k","1000000"="1 M","10000000"="10 M")) +
    labs(size="Depth of Sequencing") +
    facet_wrap(~ Dominance) + theme(strip.text.x = element_text(colour="darkred",face="bold",size=15))
  sevariables$plotxdom
  
})
output$RRMSExsoft <- renderPlot({
  if(is.null(reactSampleRMS())){
    return()
  }
  sevariables$plotxsof <- ggplot(data=reactSampleRMS(), aes(x=Method, y=RRMSE, color=Dominance, shape=Species)) + 
    geom_jitter(aes(size=`Depth of Sequencing`)) + ylim(input$Xlimit) + theme_minimal() +
    ggtitle("\nError according to Software\n") + xlab("\nMethod") + ylab("RRMSE\n") +
    theme(plot.title = element_text(colour = "darkred",size=15,face = "bold", hjust = 0.5),
          axis.title.x = element_text(colour = "darkred", size=15,face = "bold"),
          axis.title.y = element_text(colour = "darkred", size=15,face = "bold"),
          legend.title = element_text(colour = "darkred", size=15,face = "bold")) +
    scale_size_discrete(labels=c("100000"="100 k","1000000"="1 M","10000000"="10 M")) +
    labs(size="Depth of Sequencing")
  sevariables$plotxsof
  
})
output$downloadRRMSE <- downloadHandler(
  filename = function() {paste("RRMSE1-",Sys.Date(),".pdf",sep="")},
  content = function(file) {

    ggsave(file,plot=sevariables$plotxdom,device = "pdf",width = 15,height = 8)
  }
)
output$downloadRRMSE2 <- downloadHandler(
  filename = function() {paste("RRMSE2-",Sys.Date(),".pdf",sep="")},
  content = function(file) {
    ggsave(file,plot=sevariables$plotxsof,device = "pdf",width = 15,height = 8)
  }
)
}