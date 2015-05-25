##Downlode the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

setwd("D:/R/") 

##Step 1
##Merge the training and test sets to create one data set.

##Get training data
xTrain <- read.table("train/X_train.txt")
yTrain <- read.table("train/y_train.txt")
subjTrain <- read.table("train/subject_train.txt")

##Get test data 
xTest <- read.table("test/X_test.txt")
yTest <- read.table("test/y_test.txt")
subjTest <- read.table("test/subject_test.txt")

##Create x and y data sets
xData <- rbind(xTrain,xTest)
yData <- rbind(yTrain,yTest)
subjData <- rbind(subjTrain,subjTest)

##Step 2
##Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("features.txt")

##Get mean and std
meanStdFeatures <- grep("mean\\(\\)|std\\(\\)",features[,2])
xData <- xData[,meanStdFeatures]

##Rename the column name
names(xData) <- gsub("\\(\\)", "", features[meanStdFeatures, 2]) 

##Step 3
##Uses descriptive activity names to name the activities in the data set.
activity <- read.table("activity_labels.txt")

activity[, 2] = gsub("_", "", tolower(as.character(activity[, 2])))
yData[,1] = activity[yData[,1], 2]

names(yData) <- "activity"

##Step 4
##Appropriately labels the data set with descriptive variable names. 
##Rename the column name
names(subjData) <- "subject"
##Combine all the data
cleanData <- cbind(subjData,yData,xData)

write.table(cleanData, "merged_cleanData.txt")

##Step 5
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

subjLength <- length(table(subjData))
actLength <- dim(activity)[1]
columnL <- dim(cleanData)[2]
meanData <- matrix(NA,nrow=subjLength*actLength,ncol=columnL)
meanData <- as.data.frame(meanData)
colnames(meanData) <- colnames(cleanData)

row <- 1

for(i in 1:subjLength) {
    for(j in 1:actLength) {
        meanData[row, 1] <- sort(unique(subjData)[, 1])[i]
        meanData[row, 2] <- activity[j, 2]
        b1 <- i == cleanData$subject
        b2 <- activity[j, 2] == cleanData$activity
        tmp <- cleanData[b1&b2,]
        meanData[row, 3:columnL] <- colMeans(tmp[, 3:columnL])
        row <- row + 1
    }
}
head(meanData)
write.table(meanData, "mean_Data.txt",row.name=FALSE) 