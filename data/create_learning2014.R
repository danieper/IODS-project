#Daniel Persson
#2021-11-09
#Data wrangling exercise 2 IODS

#loading library for later usage
library(dplyr)


#Loading the data file
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE, stringsAsFactors = TRUE)

#Investigate the structure of the data
str(learning2014)


#Investigate the dimensions of the data
dim(learning2014)

#To create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points the mutate function is used
#instead of individually sum the variables is two steps.
#E.g. Mutate funtion:
#data <- data %>%
#  dplyr::mutate(new_var = var1 + var2 + var3)

#Additon of the deep, stra and surf as new mean variables using above argument
learning2014 <- learning2014 %>%
  dplyr::mutate(deep = (D03 + D11 + D19 + D27 + D07 + D14 + D22 + D30 + D06 + D15 + D23 + D31)/12)

learning2014 <- learning2014 %>%
  dplyr::mutate(stra = (ST01 + ST09 + ST17 + ST25 + ST04 + ST12 + ST20 + ST28)/8)

learning2014 <- learning2014 %>%
  dplyr::mutate(surf = (SU02 + SU10 + SU18 + SU26 + SU05 + SU13 + SU21 + SU29 + SU08 + SU16 + SU24 + SU32)/12)

#calculating the mean of attitude by dividing the sum of the 10 questions with 10
learning2014 <- learning2014 %>%
  dplyr::mutate(Attitude = Attitude/10)

#making the column name consistent
learning2014 <- learning2014 %>%
  dplyr::rename("age" = "Age")

learning2014 <- learning2014 %>%
  dplyr::rename("points" = "Points")

learning2014 <- learning2014 %>%
  dplyr::rename("attitude" = "Attitude")


#Define relevant headers for filtering
header_subset <- c("gender", "age", "attitude", "deep", "stra", "surf", "points")

#Selecting the subset from the data containing one of the headers
learning2014_subset <- select(learning2014, one_of(header_subset))

str(learning2014_subset)


learning2014_subset <- filter(learning2014_subset, points > 0)

str(learning2014_subset)

# Setting Working Directory
setwd("C:/IODS/IODS-project")
getwd()

#save the table as CSF
write.csv(learning2014_subset, file = "data/learning2014_subset.csv", row.names = FALSE)

#reload the csv file
learning2014_subset <- read.csv("data/learning2014_subset.csv")

#checking the structure
str(learning2014_subset)
head(learning2014_subset)
