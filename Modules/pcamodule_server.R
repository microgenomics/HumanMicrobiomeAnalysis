PCAMSERVER<- function(input, output, session){
  ns<-session$ns
  pcavariables<-reactiveValues(plot=NULL)
  reactSamplePCA <- reactive({
    sample<-subset(metadata, `Read Length` == input$ReadLpca)

    sample<-subset(sample, Species %in% input$SpeciesQpca)

    sample<-subset(sample, `Depth of Sequencing` %in% input$DeepSpca)
    sample[,"Depth of Sequencing"]<-replace(sample[,"Depth of Sequencing"],sample[,"Depth of Sequencing"]=="100000","100 K")
    sample[,"Depth of Sequencing"]<-replace(sample[,"Depth of Sequencing"],sample[,"Depth of Sequencing"]=="1000000","1 M")
    sample[,"Depth of Sequencing"]<-replace(sample[,"Depth of Sequencing"],sample[,"Depth of Sequencing"]=="10000000","10 M")
    sample<-subset(sample, Dominance %in% input$Dompca)
    sample<-subset(sample, Software %in% input$Softwarepca)
    
    simu<-subset(metadata, `Read Length` == "all")
    simu<-subset(simu, Species %in% input$SpeciesQpca)
    simu<-subset(simu, `Depth of Sequencing` %in% input$DeepSpca)
    simu[,"Depth of Sequencing"]<-replace(simu[,"Depth of Sequencing"],simu[,"Depth of Sequencing"]=="100000","100 K")
    simu[,"Depth of Sequencing"]<-replace(simu[,"Depth of Sequencing"],simu[,"Depth of Sequencing"]=="1000000","1 M")
    simu[,"Depth of Sequencing"]<-replace(simu[,"Depth of Sequencing"],simu[,"Depth of Sequencing"]=="10000000","10 M")
    simu<-subset(simu, Dominance %in% input$Dompca)

    
    for (i in input$Softwarepca){
      simu["Software"]<-i
      sample<- rbind(sample,simu)
    }
    otumat<- t(otu_table)
    otu_table<-as.matrix(otu_table)
    rownames(otumat) <- paste0("OTU", 1:nrow(otumat))
    taxmat <- matrix(sample(letters, 1, replace = TRUE), nrow = nrow(otumat), ncol = 7)
    colnames(taxmat) <- c("Domain", "Phylum", "Class", "Order", "Family", "Genus", "Species")
    rownames(taxmat) <- rownames(otumat)
    
    sofnum<-length(input$Softwarepca)
    if(sofnum>1){
      real<-sample[grep("_Rall",sample$ID_Sample),]
      realrow<-row.names(real[real["Software"]==input$Softwarepca[1],])
      subotumat<-otumat[,realrow]
      for(i in input$Softwarepca[-1]){
        tmprow<-row.names(real[real["Software"]==i,])
        colnames(subotumat)<-tmprow
        otumat<-cbind(otumat,subotumat)
      }
    }

    sample$Software <- factor(sample$Software, levels=names(fixedcolors))
    
    OTU = otu_table(otumat, taxa_are_rows = TRUE)
    TAX = tax_table(taxmat)
    physeq = phyloseq(OTU, TAX, sample_data(sample))
    
    return(physeq)
  })
  output$PCAxsoft <- renderPlot({
    physeq<-reactSamplePCA()
    phydist<-distance(physeq,"jaccard")
    phyord<-ordinate(physeq, "MDS", distance = phydist)
    pcavariables$plot <- plot_ordination(physeq, phyord, color="Dominance" ,shape = "Value") +
      geom_point(size=5) +
      ggtitle("Jaccard Index\n") +
      theme(plot.title = element_text(colour = "darkred",size=16,face = "bold",hjust = 0.5),
            axis.title.x = element_text(colour = "darkred", size=15,face = "bold"),
            axis.title.y = element_text(colour = "darkred", size=15,face = "bold"),
            legend.title = element_text(colour = "darkred", size=15,face = "bold")) +
      labs(color="Dominance scenario") + 
      facet_wrap(~ Software,) + 
      theme(strip.text.x = element_text(colour="darkred",face="bold",size=15))
    
    pcavariables$plot
  })
  output$downloadpca <- downloadHandler(
    filename = function() {paste("PCA-","Sp",input$SpeciesQpca,"Depth",
                                 input$DeepSpca,"ReadL",input$ReadLpca,"-",
                                 Sys.Date(),".pdf",sep="")},
    content = function(file) {
      ggsave(file,plot=pcavariables$plot,device = "pdf",width = 10,height = 8)
    }
  )
}