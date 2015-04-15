setwd("C:/Users/C16Taiylar.Mastey/Desktop/Math 378/GettingCleaningData/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")
features <- read.table("features.txt")
features <- features$V2
labels <- read.table("activity_labels.txt")
labels <- labels$V2

y_train <- read.table("train/y_train.txt")
x_train <- read.table("train/X_train.txt")
subject_train <- read.table("train/subject_train.txt")

y_test <- read.table("test/y_test.txt")
x_test <- read.table("test/X_test.txt")
subject_test <- read.table("test/subject_test.txt")

y <- rbind(y_train,y_test)
x <- rbind(x_train,x_test)
subject <- rbind(subject_train,subject_test)

bigTable <- cbind(subject, y, x)

colnames(bigTable)[1:2] <- c("Subject", "Activity")
colnames(bigTable)[3:563] <- as.character(features)

temp <- bigTable[grepl("mean()",colnames(bigTable))|grepl("std()",colnames(bigTable))|grepl("Subject",colnames(bigTable))|grepl("Activity",colnames(bigTable))]
meanSDonly <- temp[!grepl("meanFreq()",colnames(temp))]  #don't want the meanFreq values

#rename activities from numbers to activity type
for (i in 1:6) {
  meanSDonly$Activity[meanSDonly$Activity == i] <- as.character(labels)[i]
}

#tidy data
tidyData <- aggregate(. ~ Subject+Activity, data = meanSDonly, FUN = function(meanSDonly) mn = mean(meanSDonly))

write.table(tidyData, file = "tidyData.txt", row.names = F)
