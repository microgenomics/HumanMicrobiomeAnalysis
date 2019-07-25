
################FOR ROC
droc<-read.csv("Data/masterROC.csv", header = T, check.names = F)

#clean S character from species
droc["Species"]<-gsub("S", "", as.matrix(droc["Species"]))
droc["Species"]<-as.numeric(droc$Species)

#clean A character from abundance & change to Depth of Sequencing
colnames(droc)[5]<-"Depth of Sequencing"
droc["Depth of Sequencing"]<-gsub("A", "", as.matrix(droc["Depth of Sequencing"]))

#clean D character from dominance
droc["Dominance"]<-gsub("D", "", as.matrix(droc["Dominance"]))
droc["Dominance"]<-replace(droc["Dominance"],droc["Dominance"]==1,"1 species takes 50% of reads")
droc["Dominance"]<-replace(droc["Dominance"],droc["Dominance"]==10,"10% of species takes 25% of reads")
droc["Dominance"]<-replace(droc["Dominance"],droc["Dominance"]==50,"50% of species takes 80% of reads")
droc["Dominance"]<-replace(droc["Dominance"],droc["Dominance"]==100,"all species have equal read abudance")

#clean R reads
droc["Read Length"]<-gsub("R", "", as.matrix(droc["Read Length"]))

###############FOR RMS
drms<-read.csv("Data/masterRMS.csv", header = T, check.names = F)
drms["Species"]<-gsub("S", "", as.matrix(drms["Species"]))
#clean Abundance -> Depth of Sequencing
colnames(drms)[5]<-"Depth of Sequencing"
drms["Depth of Sequencing"]<-gsub("A", "", as.matrix(drms["Depth of Sequencing"]))
#clean D character from dominance
drms["Dominance"]<-gsub("D", "", as.matrix(drms["Dominance"]))
drms["Dominance"]<-replace(drms["Dominance"],drms["Dominance"]==1,"1 species takes 50% of reads")
drms["Dominance"]<-replace(drms["Dominance"],drms["Dominance"]==10,"10% of species takes 25% of reads")
drms["Dominance"]<-replace(drms["Dominance"],drms["Dominance"]==50,"50% of species takes 80% of reads")
drms["Dominance"]<-replace(drms["Dominance"],drms["Dominance"]==100,"all species have equal read abudance")
drms["Dominance"]<- unlist(drms["Dominance"])
#clean R character from read.length
drms["Read Length"]<-gsub("R", "", as.matrix(drms["Read Length"]))
#colnames(drms)

###############FOR BACILLUS DIFFERENCE
#for complete
dm<-t(read.csv("Data/masterSIMOBScomplete.csv",header = T,stringsAsFactors = F))
colnames(dm)<-dm[1,]
dm<-as.data.frame(t(dm[-1,]))
dm1<-as.data.frame(str_split_fixed(row.names(dm),"_",n = 6))
colnames(dm1)<-c("Organism","Species","Depth of Sequencing","Dominance","Read.Length","Software")
dm<-cbind(dm1,dm)
row.names(dm)<-1:nrow(dm)

dm["Species"]<-gsub("S", "", as.matrix(dm["Species"]))
#clean Abundance -> Depth of Sequencing
dm["Depth of Sequencing"]<-gsub("A", "", as.matrix(dm["Depth of Sequencing"]))
dm["Depth of Sequencing"]<- unlist(dm["Depth of Sequencing"])

dm["Read.Length"]<-gsub("R", "", as.matrix(dm["Read.Length"]))

dm["Dominance"]<-gsub("D", "", as.matrix(dm["Dominance"]))
dm["Dominance"]<-replace(dm["Dominance"],dm["Dominance"]==1,"1 species takes 50% of reads")
dm["Dominance"]<-replace(dm["Dominance"],dm["Dominance"]==10,"10% of species takes 25% of reads")
dm["Dominance"]<-replace(dm["Dominance"],dm["Dominance"]==50,"50% of species takes 80% of reads")
dm["Dominance"]<-replace(dm["Dominance"],dm["Dominance"]==100,"all species have equal read abudance")
dm["Dominance"]<- unlist(dm["Dominance"])

dm<-subset(dm,!grepl("Sigma",dm$Software)) #no Sigma
dm<-subset(dm,!grepl("Constrains",dm$Software)) #no Constrains
dm<-subset(dm,!grepl("MetaMix",dm$Software)) #no MetaMix

#for onemore
dmo<-t(read.csv("Data/masterSIMOBSonemore.csv",header = T,stringsAsFactors = F))
colnames(dmo)<-dmo[1,]
dmo<-as.data.frame(t(dmo[-1,]))
dmo1<-as.data.frame(str_split_fixed(row.names(dmo),"_",n = 6))
colnames(dmo1)<-c("Organism","Species","Depth of Sequencing","Dominance","Read.Length","Software")
dmo<-cbind(dmo1,dmo)
row.names(dmo)<-1:nrow(dmo)

dmo["Species"]<-gsub("S", "", as.matrix(dmo["Species"]))
dmo["Depth of Sequencing"]<-gsub("A", "", as.matrix(dmo["Depth of Sequencing"]))
dmo["Depth of Sequencing"]<- unlist(dmo["Depth of Sequencing"])

dmo["Read.Length"]<-gsub("R", "", as.matrix(dmo["Read.Length"]))

dmo["Dominance"]<-gsub("D", "", as.matrix(dmo["Dominance"]))
dmo["Dominance"]<-replace(dmo["Dominance"],dmo["Dominance"]==1,"1 species takes 50% of reads")
dmo["Dominance"]<-replace(dmo["Dominance"],dmo["Dominance"]==10,"10% of species takes 25% of reads")
dmo["Dominance"]<-replace(dmo["Dominance"],dmo["Dominance"]==50,"50% of species takes 80% of reads")
dmo["Dominance"]<-replace(dmo["Dominance"],dmo["Dominance"]==100,"all species have equal read abudance")
dmo["Dominance"]<- unlist(dmo["Dominance"])

bacillus<-dm[,c("Organism","Species","Depth of Sequencing","Dominance","Read.Length",
                "Software","Bacillus.anthracis","Bacillus.clausii","Bacillus.subtilis")]


drall<-subset(bacillus,grepl("all",bacillus$Read.Length))
bacillus<-subset(bacillus,!grepl("all",bacillus$Read.Length)) #no real data

bacillusOnem<-dmo[,c("Organism","Species","Depth of Sequencing","Dominance","Read.Length",
                     "Software","Bacillus.anthracis","Bacillus.clausii","Bacillus.subtilis")]

drallonem<-subset(bacillusOnem,grepl("all",bacillusOnem$Read.Length))
bacillusOnem<-subset(bacillusOnem,!grepl("all",bacillusOnem$Read.Length)) #no real data


bacillus[,"Depth of Sequencing"]<-replace(bacillus[,"Depth of Sequencing"],bacillus[,"Depth of Sequencing"]=="100000","100 K")
bacillus[,"Depth of Sequencing"]<-replace(bacillus[,"Depth of Sequencing"],bacillus[,"Depth of Sequencing"]=="1000000","1 M")
bacillus[,"Depth of Sequencing"]<-replace(bacillus[,"Depth of Sequencing"],bacillus[,"Depth of Sequencing"]=="10000000","10 M")

bacillusOnem[,"Depth of Sequencing"]<-replace(bacillusOnem[,"Depth of Sequencing"],bacillusOnem[,"Depth of Sequencing"]=="100000","100 K")
bacillusOnem[,"Depth of Sequencing"]<-replace(bacillusOnem[,"Depth of Sequencing"],bacillusOnem[,"Depth of Sequencing"]=="1000000","1 M")
bacillusOnem[,"Depth of Sequencing"]<-replace(bacillusOnem[,"Depth of Sequencing"],bacillusOnem[,"Depth of Sequencing"]=="10000000","10 M")

drall[,"Depth of Sequencing"]<-replace(drall[,"Depth of Sequencing"],drall[,"Depth of Sequencing"]=="100000","100 K")
drall[,"Depth of Sequencing"]<-replace(drall[,"Depth of Sequencing"],drall[,"Depth of Sequencing"]=="1000000","1 M")
drall[,"Depth of Sequencing"]<-replace(drall[,"Depth of Sequencing"],drall[,"Depth of Sequencing"]=="10000000","10 M")

drallonem[,"Depth of Sequencing"]<-replace(drallonem[,"Depth of Sequencing"],drallonem[,"Depth of Sequencing"]=="100000","100 K")
drallonem[,"Depth of Sequencing"]<-replace(drallonem[,"Depth of Sequencing"],drallonem[,"Depth of Sequencing"]=="1000000","1 M")
drallonem[,"Depth of Sequencing"]<-replace(drallonem[,"Depth of Sequencing"],drallonem[,"Depth of Sequencing"]=="10000000","10 M")

drall["Software"] <- "Simulated Value"
drallonem["Software"] <- "Simulated Value"

#to software button
sfb<-as.matrix(unique(bacillusOnem["Software"]))
sfb[sfb==""]<-c("Simulated Value")

##################FOR PCA
simobs<-"Data/masterSIMOBScomplete.csv"
dmpca<-t(read.csv(simobs,header = T, check.names = F))
colnames(dmpca)<-dmpca[1,]
dmpca<-dmpca[-1,]
dfpca<-data.frame(ID=colnames(dmpca))

metadata<-as.data.frame(str_split_fixed(dfpca[,1], "_", 6))
metadata["V7"]<-dfpca$ID
metadata[metadata==''] <- NA
metadata<-as.data.frame(apply(metadata, 2, function(x){replace(x, is.na(x), "Simulated")}))
metadata["V8"]<-ifelse(metadata["V6"]=="Simulated",yes = "Simulated", no="Estimated")
colnames(metadata)<-c("Organism","Species","Depth of Sequencing","Dominance","Read Length","Software","ID_Sample","Value")
#clean S from species
metadata["Species"]<-gsub("S", "", as.matrix(metadata["Species"]))
#clean A from depth of sequencing
metadata["Depth of Sequencing"]<-gsub("A", "", as.matrix(metadata["Depth of Sequencing"]))
#clean D character from dominance
metadata["Dominance"]<-gsub("D", "", as.matrix(metadata["Dominance"]))
metadata["Dominance"]<-replace(metadata["Dominance"],metadata["Dominance"]==1,"1 species takes 50% of reads")
metadata["Dominance"]<-replace(metadata["Dominance"],metadata["Dominance"]==10,"10% of species takes 25% of reads")
metadata["Dominance"]<-replace(metadata["Dominance"],metadata["Dominance"]==50,"50% of species takes 80% of reads")
metadata["Dominance"]<-replace(metadata["Dominance"],metadata["Dominance"]==100,"all species have equal read abudance")
metadata["Dominance"]<- unlist(metadata["Dominance"])
#clean R character from read.length
metadata["Read Length"]<-gsub("R", "", as.matrix(metadata["Read Length"]))
rownames(metadata)<-metadata$ID_Sample

#making pre-physeq ob
otu_table<- read.csv(simobs, header=TRUE, row.names=1)

#################FOR TIME
dftime <- read.csv("Data/masterTIME.csv", header = T)
colnames(dftime)[5]<-"Depth of Sequencing"
#dftime["Depth of Sequencing"]<- as.numeric(dftime$`Depth of Sequencing`)
dftime["Time"]<-(dftime["Time.1"]+dftime["Time.2"])/60/60
#index<-dftime["Time.2"]==0
#dftime[index,"Time.2"]<-dftime[index,"Time.1"]
dftime["Time.1"]<-(dftime["Time.1"]/60/60)
totime<-c(unique(as.matrix(dftime["Software"])))
totimeds<-c(unique(as.matrix(dftime["Depth of Sequencing"])))

######################FOR DATA DOWNLOAD
paths<-read.table("Data/Paths.txt",header = F,sep = "/")
colnames(paths)<-c("Data Base","Organism","Species","Deep Sequence","Dominance","Dataset")


dom2num<-function(x){
  dom<-c()
  for(key in x){
    switch(key,
           `1 species takes 50% of reads`={dom<-c(dom,1)},
           `10% of species takes 25% of reads`={dom<-c(dom,10)},
           `50% of species takes 80% of reads`={dom<-c(dom,50)},
           `all species have equal read abudance`={dom<-c(dom,100)}
    )
  }
  return(dom)
}


#define choices
sp<-unique(droc$Species)
ds<-unique(droc$`Depth of Sequencing`)
dom<-unique(droc$Dominance)
rl<-unique(droc$`Read Length`)
sf<-unique(droc$Software)
fixedcolors<-c("Centrifuge"="#F8766D","Constrains"="#CD9600","Kraken"="#7CAE00","MetaMix"="#00BE67","MetaPhlan2"="#00BFC4","PathoScope2"="#00A9FF","Sigma"="#C77CFF","Taxator"="#FF61CC")
