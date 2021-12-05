#name Daniel Persson
#2021-12-01
#R-script of the Exercise 5 - continuing to modify the human data  


  library(stringr)
  library(tidyr)
  library(dplyr)
  
  
  # read the human data
  human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)
  
  # look at the (column) names of human
  names(human)
  
  # look at the structure of human
  str(human$GNI)
  
  # print out summaries of the variables
  summary(human)
  
  
  # 1. Mutate the data: transform the Gross National Income (GNI) variable to numeric:
  
  # remove the commas from GNI and print out a numeric version of it
  GNI_num <- str_replace(human$GNI, pattern=",", replace ="")
  
  #mutating the human data by first dropping original variable 'GNI' from the dataset
  human <- dplyr::select(human, -GNI)
  
  #and secondly byadding the numeric version 
  human <- human %>% dplyr::mutate(GNI = GNI_num)
  

  # 2. Exclude unneeded variables: keep only the columns matching the following variable names (described in the meta file above):
  #"Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"  
  # columns to keep
  keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
  
  # select the 'keep' columns
  human <- dplyr::select(human, one_of(keep))
  
  
  # 3. Remove all rows with missing values:
  # print out a completeness indicator of the 'human' data
  complete.cases(human)
  
  # print out the data along with a completeness indicator as the last column
  data.frame(human[-1], comp = complete.cases(human))
  
  # filter out all rows with NA values
  human_ <- filter(human, complete.cases(human))
  
  
  # look at the last 10 observations
  tail(human_, 10)
  
  #4.Remove the observations which relate to regions instead of countries
  # last indice we want to keep
  last <- nrow(human_) - 7
  
  # choose everything until the last 7 observations
  human_ <- human_[1:last, ]
  
  
  # 5. Define the row names of the data by the country names and remove the country name column from the data:
  # add countries as rownames
  rownames(human_) <- human_$Country
  
  # removing country variable 
  human_ <- select(human_, -Country)
  
  # checking that the wrangling is done successfully 
  str(human_)

  #human_ saved as CSF
  write.csv(human_, file = "data/human_.csv", row.names = TRUE)  
  
  #reload human_ as human_2 to see if saved correctly 
  human_2 <- read.csv("data/human_.csv", row.names = 1)
  