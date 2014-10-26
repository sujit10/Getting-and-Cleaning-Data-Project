##read the applicable input train and test datasets
  activitylabels <- read.table("activity_labels.txt", header = FALSE)
  features <- read.table("features.txt", header = FALSE)
  subjecttrain <- read.table("./train/subject_train.txt", header = FALSE)
  xtrain <- read.table("./train/X_train.txt", header = FALSE)
  ytrain <- read.table("./train/y_train.txt", header = FALSE)
  subjecttest <- read.table("./test/subject_test.txt", header = FALSE)
  xtest <- read.table("./test/X_test.txt", header = FALSE)
  ytest <- read.table("./test/y_test.txt", header = FALSE)
  
## join the X and Y Train and Test sets respectively  
  xTrainTest <- rbind (xtrain, xtest)
  yTrainTest <- rbind (ytrain, ytest) 

## add column names to the 'yTrainTest' and 'activitylabels' tables to facilitate merging of these tables later in the script   
  names(yTrainTest) <- "ActivityIndex"
  names(activitylabels) <- c("ActivityIndex", "ActivityName")

## join the 'Subject' train and test datasets 
  subjectTrainTest <- rbind (subjecttrain, subjecttest)
  
## add descriptive column name to the 'subjectTrainTest' dataser
  names(subjectTrainTest) <- "SubjectLabel"
  
## convert feature names to lower case, to facilitate selection of mean and std columns using grep  
  featureslower <- tolower(features$V2)

## create a vector with strings "mean" and "std"  
  colSelectStrings <- c("mean", "std")
  
## obtain columns in the 'features' table that contain the strings "mean" or "std" in their names 
  colSelect <- grep(paste(colSelectStrings, collapse = "|"), featureslower)

## from the columns obtained above, identify columns that contain the string "angle" in their names  
  colRemove <- grep("angle", featureslower[colSelect])

## as the columns that contain the string "angle", don't contain means or stdevs, remove these columns from the vector obtained in line 32 of the script   
  colMeanStd <- colSelect[-colRemove]

## select columns containing mean and stdev measurements in the 'xTrainTest' dataset  
  xTrainTestmeanstd <- xTrainTest[,colMeanStd]

## add descriptive variable names to the dataset created above   
  names(xTrainTestmeanstd) <- featureslower[colMeanStd]

## join the 'Y' data and activity labels to obtain the descriptive activity name for each record
  library(plyr)
  ydesc1 <- join(yTrainTest, activitylabels, by = "ActivityIndex")

## combine the 'subject', 'Y', and 'X' datasets  
  TrainTestData <- cbind(subjectTrainTest, ydesc1, xTrainTestmeanstd)

## remove the ActivityIndex from the 'TrainTestData'  
  TrainTestData <- TrainTestData[,-2]

## calculate the means of the columns by subject and activity label
  library(dplyr)
  TrainTestDataTbl <- tbl_df(TrainTestData)
  bySubjectActivity <- group_by(TrainTestDataTbl, SubjectLabel, ActivityName)
  output <- summarise_each(bySubjectActivity, funs(mean))

## create the output text file  
  write.table(output,"Project Output.txt",row.names=FALSE)