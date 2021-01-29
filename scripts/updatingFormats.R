#Script to adjust datatypes
#COVJSI

library(readxl)

biorxiv <-  read_excel("data.xls", sheet = "biorxiv csv")
treatment <- read_excel("data.xls", sheet = "treatments")
genprot <- read_excel("data.xls", sheet = "genprots")


str(biorxiv)
str(genprot)
str(treatment)

#biorxiv sheet
biorxiv$Rel_date <- as.Date(biorxiv$Rel_date)
biorxiv$NumberOfAuthors <- as.integer(biorxiv$NumberOfAuthors)

#genprot sheet
genprot$proteinMass <- as.integer(genprot$proteinMass)
genprot$proteinLength <- as.integer(genprot$proteinLength)
genprot$isoelectricPoint <- as.numeric(genprot$isoelectricPoint)

#treatment
treatment$MW <- as.integer(treatment$MW)
treatment$`Number of references` <- as.integer(treatment$`Number of references`)
treatment$Date <- as.Date(treatment$Date)
treatment$`Latest publication`<-  as.Date(treatment$`Latest publication`, "%m/%d/%Y")
treatment$`Latest database update`<-  as.Date(treatment$`Latest database update`, "%m/%d/%Y")

#writing files
library(xlsx)
install.packages('xlsx')
write.xlsx(biorxiv, "biorxiv1.xlsx")
write.xlsx(genprot, "genprot1.xlsx")
write.xlsx(treatment, "treatment1.xlsx")
