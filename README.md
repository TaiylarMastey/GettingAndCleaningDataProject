# GettingAndCleaningDataProject
Course Project - Getting and Cleaning Data

The data came from a study of Human Activity Recognition Using Smartphones Data Set.  
30 volunteers were studied from 19 to 48 years of age and each of them performed activities
with Samsung Galaxy S II's on their waist.

The following is information about the data used:
Data Set Characteristics: Multivariate, Time-Series
Attribute Characteristics: N/A
Associated Tasks: Classification, Clustering
Number of Instances: 10299
Number of Attributes: 561
Missing Values: None
Area: Computer
Date Donated: 2012-12-10
Number of Web Hits: 160858

==================================================================================================

The following is my run_analysis.R code

```
#Set working directory
setwd("C:/Users/C16Taiylar.Mastey/Desktop/Math 378/GettingCleaningData/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")

#pull the features from the file
features <- read.table("features.txt")
features <- features$V2

#pull the labels from the file
labels <- read.table("activity_labels.txt")
labels <- labels$V2

#pull the train tables from the file
y_train <- read.table("train/y_train.txt")
x_train <- read.table("train/X_train.txt")
subject_train <- read.table("train/subject_train.txt")

#pull the test tables from the file
y_test <- read.table("test/y_test.txt")
x_test <- read.table("test/X_test.txt")
subject_test <- read.table("test/subject_test.txt")

#combine the three tables
y <- rbind(y_train,y_test)
x <- rbind(x_train,x_test)
subject <- rbind(subject_train,subject_test)

#Create a whole table with all values as a tidy data table
bigTable <- cbind(subject, y, x)

#rename the columns
colnames(bigTable)[1:2] <- c("Subject", "Activity")
colnames(bigTable)[3:563] <- as.character(features)

#Create a table with the mean SD's only
temp <- bigTable[grepl("mean()",colnames(bigTable))|grepl("std()",colnames(bigTable))|grepl("Subject",colnames(bigTable))|grepl("Activity",colnames(bigTable))]
meanSDonly <- temp[!grepl("meanFreq()",colnames(temp))]  #don't want the meanFreq values

#rename activities from numbers to activity type
for (i in 1:6) {
  meanSDonly$Activity[meanSDonly$Activity == i] <- as.character(labels)[i]
}

#tidy data
tidyData <- aggregate(. ~ Subject+Activity, data = meanSDonly, FUN = function(meanSDonly) mn = mean(meanSDonly))

#create the text file
write.table(tidyData, file = "tidyData.txt", row.names = F)
```
=============================================================================================================

Code Book

The following variables were used as activity labels:
WALKING 
WALKING_UPSTAIRS
WALKING_DOWNSTAIRS 
SITTING           
STANDING
LAYING


The following variables were used as column labels in order to determine what happened to each individual during each excersize:
"Subject"                     "Activity"                   
 [3] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"          
 [5] "tBodyAcc-mean()-Z"           "tBodyAcc-std()-X"           
 [7] "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
 [9] "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"       
[11] "tGravityAcc-mean()-Z"        "tGravityAcc-std()-X"        
[13] "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
[15] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"      
[17] "tBodyAccJerk-mean()-Z"       "tBodyAccJerk-std()-X"       
[19] "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
[21] "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"         
[23] "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"          
[25] "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
[27] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"     
[29] "tBodyGyroJerk-mean()-Z"      "tBodyGyroJerk-std()-X"      
[31] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
[33] "tBodyAccMag-mean()"          "tBodyAccMag-std()"          
[35] "tGravityAccMag-mean()"       "tGravityAccMag-std()"       
[37] "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
[39] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"         
[41] "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
[43] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
[45] "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"           
[47] "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"           
[49] "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
[51] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"       
[53] "fBodyAccJerk-std()-Y"        "fBodyAccJerk-std()-Z"       
[55] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
[57] "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"          
[59] "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"          
[61] "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
[63] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"  
[65] "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroMag-std()"     
[67] "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()"
