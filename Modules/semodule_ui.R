StandardErrorUI <- function(id) {
  ns <- NS(id)
  tabPanel("Standard Error",
         sidebarPanel(
             checkboxGroupInput(inputId=ns("speciesQrms"), label="Number of Species", 
                                choices = sp, selected = sp[1]),

             checkboxGroupInput(inputId=ns("DeepSrms"), label="Depth of Sequencing", 
                                choices = c("100 K"="100000","1 M"="1000000","10 M"="10000000"),
                                selected = "100000"),

             checkboxGroupInput(inputId=ns("Dominancerms"), label="Dominance", 
                                choices = dom, selected = dom[1]),

             selectInput(inputId=ns("ReadLrms"),  label="Read Length", choices = rl, selected = rl[length(rl)]),

             checkboxGroupInput(inputId=ns("Softwarerms"), label="Method", choices = sf, selected = sf),

           sliderInput(inputId = ns("Xlimit"),label = "X axis limit", min = 0, max = 2, value = c(0,2) ),
           downloadButton(ns('downloadRRMSE'), 'Download Plot 1'),
           downloadButton(ns('downloadRRMSE2'), 'Download Plot 2')
         ),
         mainPanel(
           plotOutput(ns("RRMSEplot"), width = "900px"),
           plotOutput(ns("RRMSExsoft"), width = "900px")
         )
  )
}