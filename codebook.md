# Getting and Cleaning Data Peer Assessments
## Code Book

Original data get from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Original description:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Describe the variable, the data and all the work I did in run_analysis.R as below:

* Read X_train.txt, y_train.txt and subject_train.txt into variables xTrain,yTrain and subjTrain. 

* Read X_test.txt, y_test.txt and subject_test.txt into variables xTest,yTest and subjTest.

* Merge xTrain,xTest to xData; merge yTrain,yTest to yData, merge subjTrain, subjTest to subjData.

* Read features.txt into variable features. Extract the measurements on the mean and strandard deviation and get a subset of xData, then rename the column name.

* Read activity_labels.txt into variable activity, apply descriptive activity names to name the activities in the data set , all feature names (attributes), activity names are converted to lower case and remove the brackets and underscore between letters.

* Combine subjData,yData,xData by column into cleanData and save as merged_cleanData.txt.

* Create a second, independent tidy data set with the average of each variable for each activity and each subject and save as "mean_Data.txt".
