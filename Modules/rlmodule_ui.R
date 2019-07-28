ReadLengthUI <- function(id) {
  ns <- NS(id)
  tabPanel("Read Length",
         sidebarPanel(
           
            checkboxGroupInput(inputId=ns("speciesQrl"), label="Number of species in dataset", 
                                choices = sp,selected = sp[1]),
            checkboxGroupInput(inputId=ns("DeepSrl"), label="Depth of Sequencing", 
                                 choices = c("100 K"="100000","1 M"="1000000","10 M"="10000000"),
                               selected = "100000"),

            selectInput(inputId=ns("Dominancerl"), label="Dominance scenario", 
                          choices = dom, selected = dom[1]),

            checkboxGroupInput(inputId=ns("ReadLrl"), label="Read Length", 
                                 choices = c("75","150","300","1000"), selected = "75"),

            checkboxGroupInput(inputId=ns("Softwarerl"), label="Method",
                                 choices = sf, selected = sf),
            sliderInput(inputId = ns("Xlimitrl"),label = "X axis limit",min = 0, max = 1, value = c(0,1)),
            sliderInput(inputId = ns("Ylimitrl"), label = "Y axis limit", min = 0, max = 1, value = c(0,1)),
           
           downloadButton(ns('downloadROCrl'), 'Download Plot')
         ),
         
         mainPanel(
           plotOutput(ns("ROCplotrl"), width = "900px")
         )
)
}