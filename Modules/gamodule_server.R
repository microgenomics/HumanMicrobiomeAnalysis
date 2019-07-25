GAMSERVER<- function(input, output, session){
  ns<-session$ns
####################################BACILLUS DIFFERENCE
#################define ui
reactSampleBacd <- reactive({
  
  ###set conditions
  #species
  
  bacillus<-subset(bacillus, Species %in% input$SpeciesQb)
  bacillusOnem<-subset(bacillusOnem,Species %in% input$SpeciesQb)
  drall<-subset(drall,Species %in% input$SpeciesQb)
  drallonem<-subset(drallonem,Species %in% input$SpeciesQb)
  #dominance
  bacillus<-subset(bacillus, Dominance %in% input$Dominanceb)
  bacillusOnem<-subset(bacillusOnem, Dominance %in% input$Dominanceb)
  drall<-subset(drall, Dominance %in% input$Dominanceb)
  drallonem<-subset(drallonem, Dominance %in% input$Dominanceb)
  #Depth of Sequencing
  bacillus<-subset(bacillus, `Depth of Sequencing` %in% input$DeepSb)
  bacillusOnem<-subset(bacillusOnem, `Depth of Sequencing` %in% input$DeepSb)
  drall<-subset(drall,`Depth of Sequencing` %in% input$DeepSb)
  drallonem<-subset(drallonem,`Depth of Sequencing` %in% input$DeepSb)
  #read length
  bacillus<-bacillus[c(which(bacillus["Read Length"] == input$ReadLb)),]
  bacillusOnem<-bacillusOnem[c(which(bacillusOnem["Read Length"] == input$ReadLb)),]
  #software
  bacillus<-subset(bacillus,Software %in% input$Softwareb)
  bacillusOnem<-subset(bacillusOnem,Software %in% input$Softwareb)
  
  bacillus<-rbind(bacillus,drall)
  bacillusOnem<-rbind(bacillusOnem,drallonem)
  
  bacillus$Bacillus.anthracis<-as.numeric(as.character(bacillus$Bacillus.anthracis))
  bacillusOnem$Bacillus.anthracis<-as.numeric(as.character(bacillusOnem$Bacillus.anthracis))
  bacillus$Bacillus.subtilis<-as.numeric(as.character(bacillus$Bacillus.subtilis))
  bacillusOnem$Bacillus.subtilis<-as.numeric(as.character(bacillusOnem$Bacillus.subtilis))
  bacillus$Bacillus.clausii<-as.numeric(as.character(bacillus$Bacillus.clausii))
  bacillusOnem$Bacillus.clausii<-as.numeric(as.character(bacillusOnem$Bacillus.clausii))
  
  colnames(bacillus)[7]<-"Bacillus anthracis"
  colnames(bacillus)[8]<-"Bacillus clausii"
  colnames(bacillus)[9]<-"Bacillus subtilis"
  
  colnames(bacillusOnem)[7]<-"Bacillus anthracis"
  colnames(bacillusOnem)[8]<-"Bacillus clausii"
  colnames(bacillusOnem)[9]<-"Bacillus subtilis"
  
  
  bacillus["Database"]<-"All genomes present"
  bacillusOnem["Database"]<-"Bacillus cereus not in database"
  
  df<-merge(bacillus,bacillusOnem,all=T)
  
  df.m<-melt(df)
  colnames(df.m)<-c("Kingdom","Species","Depth of Sequencing","Dominance",
                    "Read Length","Method","Database","Organism","value")
  return(df.m)
})
output$Bacd <- renderPlot({
  if(is.null(reactSampleBacd())){
    return()
  }
  p<-ggplot(reactSampleBacd(), 
            aes(x=Method, y=value, color=Organism,shape=Database, size=`Depth of Sequencing`)) + 
    geom_point() + scale_shape(solid = FALSE) + scale_y_log10() +
    xlab("\nMethod") + ylab("Read Count (Log10 scale)\n") +
    theme(plot.title = element_text(colour = "darkred",size=14,face = "bold",hjust = 0.5),
          axis.title.x = element_text(colour = "darkred", size=14,face = "bold"),
          axis.title.y = element_text(colour = "darkred", size=14,face = "bold"),
          legend.title = element_text(colour = "darkred", size=14,face = "bold"),
          legend.text = element_text(face="oblique")) +
    labs(size="Depth of Sequencing")
  p + facet_wrap(~ Dominance) + theme(strip.text.x = element_text(colour="darkred",face="bold",size=15))
})
output$downloadBacillus <- downloadHandler(
  filename = function() {paste("BacillusDiff-",Sys.Date(),".pdf",sep="")},
  content = function(file) {
    p<-ggplot(reactSampleBacd(), 
              aes(x=Method, y=value, 
                  color=Organism,shape=Database, size=`Depth of Sequencing`)) + 
      geom_point() + scale_shape(solid = FALSE) + scale_y_log10() +
      ggtitle("Bacillus difference\n") + xlab("\nMethod") + ylab("Reads count (log10)\n") +
      theme(plot.title = element_text(colour = "darkred",size=14,face = "bold",hjust = 0.5),
            axis.title.x = element_text(colour = "darkred", size=14,face = "bold"),
            axis.title.y = element_text(colour = "darkred", size=14,face = "bold"),
            legend.title = element_text(colour = "darkred", size=14,face = "bold"))
    p<-p + facet_wrap(~ Dominance) + theme(strip.text.x = element_text(colour="darkred",face="bold",size=15))
    ggsave(file,plot=p,device = "pdf",width = 15,height = 10)
  }
)
}