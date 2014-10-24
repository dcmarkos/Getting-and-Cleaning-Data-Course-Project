---
title: 'Code Book: Human Activity Recognition'
author: "Dan Markosian"
output: html_document
---

##Table: subject_set 
**Classes 'tbl_df' and 'data.frame'**  
 *30 observations of  2 variables:*

 + subjectCode: int  1:30
 + set        : chr  "test" "train""
 
This table perserves the connection between the subject, identified by code only, and their associated data set; test or train.



##Table: HAR_dfTable
**Classes 'tbl_df', 'tbl' and 'data.frame'**  
 *10299 obs. of  68 variables:*

+ Note: this and the following table share the same variables

This is the table that includes all observations. The number of variables have been reduced to only those measuring mean() and std(). This is the table that fits the requirement of step 4 of the assignment.

The following table is the summary. The variables now indicate the average of the previous values as they relate to a particular subject and a particular, one of six, activities. This is the table that satisfied step 5 of the assignment. 

##Table: HAR_dfTable_Summary
**Classes 'grouped_df', 'tbl_df', 'tbl' and 'data.frame'**  
 *180 obs. of  68 variables:*

 + subjectCode                : int  1:30
 + activity                   : chr  "WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" "STANDING" "LAYING"
 + tBodyAcc-mean()-X          : num  -1.0:1.0
 + tBodyAcc-mean()-Y          : num  -1.0:1.0
 + tBodyAcc-mean()-Z          : num  -1.0:1.0
 + tBodyAcc-std()-X           : num  -1.0:1.0
 + tBodyAcc-std()-Y           : num  -1.0:1.0
 + tBodyAcc-std()-Z           : num  -1.0:1.0
 + tGravityAcc-mean()-X       : num  -1.0:1.0
 + tGravityAcc-mean()-Y       : num  -1.0:1.0
 + tGravityAcc-mean()-Z       : num  -1.0:1.0
 + tGravityAcc-std()-X        : num  -1.0:1.0
 + tGravityAcc-std()-Y        : num  -1.0:1.0
 + tGravityAcc-std()-Z        : num  -1.0:1.0
 + tBodyAccJerk-mean()-X      : num  -1.0:1.0
 + tBodyAccJerk-mean()-Y      : num  -1.0:1.0
 + tBodyAccJerk-mean()-Z      : num  -1.0:1.0
 + tBodyAccJerk-std()-X       : num  -1.0:1.0
 + tBodyAccJerk-std()-Y       : num  -1.0:1.0
 + tBodyAccJerk-std()-Z       : num  -1.0:1.0
 + tBodyGyro-mean()-X         : num  -1.0:1.0
 + tBodyGyro-mean()-Y         : num  -1.0:1.0
 + tBodyGyro-mean()-Z         : num  -1.0:1.0
 + tBodyGyro-std()-X          : num  -1.0:1.0
 + tBodyGyro-std()-Y          : num  -1.0:1.0
 + tBodyGyro-std()-Z          : num  -1.0:1.0
 + tBodyGyroJerk-mean()-X     : num  -1.0:1.0
 + tBodyGyroJerk-mean()-Y     : num  -1.0:1.0
 + tBodyGyroJerk-mean()-Z     : num  -1.0:1.0
 + tBodyGyroJerk-std()-X      : num  -1.0:1.0
 + tBodyGyroJerk-std()-Y      : num  -1.0:1.0
 + tBodyGyroJerk-std()-Z      : num  -1.0:1.0
 + tBodyAccMag-mean()         : num  -1.0:1.0
 + tBodyAccMag-std()          : num  -1.0:1.0
 + tGravityAccMag-mean()      : num  -1.0:1.0
 + tGravityAccMag-std()       : num  -1.0:1.0
 + tBodyAccJerkMag-mean()     : num  -1.0:1.0
 + tBodyAccJerkMag-std()      : num  -1.0:1.0
 + tBodyGyroMag-mean()        : num  -1.0:1.0
 + tBodyGyroMag-std()         : num  -1.0:1.0
 + tBodyGyroJerkMag-mean()    : num  -1.0:1.0
 + tBodyGyroJerkMag-std()     : num  -1.0:1.0
 + fBodyAcc-mean()-X          : num  -1.0:1.0
 + fBodyAcc-mean()-Y          : num  -1.0:1.0
 + fBodyAcc-mean()-Z          : num  -1.0:1.0
 + fBodyAcc-std()-X           : num  -1.0:1.0
 + fBodyAcc-std()-Y           : num  -1.0:1.0
 + fBodyAcc-std()-Z           : num  -1.0:1.0
 + fBodyAccJerk-mean()-X      : num  -1.0:1.0
 + fBodyAccJerk-mean()-Y      : num  -1.0:1.0
 + fBodyAccJerk-mean()-Z      : num  -1.0:1.0
 + fBodyAccJerk-std()-X       : num  -1.0:1.0
 + fBodyAccJerk-std()-Y       : num  -1.0:1.0
 + fBodyAccJerk-std()-Z       : num  -1.0:1.0
 + fBodyGyro-mean()-X         : num  -1.0:1.0
 + fBodyGyro-mean()-Y         : num  -1.0:1.0
 + fBodyGyro-mean()-Z         : num  -1.0:1.0
 + fBodyGyro-std()-X          : num  -1.0:1.0
 + fBodyGyro-std()-Y          : num  -1.0:1.0
 + fBodyGyro-std()-Z          : num  -1.0:1.0
 + fBodyAccMag-mean()         : num  -1.0:1.0
 + fBodyAccMag-std()          : num  -1.0:1.0
 + fBodyBodyAccJerkMag-mean() : num  -1.0:1.0
 + fBodyBodyAccJerkMag-std()  : num  -1.0:1.0
 + fBodyBodyGyroMag-mean()    : num  -1.0:1.0
 + fBodyBodyGyroMag-std()     : num  -1.0:1.0
 + fBodyBodyGyroJerkMag-mean(): num  -1.0:1.0.
 + fBodyBodyGyroJerkMag-std() : num  -1.0:1.0
