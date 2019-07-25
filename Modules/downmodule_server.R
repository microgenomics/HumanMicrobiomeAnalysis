DOWNMSERVER<- function(input, output, session){
  ns<-session$ns
##########################Download Data
######define ui
output$SpeciesQdown<- renderUI({
  if(input$DataBase == "Depths"){
    checkboxGroupInput(inputId=ns("SpeciesQdown"), 
                       label="Number of Species", 
                       choices = c("426"),
                       selected = c("426"))
  }else{
    checkboxGroupInput(inputId=ns("SpeciesQdown"), 
                       label="Number of Species", 
                       choices = sp,
                       selected = sp[1])
  }
  
})
output$DeepSdown<- renderUI({
  if(input$DataBase == "Depths"){
    checkboxGroupInput(inputId=ns("DeepSdown"), 
                       label="Depth of Sequencing", 
                       choices = totimeds,
                       selected = totimeds[1])
  }else{
    checkboxGroupInput(inputId=ns("DeepSdown"), 
                       label="Depth of Sequencing", 
                       choices = ds,
                       selected = ds[1])
  }
})
output$Dominancedown<- renderUI({
  if(input$DataBase == "Depths"){
    checkboxGroupInput(inputId=ns("Dominancedown"), 
                       label="Dominance", 
                       choices = c("10% of species takes 25% of reads"),
                       selected = c("10% of species takes 25% of reads"))  
  }else{
    checkboxGroupInput(inputId=ns("Dominancedown"), 
                       label="Dominance", 
                       choices = dom,
                       selected = dom[1])  
  }
  
})
output$ReadLdown<- renderUI({
  if(input$DataBase == "Depths"){
    checkboxGroupInput(inputId=ns("ReadLdown"), 
                       label="Read Length", 
                       choices = c("150"),
                       selected = c("150"))
  }else{
    checkboxGroupInput(inputId=ns("ReadLdown"), 
                       label="Read Length", 
                       choices = rl,
                       selected = rl[length(rl)])  
  }
  
})

reactPath<- reactive({
  if(is.null(input$DataBase)){
    return(NULL)
  }
  switch(input$DataBase,
         Complete={indown<-c("Simulation")},
         OneMore={indown<-c("SimulationOneMore")},
         Depths={indown<-c("SimulationDeeps")}
  )
  sample<-subset(paths, `Data Base` %in% indown)
  
  indown<-paste("species_",input$SpeciesQdown,sep = "")
  sample<-subset(sample, Species %in% indown)
  
  indown<-paste("abundance_",input$DeepSdown,"",sep = "")
  sample<-subset(sample, `Deep Sequence` %in% indown)
  
  indown<-dom2num(input$Dominancedown)
  indown<-paste("dominance_",indown,sep = "")
  sample<-subset(sample, Dominance %in% indown)
  
  indown<-paste("dataset_A",input$DeepSdown,sep="")
  keyindown<-indown
  for(key in keyindown){
    for(read in input$ReadLdown){
      indown<-c(indown,paste(keyindown,"_R",read,sep = ""))
    }
    
  }
  sample<-subset(sample, Dataset %in% indown)
  sample<-paste(sample[,1],sample[,2],sample[,3],sample[,4],sample[,5],
                sample[,6],sample[,6], sep = "/")
  sample<-c(paste(sample,".1.tar.gz",sep = ""),paste(sample,".2.tar.gz",sep = ""))
  return(sample)
})

output$files <- renderPrint({
  if(is.null(reactPath())){
    return(NULL)
  }
  
  links<-c("asdasd","nnvxcvxc","rteter")
  links<-paste(":",reactPath(),sep="/")
  cat(links,"\n")
  
})
}