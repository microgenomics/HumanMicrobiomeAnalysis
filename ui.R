library(shiny)
library(shinythemes)
library(stringr)
source("Modules/internalVariables.R")
source("Modules/rocmodule_ui.R")
source("Modules/rlmodule_ui.R")
source("Modules/semodule_ui.R")
source("Modules/pcamodule_ui.R")
#source("Modules/gamodule_ui.R")
source("Modules/timemodule_ui.R")
#source("Modules/downmodule_ui.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("paper"),
  shinyUI(navbarPage("Evaluation of Methods for Human Microbiome Analysis", fluid=TRUE,
    ROCcurveUI("rocmodule"),
    ReadLengthUI("rlmodule"),
    StandardErrorUI("semodule"),
    PCAUI("pcamodule"),
    #GENOMEABSENTUI("gamodule"),
    TimeUI("timemodule")
    #DownloadUI("downloadmodule")

  ))
))
