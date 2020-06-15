library(gdata)
library(magrittr)

imppc <- gdata::read.xls("IMPPC_DB.xlsx")
head(imppc)

metadata <- read.csv("metadata.csv")
head(metadata)

table(metadata$Distal_or_Proximal)
table(metadata$Distal_or_Proximal,metadata$MSI,useNA = "i")

table(metadata$Distal_or_Proximal,metadata$MSI)[c("p","d"),] %>% chisq.test()

tumors <- subset(metadata,metadata$Type %in% c("CAR","MET"))
tumors$Patient <- as.character(tumors$Patient)
imppc$Patient <- as.character(imppc$Patient)

rownames(imppc) <- imppc$Patient
rownames(tumors) <- tumors$Patient

patients <- tumors$Patient

imppc <- imppc[patients,]

table(tumors$BRAF,imppc$BRAF,useNA = "if")
tumors$BRAF
tumors$KRAS

line1 <- gdata::read.xls("LINE1_summary_Bea.xlsx",2)
head(line1)

rownames(line1) <- line1$Sample

subset(line1, line1$Sample %in% c(paste(tumors$Patient,"T",sep = "")))


foo <- data.frame(Patient=imppc$Patient,imppc=imppc$Age,tumors=tumors$Age)
foo <- data.frame(Patient=imppc$Patient,imppc=imppc$Dukes,tumors=tumors$Dukes) %>% drop.levels


