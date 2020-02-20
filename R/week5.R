# R Studio API Code
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Data Import
library(tidyverse)
Adata_tbl <- read_delim(file = "../data/Aparticipants.dat",delim="-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
Anotes_tbl <- read_csv(file = "../data/Anotes.csv")
Bdata_tbl <- read_tsv(file = "../data/Bparticipants.dat", col_names = c("casenum", "parnum", "stimver", "datadate", "q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8", "q9", "q10"))
Bnotes_tbl <- read_tsv(file = "../data/Bnotes.txt")

# Data Cleaning
Adata_tbl <- separate(Adata_tbl, qs,into= c("q1", "q2", "q3", "q4", "q5"), sep=" - ") %>%
  mutate_at(vars(starts_with("q")), as.numeric) %>% 
  mutate(datadate = as.POSIXct(datadate, format="%B %d %Y, %H:%M:%S"))
  

Aaggr_tbl <- mutate(Adata_tbl, mean = rowMeans(select(Adata_tbl, starts_with("q")))) %>% 
  select(parnum, stimver, mean) %>% 
  spread(stimver, mean)
Baggr_tbl <- mutate(Bdata_tbl, mean = rowMeans(select(Bdata_tbl, starts_with("q")))) %>% 
  select(parnum, stimver, mean) %>% 
  spread(stimver, mean)
 #Lines24-25: Using a join, add participant notes to each of your newlyaggregated tbls as a new column called notes.

