setwd("C:/coursera/JHU/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset")
#Get the factor info
features <- read.table("features.txt")
feat<-features$V2
featList<-split(feat,feat[1:561])
u<-unlist(featList,use.names=F)
lbl<- read.table("activity_labels.txt")
names(lbl)<-c("Activity Label","Activity Label Name")
#Set the column names for tidy data
setwd("C:/coursera/JHU/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train")
dataTrain <- read.table("X_train.txt")
names(dataTrain)<-u	
#Need to map the labels
labelTrain <- read.table("y_train.txt")
names(labelTrain) <- c("Activity Label")

labelTrain<-merge(x=labelTrain,y=lbl, by = "Activity Label", all=TRUE)
allTrain<- cbind(dataTrain,labelTrain)
#Other 30% of the data
setwd("C:/coursera/JHU/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test")
dataTest <- read.table("X_test.txt")
names(dataTest)<-u	
#Need to map the labels
labelTest <- read.table("y_test.txt")
names(labelTest) <- c("Activity Label")

labelTest<-merge(x=labelTest,y=lbl, by = "Activity Label", all=TRUE)
allTest<- cbind(dataTest,labelTest)

#Combine data
dataAll<-rbind(allTest,allTrain)

#make Tidy summarized Data
tidyData<-aggregate(dataAll[1:561],dataAll["Activity Label"],mean)

#Write Data
write.table(tidyData,row.name=FALSE,file="rTidyDataOut.txt")