GENOMEABSENTUI <- function(id) {
  ns <- NS(id)
tabPanel("Genome Absent in DB",
         sidebarPanel(
           checkboxGroupInput(inputId=ns("SpeciesQb"),  label="Number of Species", 
                              choices = sp, selected = sp[length(sp)]),
           
           checkboxGroupInput(inputId=ns("DeepSb"), label="Depth of Sequencing", 
                              choices = c("100 K"="100000","1 M"="1000000","10 M"="10000000"), 
                              selected = "10000000"),
           
           checkboxGroupInput(inputId=ns("Dominanceb"), label="Dominance", 
                              choices = dom, selected = dom[1]),
           
           selectInput(inputId=ns("ReadLb"), label="Read Length", 
                       choices = rl, selected = rl[length(rl)]),
           
           checkboxGroupInput(inputId=ns("Softwareb"), label="Method",
                              choices = sfb, selected = sfb),

           downloadButton(ns('downloadBacillus'),'Download Plot')
         ),
         mainPanel(
           plotOutput("Bacd",height = "600px")
         )
)
}