## -----------------------
## Individual steps of accomplished with this script:
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## -----------------------

## Merges the training and the test sets to create one data set.

## setwd("UCI HAR Dataset")
if("./UCI HAR Dataset" %in% list.dirs()) {
  setwd("./UCI HAR Dataset")
} else {
  
}

activities <- read.table("activity_labels.txt", sep = " ") # ok
features <- read.table("features.txt", sep = " ") # ok

subjtest <- read.table("./test/subject_test.txt")
xtest <- read.table("./test/X_test.txt")
ytest <- read.table("./test/Y_test.txt")
ytest <- factor(ytest[,1], labels = activities[,2])

subjtrain <- read.table("./train/subject_train.txt")
xtrain <- read.table("./train/X_train.txt")
ytrain <- read.table("./train/Y_train.txt")
ytrain <- factor(ytrain[,1], labels = activities[,2])

## Uses descriptive activity names to name the activities in the data set
colnames(xtest) <- features[,2]
colnames(xtrain) <- features[,2]
colnames(subjtest) <- "Subject"
colnames(subjtrain) <- "Subject"

allTest <- cbind(subjtest, Activity = ytest, Class = "Test", xtest)
allTrain <- cbind(subjtrain, Activity = ytrain, Class = "Train", xtrain)
allData <- rbind(allTest, allTrain)

## Extracts only the measurements on the mean and standard deviation for each measurement. 

## Check of column names if needed: 
## colnames(allData)[c(1:3, sort(union(grep("mean()", colnames(allData[4:564]), fixed = T), grep("std()", colnames(allData[4:564]), fixed = T)))+3)]

mean_sd_Data <- allData[,c(1:3, sort(union(grep("mean()", colnames(allData[4:564]), fixed = T), grep("std()", colnames(allData[4:564]), fixed = T)))+3)]
  
## Appropriately labels the data set with descriptive variable names. 
## Already Done

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

require(tidyr); require(dplyr)

tidyAll <- mean_sd_Data %>% gather(Variable, Value, -Subject, -Activity, -Class)

tidydata <- group_by(tidyAll, Subject, Activity, Variable) %>% summarize(Average = mean(Value))

write.table(tidydata, "../tidy_out.txt", row.name = FALSE)
