DownloadUI<- function(id){
  ns <- NS(id)

  tabPanel("Download Data",
          sidebarPanel(
              selectInput(inputId = ns("DataBase"), label="Data Base",
                          choices = c("Complete","OneMore","Depths"),
                          selected = c("Complete")),
          uiOutput(ns("SpeciesQdown")),
          uiOutput(ns("DeepSdown")),
          uiOutput(ns("Dominancedown")),
          uiOutput(ns("ReadLdown"))
          ),
      mainPanel(
        h4("Links to files selected"),
        htmlOutput(ns("files")),
        h5("Please note that different files might have the same file name and thus might be overwritten")
      )
)
}