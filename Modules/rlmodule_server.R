RLMSERVER<- function(input, output, session){
  ns<-session$ns
  
  rlvariable<-reactiveValues(plot=NULL)
  reactSampleRocrl <- reactive({

    sample<-subset(droc, Species %in% input$speciesQrl)
    sample<-subset(sample, `Depth of Sequencing` %in% input$DeepSrl)
    sample<-subset(sample, `Read Length` %in% input$ReadLrl)
    sample<-subset(sample, Dominance %in% input$Dominancerl)
    sample<-subset(sample, Software %in% input$Softwarerl)
    colnames(sample)[8]<-"Method"
    sample$`Read Length`<-as.factor(as.numeric(sample$`Read Length`))
    return(sample)
})

output$ROCplotrl <- renderPlot({
  if(nrow(reactSampleRocrl())==0){
    return()
  }

  rlvariable$plot<- ggplot(data = reactSampleRocrl(), aes(x=FPR, y=TPR, colour=Method, shape=`Read Length`)) +
    scale_shape(solid = FALSE) + theme_minimal() +
    geom_point(aes(size=`Depth of Sequencing`)) +
    ggtitle("Number of Species") + xlab("\nFalse Positive Rate") + ylab("True Positive Rate\n") +
    ylim(input$Ylimitrl) +
    scale_fill_manual(values = c("red", "green", "blue"), guide = guide_legend(reverse = TRUE)) +
    scale_size_discrete(labels=c("100000"="100 k","1000000"="1 M","10000000"="10 M")) +
    
    theme(plot.title = element_text(colour = "darkred",size=14,face = "bold",hjust = 0.5),
          axis.title.x = element_text(colour = "darkred", size=14,face = "bold"),
          axis.title.y = element_text(colour = "darkred", size=14,face = "bold"),
          legend.title = element_text(colour = "darkred", size=14,face = "bold")) + 
    scale_colour_manual(values = fixedcolors) +
    labs(shape = "Read Length", size="Depth of Sequencing") + 
    facet_wrap(~ Species) + theme(strip.text.x = element_text(colour="darkred",face="bold",size=14))
  rlvariable$plot
})
output$downloadROCrl <- downloadHandler(
  filename = function() {paste("RLROC-",Sys.Date(),".pdf",sep="")},
  content = function(file) {
    ggsave(file,plot=rlvariable$plot,device = "pdf",width = 15,height = 8)
  }
)
}