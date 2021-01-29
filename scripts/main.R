#Sergio López Padilla

#Biorxiv data 
library(jsonlite)
library(tidyverse)
library(kulife)

json_data1 <- fromJSON('/Users/Sergi/Desktop/My folder/UPMthings/1ercuatri/Semantic/FinalProject/data/biorxiv1.json') %>%
  as.data.frame()

json_data2 <- fromJSON('/Users/Sergi/Desktop/My folder/UPMthings/1ercuatri/Semantic/FinalProject/data/biorxiv2.json') %>%
  as.data.frame()

json_data3 <- fromJSON('/Users/Sergi/Desktop/My folder/UPMthings/1ercuatri/Semantic/FinalProject/data/biorxiv3.json') %>%
  as.data.frame()

json_data4 <- fromJSON('/Users/Sergi/Desktop/My folder/UPMthings/1ercuatri/Semantic/FinalProject/data/biorxiv4.json') %>%
  as.data.frame()

biorxiv_data <- rbind(json_data1,json_data2,json_data3,json_data4)
biorxiv_data<- biorxiv_data %>% select (-c(messages.status,messages.cursor,messages.count,messages.total,
                            collection.version))

biorxiv_data$collection.rel_authors <- NULL
biorxiv_data$Disease <- "COVID-19"
write.csv(biorxiv_data, "/Users/Sergi/Desktop/My folder/UPMthings/1ercuatri/Semantic/FinalProject/biorxiv.csv")

#Treatment data
library(readxl)
treatment <- read_excel('/Users/Sergi/Desktop/My folder/UPMthings/1ercuatri/Semantic/FinalProject/data/treatment.xlsx')
View(treatment)

#DrugData
library(webchem)
vctor <- as.vector(unlist(treatment['Substance']))
print(vctor)
cid <- get_cid(vctor, first = TRUE)
cid <- as.data.frame(cid)

cid$cid <- as.integer(cid$cid)
write.table(cid, file = "/Users/Sergi/Desktop/My folder/UPMthings/1ercuatri/Semantic/FinalProject/cidlist.txt",
            row.names = FALSE, col.names = FALSE)

cid2 <- na.omit(cid)
cifinfo <- cid_compinfo(cid2)

#Once the data is downloaded from pubchem:
library(readxl)
pubchemdata <- read_excel("/Users/Sergi/Desktop/My folder/UPMthings/1ercuatri/Semantic/FinalProject/data/pubmeddatacleaned.xls") 

newdf <- merge(cid,pubchemdata, by.x = "cid", by.y = "CID")
newnew <- merge(newdf,treatment, by.x = "query", by.y = "Substance")

write.csv(newnew,"/Users/Sergi/Desktop/My folder/UPMthings/1ercuatri/Semantic/FinalProject/data/treatment_pubchem.csv")
