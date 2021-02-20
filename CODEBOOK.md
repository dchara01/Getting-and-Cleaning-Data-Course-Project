<h1>Action flow of run_analysis.R</h1>

1. Checks for the required R packages, installs them if they are not already installed and the loads them.
2. Checks for the existence of the data set and if it does not exist it downloads it and extracts it.
3. Reads, manipulates and merges the data sets
4. Gives the variables more descriptive names.
5. Creates a second data set with only mean and standart deviation values

<h1>Variables and data assignments</h1>
| Variable | Description |
| --- | --- |
| **features** _<- features.txt : 561 rows, 2 columns_ | The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. |
|**activities** _<- activity_labels.txt : 6 rows, 2 columns_ | List of activities performed when the corresponding measurements were taken and its ids. |
| **subject_test** _<- test/subject_test.txt : 2947 rows, 1 column_ | Contains test data of 9/30 volunteer test subjects being observed. |
| **X_test** _<- test/X_test.txt : 2947 rows, 561 columns_ | Contains recorded features test data. |
| **y_test** _<- test/y_test.txt : 2947 rows, 1 columns_ | Contains test data of activities’ ids |
| **subject_train** _<- test/subject_train.txt : 7352 rows, 1 column_ | Contains train data of 21/30 volunteer subjects being observed. |
| **X_train** _<- test/X_train.txt : 7352 rows, 561 columns_ | Contains recorded features train data. |
| **y_train** _<- test/y_train.txt : 7352 rows, 1 columns_ | Contains train data of activities’ ids. |

<h1>Merging the data sets</h1>

- **X** _(10299 rows, 561 columns)_ is created by merging x_train and X_test using rbind() function
- **y** _(10299 rows, 1 column)_ is created by merging y_train and y_test using rbind() function
- **subject** *(10299 rows, 1 column)* is created by merging subject_train and subject_test using rbind() function
- **merged_data** *(10299 rows, 563 column)* is created by merging subject, y and X using cbind() function

<h1>Using descriptive labels</h1>
- id renamed to **activities**
- Acc renamed to **accelerometer**
- Gyro renamed to **gyroscope**
- BodyBody renamed to **body**
- Mag renamed to **magnitude**
- f renamed to **frequency**
- t renamed to **time**

<h1>Output data set</h1>
**tidy_data_2** *(180 rows, 88 columns)* is created by summarizing the tidy_data data set, taking the means of each variable for each activity and each subject, after with it is grouped by subject and activity.
