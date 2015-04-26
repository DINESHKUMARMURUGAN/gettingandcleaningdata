##Download the file

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./Dataset.zip")

##Unizip the file
unzip(zipfile="./Dataset.zip")

##Get the list of files
files<-list.files("./UCI HAR Dataset/", recursive=TRUE)

files

dActiTest  <- read.table(file.path("./UCI HAR Dataset/", "test" , "Y_test.txt" ),header = FALSE)
dActiTrain <- read.table(file.path("./UCI HAR Dataset/", "train", "Y_train.txt"),header = FALSE)


dSubjTrain <- read.table(file.path("./UCI HAR Dataset/", "train", "subject_train.txt"),header = FALSE)
dSubjTest  <- read.table(file.path("./UCI HAR Dataset/", "test" , "subject_test.txt"),header = FALSE)


dFeatuTest  <- read.table(file.path("./UCI HAR Dataset/", "test" , "X_test.txt" ),header = FALSE)
dFeatuTrain <- read.table(file.path("./UCI HAR Dataset/", "train", "X_train.txt"),header = FALSE)

str(dActiTest)


## Concatenate by rows
dSubject <- rbind(dSubjTrain, dSubjTest)
dActivity<- rbind(dActiTrain, dActiTest)
dFeatures<- rbind(dFeatuTrain, dFeatuTest)



##End of STEP1********************************************************************



dFeatuNames <- read.table(file.path("./UCI HAR Dataset/", "features.txt"),head=FALSE)
names(dFeatures)<- dFeatuNames$V2


dFeatuMean <- grep("-(mean|std)\\(\\)", dFeatuNames[, 2])


# subset the desired columns
dFeatuNames <- dFeatuNames[, dFeatuMean]

# correct the column names
names(dFeatuNames) <- dFeatuNames[dFeatuMean, 2]

##End of STEP 2*****************************************************************
## Read Names
activityLabels <- read.table(file.path("./UCI HAR Dataset/", "activity_labels.txt"),header = FALSE)


# update values with correct activity names
dActivity[, 1] <- activityLabels[dActivity[, 1], 2]


##End of STEP 3*******************************************************************

##Setting Names
names(dSubject)<-c("Subject")
names(dActivity)<- c("Activity")



##Merge columns
dCombine <- cbind(dSubject, dActivity)
Data <- cbind(dFeatures, dCombine)

##End of STEP 4***********************************************************

##Label Data set
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

names(Data)
##Second Independent Tidy Data set
library(plyr);
Data2<-aggregate(. ~Subject + Activity, Data, mean)
Data2<-Data2[order(Data2$Subject,Data2$Activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)

##End of STEP 5************************************************8