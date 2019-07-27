PCAUI <- function(id) {
  ns <- NS(id)
  tabPanel("PCA",
         sidebarPanel(
           selectInput(inputId = ns("ReadLpca"), label = "Read Length",
                       choices = rl, selected = rl[length(rl)]),
           
             selectInput(inputId = ns("SpeciesQpca"), label="Number of species in dataset",
                         choices = sp, selected = sp[1]),

             selectInput(inputId = ns("DeepSpca"), label = "Sequencing depth",
                         choices = c("100 K"="100000","1 M"="1000000","10 M"="10000000"), 
                         selected = "10000000"),

             checkboxGroupInput(inputId = ns("Dompca"), label = "Dominance scenario",
                                choices = dom, selected = c(dom[1],dom[2])),



             checkboxGroupInput(inputId=ns("Softwarepca"), label="Method",
                                choices = sf, selected = sf),
 
           downloadButton(ns('downloadpca'), 'Download Plot'),
           tags$br(),tags$br(),
           tags$strong("* MetaMix is not implemented to handle 10M reads")
         ),
         mainPanel(
           plotOutput(ns("PCAxsoft"),height = "750px", width = "900px")
         )
)
}