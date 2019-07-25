TimeUI <- function(id) {
  ns <- NS(id)
tabPanel("Real Computing Time/TPR",
         sidebarPanel(
             selectInput(inputId = ns("TimeTPR"), label = "Variable to Plot",
                         choices = c("Time","True Positive Rate"),
                         selected = c("Time")),

             checkboxGroupInput(inputId=ns("Softwaret"), label="Method",
                                choices = totime, selected = totime),

           downloadButton(ns('downloadTime'), 'Download Plot')
         ),
         mainPanel(
           plotOutput(ns("Time"), height = "600px", width = "900px")
         )
)
}