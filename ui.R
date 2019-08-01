library(shiny)
library(shinythemes)
library(stringr)
source("Modules/internalVariables.R")
source("Modules/rocmodule_ui.R")
source("Modules/rlmodule_ui.R")
source("Modules/semodule_ui.R")
source("Modules/pcamodule_ui.R")
source("Modules/gamodule_ui.R")
source("Modules/timemodule_ui.R")
#source("Modules/downmodule_ui.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("paper"),
  shinyUI(navbarPage("Evaluation of Methods for Human Microbiome Analysis", fluid=TRUE,
    ROCcurveUI("rocmodule"),
    ReadLengthUI("rlmodule"),
    StandardErrorUI("semodule"),
    PCAUI("pcamodule"),
    GENOMEABSENTUI("gamodule"),
    TimeUI("timemodule")
    #DownloadUI("downloadmodule")

  )),
  hr(),
  fluidRow(
    column(width=1),
    column(width=11,
           tags$strong("* MetaMix is not implemented to handle 10M reads"),tags$br(),
           tags$h6("Software used references:"),tags$br(),
           tags$strong("Centrifuge"),": Kim, D., Song, L., Breitwieser, F. P., & Salzberg, S. L. (2016). Centrifuge: rapid and sensitive classification of metagenomic sequences. Genome Research, 26(12), 1721–1729. https://doi.org/10.1101/gr.210641.116",tags$br(),
           tags$strong("Kraken"),": Wood, Derrick E., and Steven L. Salzberg. 2014. “Kraken: Ultrafast Metagenomic Sequence Classification Using Exact Alignments.” Genome Biology 15(3): R46. https://doi.org/10.1186/gb-2014-15-3-r46 (July 28, 2019).", tags$br(),
           tags$strong("Contrains"),": Luo, C., Knight, R., Siljander, H., Knip, M., Xavier, R. J., & Gevers, D. (2015). ConStrains identifies microbial strains in metagenomic datasets. Nature Biotechnology, 33(10), 1045–1052. https://doi.org/10.1038/nbt.3319", tags$br(),
           tags$strong("MetaPhlan2"),": Truong, D. T., Franzosa, E. A., Tickle, T. L., Scholz, M., Weingart, G., Pasolli, E., … Segata, N. (2015). MetaPhlAn2 for enhanced metagenomic taxonomic profiling. Nature Methods, 12(10), 902–903. https://doi.org/10.1038/nmeth.3589", tags$br(),
           tags$strong("MetaMix"),": Morfopoulou, S., & Plagnol, V. (2015). Bayesian mixture analysis for metagenomic community profiling. Bioinformatics, 31(18), 2930–2938. https://doi.org/10.1093/bioinformatics/btv317", tags$br(),
           tags$strong("PathoScope2"),": Hong, C., Manimaran, S., Shen, Y., Perez-Rogers, J. F., Byrd, A. L., Castro-Nallar, E., … Johnson, W. E. (2014). PathoScope 2.0: a complete computational framework for strain identification in environmental or clinical sequencing samples. Microbiome, 2(1), 33. https://doi.org/10.1186/2049-2618-2-33", tags$br(),
           tags$strong("Sigma"),": Siddharthan, R. (2006). Sigma: multiple alignment of weakly-conserved non-coding DNA sequence. BMC Bioinformatics, 7(1), 143. https://doi.org/10.1186/1471-2105-7-143", tags$br(),
           tags$strong("Taxator-tk"),": Dröge, J., Gregor, I., & McHardy, A. C. (2015). Taxator-tk: precise taxonomic assignment of metagenomes by fast approximation of evolutionary neighborhoods. Bioinformatics, 31(6), 817–824. https://doi.org/10.1093/bioinformatics/btu745"
           
           )
  )
))
