## Dealing with packages.

# Specify the required packages
packages = c("dplyr")

# Install missing packages if any; load all required packages.
packages.check <- lapply(
  packages,
  FUN = function(x){
    if (!require(x, character.only = TRUE)){
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)

## Dealing with files and paths.

# Set the file name for the data set archive and 
# the name of folder in which it will be extracted.
filename <- "UCI HAR Dataset.zip"
foldername <- "UCI HAR Dataset"

# Check if the file already exists; if not, download the file.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method = "curl")
}

# Check if the folder exists; if not extract the archive.
if (!file.exists(foldername)){
  unzip(filename)
}

## Dealing with data frames.

# Assign all data frames.
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "id")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "id")

# Merge the data sets.
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_data <- cbind(subject, y, X)

# Extract only the measurements on the mean and standard deviation for each measurement.
tidy_data <- merged_data %>% select(subject, id, contains("mean"), contains("std"))

# Match the id to the activity labels.
tidy_data$id <- activity_labels[tidy_data$id, 2]

# Give descriptive names to the functions.
names(tidy_data)[2] = "activity"
names(tidy_data)<-gsub("Acc", "accelerometer", names(tidy_data))
names(tidy_data)<-gsub("Gyro", "gyroscope", names(tidy_data))
names(tidy_data)<-gsub("BodyBody", "body", names(tidy_data))
names(tidy_data)<-gsub("Mag", "magnitude", names(tidy_data))
names(tidy_data)<-gsub("^t", "time", names(tidy_data))
names(tidy_data)<-gsub("^f", "frequency", names(tidy_data))
names(tidy_data)<-gsub("tBody", "time_body", names(tidy_data))
names(tidy_data)<-gsub("-mean()", "mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-std()", "standard_deviation", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-freq()", "frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("angle", "angle", names(tidy_data))
names(tidy_data)<-gsub("gravity", "gravity", names(tidy_data))

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data_2 <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(tidy_data_2, "tidy_data_2.txt", row.name=FALSE)