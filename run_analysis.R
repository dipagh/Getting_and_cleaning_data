#0. download and unzip the data set
library(tidyverse)
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "getdata_projectfiles_UCI HAR Dataset.tar.gz")
unzip("getdata_projectfiles_UCI HAR Dataset.tar.gz")

#0 read the data set
# read features data
features<-read.table('UCI HAR Dataset/features.txt', col.names = c("n","functions"))
# read activity labels data
activity_labels<-read.table('UCI HAR Dataset/activity_labels.txt', col.names = c("id", "activity"))
# read subject data
subject_train<-read.table('UCI HAR Dataset/train/subject_train.txt', col.names = "subject")
subject_test<-read.table('UCI HAR Dataset/test/subject_test.txt', col.names = "subject")
# read train data
X_train<-read.table('UCI HAR Dataset/train/X_train.txt', col.names = features$functions)
y_train<-read.table('UCI HAR Dataset/train/y_train.txt', col.names = "id")
# read test data
X_test<-read.table('UCI HAR Dataset/test/X_test.txt', col.names = features$functions)
y_test<-read.table('UCI HAR Dataset/test/y_test.txt', col.names = "id")


#1. Merges the training and the test sets to create one data set.

df_X <- rbind(X_train, X_test)
df_Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
df_merged <- cbind(Subject, df_Y, df_X)

#2. Extracts only the measurements on the mean and standard deviation 
#for each measurement. 
colnames(df_merged)

df_tidy <- df_merged %>% select(subject, id, contains("mean"), contains("std"))

#for checking correct column names selected or not
colnames(df_tidy)

#3. Uses descriptive activity names to name the activities in the data set

df_tidy$id <- activity_labels[df_tidy$id, 2]

#4. Appropriately labels the data set with descriptive variable names. 

names(df_tidy)[2] = "activity"
names(df_tidy)<-gsub("Acc", "Accelerometer", names(df_tidy))
names(df_tidy)<-gsub("Gyro", "Gyroscope", names(df_tidy))
names(df_tidy)<-gsub("BodyBody", "Body", names(df_tidy))
names(df_tidy)<-gsub("Mag", "Magnitude", names(df_tidy))
names(df_tidy)<-gsub("^t", "Time", names(df_tidy))
names(df_tidy)<-gsub("^f", "Frequency", names(df_tidy))
names(df_tidy)<-gsub("tBody", "TimeBody", names(df_tidy))
names(df_tidy)<-gsub("-mean()", "Mean", names(df_tidy), ignore.case = TRUE)
names(df_tidy)<-gsub("-std()", "STD", names(df_tidy), ignore.case = TRUE)
names(df_tidy)<-gsub("-freq()", "Frequency", names(df_tidy), ignore.case = TRUE)
names(df_tidy)<-gsub("angle", "Angle", names(df_tidy))
names(df_tidy)<-gsub("gravity", "Gravity", names(df_tidy))

#5. From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

tidy_final<-aggregate(. ~subject + activity, df_tidy, mean)

str(tidy_final)

tidy_final

write.table(tidy_final, file = "tidy_final.txt",row.name=FALSE)
