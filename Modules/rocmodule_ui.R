######################ROC
###############define ROC Inputs
ROCcurveUI <- function(id) {
  ns <- NS(id)
  tabPanel("Sensitivity & Specificity",
           sidebarPanel(
               checkboxGroupInput(inputId=ns("speciesQ"), 
                                  label="Number of species in dataset", 
                                  choices = sp,
                                  selected = sp[1]),

               checkboxGroupInput(inputId=ns("DeepS"), 
                                  label="Sequencing depth", 
                                  choices = c("100 K"="100000","1 M"="1000000","10 M"="10000000"), 
                                  selected = "100000"),

               checkboxGroupInput(inputId=ns("Dominance"), 
                                  label="Dominance scenario", 
                                  choices = dom,
                                  selected = dom[1]),

               selectInput(inputId=ns("ReadL"),  label="Read Length", 
                           choices = c("75","150","300","1000"), selected = "75"),
               

               checkboxGroupInput(inputId=ns("Software"), label="Method", choices = sf, selected = sf),

             sliderInput(inputId = ns("Ylimit"),label = "Y axis limit",min = 0, max = 1, value = c(0,1)),
             downloadButton(ns('downloadROC'), 'Download Plot'),
             tags$br(),tags$br(),
             tags$strong("* MetaMix is not implemented to handle 10M reads")
           ),
           
           mainPanel(
             plotOutput(ns("ROCplot"), width = "900px")
           )
  )
}
