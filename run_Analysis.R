## Create directory if directory does not exist 

if (!file.exists("./Coursera/data"
)) {
  
  dir.create("./Coursera/data")
}

fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileURL, destfile = "./data/project.zip")

projectdata <- unzip("./data/project.zip", exdir = "./data") ##Unzip the zip file into temp file called "project"


##Read test files with the read.table function (reads .txt files)

xtest <- as.data.frame(read.table("./data/UCI HAR Dataset/test/X_test.txt"))
ytest <- as.data.frame(read.table("./data/UCI HAR Dataset/test/y_test.txt"))
subject_test <- as.data.frame(read.table("./data/UCI HAR Dataset/test/subject_test.txt"))

##Read train files with the read.table function (reads .txt files)
xtrain <- as.data.frame(read.table("./data/UCI HAR Dataset/train/X_train.txt"))
ytrain <- as.data.frame(read.table("./data/UCI HAR Dataset/train/y_train.txt"))
subject_train <- as.data.frame(read.table("./data/UCI HAR Dataset/train/subject_train.txt"))


##Read features and activity labels 

activity_labels <- as.data.frame(read.table("./data/UCI HAR Dataset/activity_labels.txt"))
features <- as.data.frame(read.table("./data/UCI HAR Dataset/features.txt"))

##Merge train and test files using rbind or the merge functions
xdata <- rbind(xtrain, xtest)
testdata <- cbind(as.data.table(subject_test), ytest, xtest)
traindata <- cbind(as.data.table(subject_train), ytrain, xtrain)
totaldata <- rbind(testdata, traindata)

##Set names for variables 
setnames(subject_test, "V1", "subjectId")
setnames(subject_train, "V1", "subjectId")
setnames(ytest, "V1", "activityNum")
setnames(ytrain, "V1", "activityNum")
setnames(activity_labels, names(activity_labels), c("activityNum", "activityType"))
setnames(features, names(features), c("featureNum", "featureType"))
colnames(xdata) <- as.character(features$featureType)




##Extract mean and standard deviation data and subset the totaldata set for those values

extract_features <- grep("mean\\(\\)|std\\(\\)", features$featureType, value = TRUE)
totaldata_mean_sd <- union(c("subjectId", "activityNum"), extract_features)
totaldata_mean_sd_set <- totaldata[, extract_features == TRUE] 

##Labeling totaldata with descriptive activity names by merging
totaldata <- merge(totaldata_aggregate, activity_labels, by = "activityNum", all.x = TRUE)
totaldata_aggregate <- aggregate(. ~subjectId - activityType, data = totaldata, mean)
totaldata <- as.data.frame(arrange(totaldata_aggregate, subjectId, activityType))
names(totaldata) <- gsub("std()", "SD", names(totaldata))
names(totaldata) <- gsub("mean()", "MEAN", names(totaldata))



##Reshape totaldata into 'tidydata'


write.table(totaldata, file = "tidydatafinal.txt", row.names = FALSE)


