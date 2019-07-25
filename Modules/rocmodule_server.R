ROCMSERVER<- function(input, output, session){
  ns<-session$ns

###############Plot ROC
  rocvariables<-reactiveValues(plot=NULL)
  
reactSampleRoc <- reactive({
  if(is.null(input$ReadL)){return()}
  sample<-subset(droc, Species %in% input$speciesQ)
  
  sample<-subset(sample, `Depth of Sequencing` %in% input$DeepS)
  
  sample<-subset(sample, Dominance %in% input$Dominance)
  sample<-sample[c(which(sample["Read Length"] == input$ReadL)),]
  sample<-subset(sample, Software %in% input$Software)
  colnames(sample)[8]<-c("Method")
  sample$`Read Length`<-as.factor(as.numeric(sample$`Read Length`))
  return(sample)
})

output$ROCplot <- renderPlot({
  if(is.null(reactSampleRoc())){
    return()
  }
  rocvariables$plot<- p <- ggplot(data = reactSampleRoc(), aes(x=FPR, y=TPR, colour=Method, shape=Dominance)) +
    theme_minimal() +
    scale_shape(solid = FALSE) +
    geom_point(aes(size=`Depth of Sequencing`)) +
    ggtitle("Number of Species") + xlab("\nFalse Positive Rate") + ylab("True Positive Rate\n") +
    ylim(input$Ylimit) +
    
    theme(plot.title = element_text(colour = "darkred",size=14,face = "bold",hjust = 0.5),
          axis.title.x = element_text(colour = "darkred", size=14,face = "bold"),
          axis.title.y = element_text(colour = "darkred", size=14,face = "bold"),
          legend.title = element_text(colour = "darkred", size=14,face = "bold")) + 
    scale_colour_manual(values = fixedcolors) +
    scale_size_discrete(labels=c("100000"="100 k","1000000"="1 M","10000000"="10 M")) +
    labs(size="Depth of Sequencing") + facet_wrap(~ Species) + 
    theme(strip.text.x = element_text(colour="darkred",face="bold",size=14))
  
  
  rocvariables$plot
})
output$downloadROC <- downloadHandler(
  filename = function() {paste("ROC-",Sys.Date(),".pdf",sep="")},
  content = function(file) {
    
    ggsave(file, plot=rocvariables$plot, device = "pdf",width = 15,height = 8)
  }
)
}