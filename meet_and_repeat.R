#name Daniel Persson
#2021-12-11
#R-script of the Exercise 6 - meet and repeat 

library(dplyr)
library(tidyr)

#Reading the “BPRS” and “RATS” datas into R
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep="", header=TRUE)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep="", header=TRUE)

#Dimensions of the data sets
dim(BPRS) 
#BPRS has 40 obs. of  11 variables

dim(RATS) 
#RATS has 16 obs. of  13 variables

#structures of the data sets
str(BPRS)
#BPRS data was collected weekly for baseline and 8 consecutive weeks

str(RATS)
#RATS data was collected weekly for baseline and 9 consecutive weeks, the data however include 2 data points for week 6 (day43/44)


#Summaries of the data sets
summary(BPRS)
#The mean score is gradually decreasing for the first 6 week with a light increase last two weeks

summary(RATS)
#The weight for the rats is in general increasing during the experiments 


#Factor treatment & subject of BPRS
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

#Factor ID & Group of RATS
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

glimpse(BPRS)
glimpse(RATS)

#Converting data sets to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
RATSL <-  RATS %>% gather(key = times, value = Weight, -ID, -Group)

#Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(times,3,4)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)
glimpse(RATSL)


#Column names
colnames(BPRSL)
colnames(RATSL)

#Data contents and structures
str(BPRSL)
str(RATSL)

#Summaries of the variables
summary(BPRSL)
summary(RATSL)

#structures of the processed data sets
str(BPRSL)
#360 obs. of 5 variables
str(RATSL)
#176 obs. of 5 variables

#Save the data sets into txt-file
write.table(BPRSL, file = "data/BPRSL.txt", sep=",", row.names = TRUE, col.names = TRUE)
write.table(RATSL, file = "data/RATSL.txt", sep=",", row.names = TRUE, col.names = TRUE)

#And finally a try-out that the text-file works and looks appropriate
B = read.table(file="data/BPRSL.txt", sep=",", header=TRUE)
str(B) #360 obs. of 5 variables

R = read.table(file="data/RATSL.txt", sep=",", header=TRUE)
str(R) #176 obs. of 5 variables
