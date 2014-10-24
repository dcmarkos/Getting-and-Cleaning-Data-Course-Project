# You can run the analysis by copying and pasting the non-commented lines between BEGIN and END into the console
# Run them step by step

#BEGIN

# 1 Optional: run this is you would like a clean global environment
rm(list=ls())

# 2
  # set the working directory to the folder that contains the unzipped folder "getdata-projectfiles-UCI HAR Dataset"
  # and this script "run_analysis.R" and "run_analysis_function_only.R"

# example: setwd("C:/Users/Owner/Desktop/DataScience")
# or use the RStudio menu "Session/Set Working Directory"

# 3
library(dplyr)
  # the previous line may cause a message to appear in the console


# 4
source.with.encoding('run_analysis_function_only.R', encoding='UTF-8')  

# 5
tables<-run_analysis()
  # this may take a few seconds

# 6 After running the function the following will give easier access to the files of interest
subject_set<-tables[[1]]
HAR_dfTable<-tables[[2]]
HAR_dfTable_Summary<-tables[[3]]
rm("tables")

#END



  
run_analysis<-function(){
 
  #set up paths and files
  this_wd<-getwd()
  
   # if the path from your working directory to folder containing the test and train folders is
   # different than the following, make the correction at this location in
   # run_analysis_function_only.R file
  
  proj_path<-paste(this_wd,"/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset", sep = "")
  
  subj_test_file<-paste(proj_path,"/test/subject_test.txt", sep = "")
  values_test_file<-paste(proj_path,"/test/X_test.txt", sep = "")
  labels_test_file<-paste(proj_path,"/test/y_test.txt", sep = "")
  subj_train_file<-paste(proj_path,"/train/subject_train.txt", sep = "")
  values_train_file<-paste(proj_path,"/train/X_train.txt", sep = "")
  labels_train_file<-paste(proj_path,"/train/y_train.txt", sep = "")
  features_vect_file<-paste(proj_path,"/features.txt",sep = "")
  act_labels_vect_file<-paste(proj_path,"/activity_labels.txt",sep = "")


  #read files and create data frames and vectors

  subj_test<-read.table(subj_test_file)
  values_test<-read.table(values_test_file)
  labels_test<-read.table(labels_test_file)
  subj_train<-read.table(subj_train_file)
  values_train<-read.table(values_train_file)
  labels_train<-read.table(labels_train_file)

  features_vect<-readLines(features_vect_file)
  act_labels_vect<-readLines(act_labels_vect_file)

  #clean up column names for the 2 small files in each set to prevent 
  #having 3 columns with the same name (V1)

  names(subj_test)[names(subj_test) == "V1"] <- "subjectCode"
  names(labels_test)[names(labels_test) == "V1"] <- "activityCode"
  names(subj_train)[names(subj_train) == "V1"] <- "subjectCode"
  names(labels_train)[names(labels_train) == "V1"] <- "activityCode"


  #add a variable to indicate the set with the values: test or train
  set_test<-data.frame(rep("test", times = 2947), stringsAsFactors = FALSE)
  set_train<-data.frame(rep("train", times = 7352), stringsAsFactors = FALSE)
  #clean up the column name of each so they are compatible
  names(set_test)[names(set_test) == "rep..test...times...2947."] <- "set"
  names(set_train)[names(set_train) == "rep..train...times...7352."] <- "set"

  #create combination data frames
  test_df<-cbind(set_test,subj_test,labels_test,values_test)
  train_df<-cbind(set_train,subj_train,labels_train,values_train)
  human_act_recog_df<-rbind(test_df,train_df)

  #use features_vect to clean up remaining names in human_act_recog_df
  #There are 561 columns so it will be accomplished with a for loop
  #also get rid of the leading integers in the features' names
  count<- 0
  deleted<- 0
  for(f in features_vect){
    count <- count + 1
    if(grepl("mean()",f, fixed = TRUE) | grepl("std()",f)){
      newcol <- strsplit(f," ")[[1]][2]
    }else{
      deleted <- deleted + 1
      newcol<- "delete"
    }
    oldcol <- paste("V", count, sep = "")
    names(human_act_recog_df)[names(human_act_recog_df) == oldcol] <- newcol
  }

  #columns not measuring mean or std were renamed delete for the following operation
  for(i in 1:deleted){
    human_act_recog_df$delete <- NULL
  }

  #I've accomplished steps 1 (Merged train and test data sets), 2 (Extract only the measurments for
  # mean and standard deviation) and 4 (Label the data set with descriptive variable names). For Steps
  # 3 and 5, I'm going to shift to the functionality of dplyr

  #the entries in act_labels_vect are in the form: "<9> <activity>" I'm going to remove the leading number
  for(i in 1:length(act_labels_vect)){
    act_labels_vect[i]<- strsplit(act_labels_vect[i]," ")[[1]][2]
  }

  #The following creates a dfTable, replaces the activityCode column of numbers with an activity column 
  #of descriptions and reorders the column to put subjectCode and activity at the first followed by the 
  #measurement columns and lastly the set column which identifies test or train.
  HAR_dfTable<-tbl_df(human_act_recog_df)%>%
    mutate(activity = act_labels_vect[activityCode])%>%
    select(subjectCode,activity,starts_with("t"),starts_with("f"),set, -activityCode)

  #This is almost a tidy data set. One problem remains: for any give subjectCode there is only one 
  #corresponding set value. To be tidy, there needs to be a seperate table to capture that infomation. 
  #And the set value needs to be removed from the bigger table

  subject_set<-
    HAR_dfTable%>%
    select(subjectCode,set)%>%
    unique

  HAR_dfTable<-select(HAR_dfTable, -set)

  #This accomplishes everything through step 4. This is a tidy data set. These are now the only vital objects. 
  #Before continuing to step 5, I'll remove all the other objects.

  rm(list=setdiff(ls(),c("HAR_dfTable","subject_set")))

  #And now for the big finish:

  HAR_dfTable_Summary<-
    HAR_dfTable%>%
    group_by(subjectCode,activity)%>%
    summarise_each(funs(mean), c(starts_with("t") , starts_with("f")))%>%
    arrange(subjectCode,desc(activity))
  list(subject_set = subject_set, HAR_dfTable = HAR_dfTable, 
       HAR_dfTable_Summary = HAR_dfTable_Summary)
  
}
