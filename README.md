Getting-and-Cleaning-Data-Project
=================================

Getting and Cleaning Data Project (Sujit Adhye)

Data Download Instructions
===========================
1. Download the data archive from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. The following files must be extracted to your working directory:
   - activity_labels.txt
   - features.txt 	 
   - features_info.txt
   - README.txt
3. The files contained in the 'train' and 'test' folders in the archive must to extracted to 'train' and 'test' folders in your working directory


Description of Data
====================
Please see the codebook for details on the input data for this script. Additional details are available in te README.txt and features_info.txt in the source data


Prerequisites	
=============
The following packages must be installed, prior to executing the script:
- plyr
- dplyr


Script
======
The run_analysis.R script is available at the following github repo:

Upon sourcing the script, it performs the following actions:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard   deviation for each measurement. 
- Uses descriptive activity names to name the activities in the   data set
- Appropriately labels the data set with descriptive variable   names. 
- From the data set in the above steo, creates a second,   independent tidy data set with the average of each variable     for each activity and each subject.
- Writes this second data set to the "Project Output.txt" file
  in your working directory	 
