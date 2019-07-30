library(ggplot2)
library(reshape2)
library(phyloseq)
library(plyr)
source("Modules/rocmodule_server.R")
source("Modules/rlmodule_server.R")
source("Modules/semodule_server.R")
source("Modules/pcamodule_server.R")
source("Modules/gamodule_server.R")
source("Modules/timemodule_server.R")
#source("Modules/downmodule_server.R")

shinyServer(function(input, output) {

  callModule(ROCMSERVER, "rocmodule")
  callModule(RLMSERVER, "rlmodule")
  callModule(SEMSERVER, "semodule")
  callModule(PCAMSERVER, "pcamodule")
  callModule(GAMSERVER, "gamodule")
  callModule(TIMEMSERVER, "timemodule")
  #callModoule(DOWNMSERVER, "downloadmodule")

  
 
  
})
