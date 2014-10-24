---
title: "README.md"
author: "Dan Markosian"
output: html_document
---

##Getting and Cleaning Data Course Project

I'm assuming that you will be running this in RStudio and that the unzipped folder is located in your working directory. Further I'm assuming the folder structure of the data to be as follows:  
        - (folder)getdata-projectfiles-UCI HAR Dataset  
        -- (folder)UCI HAR Dataset  
        --- (folder)test  
        --- (folder)train  
        --- (file)activity_labels.txt  
        --- (file)features.txt  
        --- (file)features_info.txt  
        --- (file)README.txt  
This is the structure that resulted when I used winzip to unpack the download. I downloaded the files on 10/21/14.  
     
This repo includes four files:  
        - CodeBookHAR.md : gives the structure of the three tables outputted by the process  
        - run_analysis.R : gives the step by step process for running the process in RStudio  
        - run_analysis_function_only.R : a necessary addition to ensure that the function sources properly.  
        - README.md : this file.    
Download the two R scripts into your working directory in order to perform your evaluation. Open RStudio and run_analysis.R and follow the directions listed at the top of that script. 

###Step-by-Step Process for Tidying-up the Datasets

1. I read in files using read.table and created **data frames**:  
- subject_test.txt  to  **subj_test**     
- X_test.txt  to  **values_test**   
- y_test.txt  to  **labels_test**
- subject_train.txt  to  **subj_train**  
- X_train.txt  to  **values_train**
- y_train.txt  to  **labels_train**
2. I read in files using readLines and created **vectors**:
- features.txt  to  **features_vect**  
- activities_labels.txt  to  **act_labels_vect**
3. For the subj_ and labels_ files I renamed the variables from the generic **V1** to **subjectCode** and **activityCode**.
4. In order not to lose the connection between the subjects and their original set (test or train), I create a data frame for each with the variable **set** and named the data frames **set_test** and **set_train**.
5. I used cbind to create two combination data frames, **test_df** and **train_df**, out of their respective data frames **set_**, **subj_** , **labels_** and **values_**.
6. I used rbind to create a combination data frame, **human_act_recog_df**, out of **test_df** and **train_df**. *This is the data frame that satisfies requirement 1 of the assignment.*
7. The **features_vect** includes 561 labels for the values portion of the data frame. I use this vector in a for loop to rename all variables that have the specific substring *mean()* or *std()* and to mark for deletion all others. I also remove the leading int string from the feature name using the strsplit function. I then loop through the data frame and remove all such variables marked for deletion. *With this step, I've accomplished two more of the assignment requirements, namely 2 and 4.*
8. The **act_labels_vect** lists the six activities being measured. They also include a leading int string. I use strsplit to remove them.
9. From here on out, I want to be able to use *dplyr functions* so I convert **human_act_recog_df** to the dfTable **HAR_dfTable**. 
10. I replace the **activityCode** variable with an **activity** variable that uses the activity names rather than integers. *This satisfies requirement 3.*
11. **HAR_dfTable** is almost a tidy data set. One problem remains: for any given subjectCode, there is only one corresponding set value. To be tidy, there needs to be a seperate table to capture that information and the set variable needs to be removed from the bigger table. To accomplish this I created a **subject_set** dfTable and remove the set variable form **HAR_dfTable**.
12. Finally I created the dfTable **HAR_dfTable_Summary** that groups by **subjectCode** and **activity** and takes the mean of all of the values variables. *This satisfies requirement 5.*
