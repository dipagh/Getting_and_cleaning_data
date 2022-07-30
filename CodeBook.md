#Code Book

The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

Dataset downloaded and extracted under the folder called UCI HAR Dataset

Assign each data to variables:
features <- features.txt : 561 rows, 2 columns.
activity_labels <- activity_labels.txt : 6 rows, 2 columns.
subject_train <- train/subject_train.txt : 7352 rows, 1 column.
subject_test <- test/subject_train.txt : 2947 rows, 1 column.
X_train <- train/X_train.txt : 7352 rows, 561 columns.
X_test <- test/X_test.txt : 2947 rows, 561 columns.
y_train <- train/y_train.txt : 7352 rows, 1 columns.
y_test <- test/y_test.txt : 2947 rows, 1 columns.

1. Merges the train and test data sets to create one data set:
df_X (10299 rows, 561 columns) is created by merging X_train and X_test using rbind() function.
df_Y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function.
Subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function.
df_merged (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function.

2. Extracts only the measurements on the mean and standard deviation for each measurement:
df_tidy (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting specific columns containing mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set:
Entire numbers in code column of the df_tidy replaced with corresponding activity labels taken from second column of the activity_labels variable

4. Appropriately labels the data set with descriptive variable names
code column in df_tidy renamed into activities.
All Acc in column’s name replaced by Accelerometer.
All Gyro in column’s name replaced by Gyroscope.
All BodyBody in column’s name replaced by Body.
All Mag in column’s name replaced by Magnitude.
All start with character f in column’s name replaced by Frequency.
All start with character t in column’s name replaced by Time.

5. From the data set in step 4, creates a second, independent df_tidy data set with the average of each variable for each activity and each subject.

tidy_final (180 rows, 88 columns) is created by sumarizing df_tidy taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export tidy_final into tidy_final.txt file.

