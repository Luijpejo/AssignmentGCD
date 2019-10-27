## Final assignment Course Getting and Cleaning Data (GCD)
## This is course 3 of the Specialization Data Scientist of John Hopkins University.
## Assignment made by Joost Luijpers

## Opening relevant libraries
  library(plyr)
  library(dplyr)
  library(readr)

##TRAIN FILES
  ##READ IN ALL THE FILES
    
     ##Read file with subjects that performed the activities
       subjectfile <- ".data/assignment GCD/train/subject_train.txt"
       subjects <- read.delim(subjectfile, header = FALSE, sep = "\n")
  
     ##Read file with the activitycodes
       activitycodesfile <- ".data/assignment GCD/train/y_train.txt"
       activitycodes <- read.delim(activitycodesfile, header = FALSE, sep = "\n")
   
    ##Read file with the activity names
      activitynamesfile <- ".data/assignment GCD/activity_labels.txt"
      activitynames <- read.delim(activitynamesfile, header = FALSE, sep = " ")
   
    ## Read file with the measurement results
      trainresultsfile <- ".data/assignment GCD/train/X_train.txt"
      trainresults <- read.table(trainresultsfile, header = FALSE)
   
    ## Read file with the measurements results variablenames
      resultvariablenamesfile <- ".data/assignment GCD/features.txt"
      resultvariablenames <- readLines(resultvariablenamesfile)
      
  
  ## MERGE ALL THE FILES
    ## merge activitycodes withhead activitynames
       activitiesmerged <- merge(activitycodes, activitynames)
      ## Additional column added to indicate train-set
       datasetfiletrain <- cbind(subjects, activitiesmerged, trainresults)

  ## ADD COLUMN NAMES
   namesforcolumns <- c("subject", "activitycode", "activityname", resultvariablenames)
   names(datasetfiletrain) <- namesforcolumns
   
   
##TEST FILES
   ##READ IN ALL THE FILES
   
     ##Read file with subjects that performed the activities
        subjectfile <- ".data/assignment GCD/test/subject_test.txt"
        subjects <- read.delim(subjectfile, header = FALSE, sep = "\n")
   
     ##Read file with the activitycodes
        activitycodesfile <- ".data/assignment GCD/test/y_test.txt"
        activitycodes <- read.delim(activitycodesfile, header = FALSE, sep = "\n")
   
     ## Read file with the measurement results
        testresultsfile <- ".data/assignment GCD/test/X_test.txt"
        testresults <- read.table(testresultsfile, header = FALSE)
   
   
   ## MERGE ALL THE FILES
     ## merge activitycodes withhead activitynames
        activitiesmerged <- merge(activitycodes, activitynames)
    ## Additional column added to indicate train-set
        datasetfiletest <- cbind(subjects, activitiesmerged, testresults)
  
  ## ADD COLUMN NAMES
        namesforcolumns <- c("subject", "activitycode", "activityname", resultvariablenames)
        names(datasetfiletest) <- namesforcolumns
         
##COMBINE TRAINSET WITH TESTSET
        combineddataset <- rbind(datasetfiletrain, datasetfiletest)
       
    
##CREATE TOTALDATASET
        
  ##Create a new file (the endfile) starting with the first four columns of the combineddataset
        firstcolumns <- select(combineddataset, c(1,3))
        valuecolumns <- cbind(select(combineddataset, grep("mean", names(combineddataset)), grep("std", names(combineddataset))))
        totaldataset <- cbind(firstcolumns, valuecolumns)

##CREATE DATASET WITH MEANS FOR EACH VARIABLE
        usedgroups <- group_by(totaldataset, .dots = c("subject", "activityname"))
        finaldataset <- summarize(usedgroups, tBodyAcc-mean()-X = mean(1 tBodyAcc-mean()-X),
                            tBodyAcc-mean()-Y = mean(2 tBodyAcc-mean()-Y), 
                            tBodyAcc-mean()-Z = mean(3 tBodyAcc-mean()-Z),
                            tBodyAcc-std()-X = mean(4 tBodyAcc-std()-X),
                            tBodyAcc-std()-Y = mean(5 tBodyAcc-std()-Y),
                            tBodyAcc-std()-Z = mean(6 tBodyAcc-std()-Z),
                            tGravityAcc-mean()-X = mean(41 tGravityAcc-mean()-X),
                            tGravityAcc-mean()-Y = mean(42 tGravityAcc-mean()-Y),
                            tGravityAcc-mean()-Z = mean(43 tGravityAcc-mean()-Z),
                            tGravityAcc-std()-X = mean(44 tGravityAcc-std()-X),
                            tGravityAcc-std()-Y = mean(45 tGravityAcc-std()-Y),
                            tGravityAcc-std()-Z = mean(46 tGravityAcc-std()-Z),
                            tBodyAccJerk-mean()-X = mean(81 tBodyAccJerk-mean()-X),
                            tBodyAccJerk-mean()-Y = mean(82 tBodyAccJerk-mean()-Y),
                            tBodyAccJerk-mean()-Z = mean(83 tBodyAccJerk-mean()-Z),
                            tBodyAccJerk-std()-X = mean(84 tBodyAccJerk-std()-X),
                            tBodyAccJerk-std()-Y = mean(85 tBodyAccJerk-std()-Y),
                            tBodyAccJerk-std()-Z = mean(86 tBodyAccJerk-std()-Z),
                            tBodyGyro-mean()-X = mean(121 tBodyGyro-mean()-X),
                            tBodyGyro-mean()-Y = mean(122 tBodyGyro-mean()-Y),
                            tBodyGyro-mean()-Z = mean(123 tBodyGyro-mean()-Z),
                            tBodyGyro-std()-X = mean(124 tBodyGyro-std()-X),
                            tBodyGyro-std()-Y = mean(125 tBodyGyro-std()-Y),
                            tBodyGyro-std()-Z = mean(126 tBodyGyro-std()-Z),
                            tBodyGyroJerk-mean()-X = mean(161 tBodyGyroJerk-mean()-X),
                            tBodyGyroJerk-mean()-Y = mean(162 tBodyGyroJerk-mean()-Y),
                            tBodyGyroJerk-mean()-Z = mean(163 tBodyGyroJerk-mean()-Z),
                            tBodyGyroJerk-std()-X = mean(164 tBodyGyroJerk-std()-X),
                            tBodyGyroJerk-std()-Y = mean(165 tBodyGyroJerk-std()-Y),
                            tBodyGyroJerk-std()-Z = mean(166 tBodyGyroJerk-std()-Z),
                            tBodyAccMag-mean() = mean(201 tBodyAccMag-mean()),
                            tBodyAccMag-std() = mean(202 tBodyAccMag-std()),
                            tGravityAccMag-mean() = mean(214 tGravityAccMag-mean()),
                            tGravityAccMag-std() = mean(215 tGravityAccMag-std()),
                            tBodyAccJerkMag-mean() = mean(227 tBodyAccJerkMag-mean()),
                            tBodyAccJerkMag-std() = mean(228 tBodyAccJerkMag-std()),
                            tBodyGyroMag-mean() = mean(240 tBodyGyroMag-mean()),
                            tBodyGyroMag-std() = mean(241 tBodyGyroMag-std()),
                            tBodyGyroJerkMag-mean() = mean(253 tBodyGyroJerkMag-mean()),
                            tBodyGyroJerkMag-std() = mean(254 tBodyGyroJerkMag-std()),
                            fBodyAcc-mean()-X = mean(266 fBodyAcc-mean()-X),
                            fBodyAcc-mean()-Y = mean(267 fBodyAcc-mean()-Y),
                            fBodyAcc-mean()-Z = mean(268 fBodyAcc-mean()-Z),
                            fBodyAcc-std()-X = mean(269 fBodyAcc-std()-X),
                            fBodyAcc-std()-Y = mean(270 fBodyAcc-std()-Y),
                            fBodyAcc-std()-Z = mean(271 fBodyAcc-std()-Z),
                            fBodyAcc-meanFreq()-X = mean(294 fBodyAcc-meanFreq()-X),
                            fBodyAcc-meanFreq()-Y = mean(295 fBodyAcc-meanFreq()-Y),
                            fBodyAcc-meanFreq()-Z = mean(296 fBodyAcc-meanFreq()-Z),
                            fBodyAccJerk-mean()-X = mean(345 fBodyAccJerk-mean()-X),
                            fBodyAccJerk-mean()-Y = mean(346 fBodyAccJerk-mean()-Y),
                            fBodyAccJerk-mean()-Z = mean(347 fBodyAccJerk-mean()-Z),
                            fBodyAccJerk-std()-X = mean(348 fBodyAccJerk-std()-X),
                            fBodyAccJerk-std()-Y = mean(349 fBodyAccJerk-std()-Y),
                            fBodyAccJerk-std()-Z = mean(350 fBodyAccJerk-std()-Z),
                            fBodyAccJerk-meanFreq()-X = mean(373 fBodyAccJerk-meanFreq()-X),
                            fBodyAccJerk-meanFreq()-Y = mean(374 fBodyAccJerk-meanFreq()-Y),
                            fBodyAccJerk-meanFreq()-Z = mean(375 fBodyAccJerk-meanFreq()-Z),
                            fBodyGyro-mean()-X = mean(424 fBodyGyro-mean()-X),
                            fBodyGyro-mean()-Y = mean(425 fBodyGyro-mean()-Y),
                            fBodyGyro-mean()-Z = mean(426 fBodyGyro-mean()-Z),
                            fBodyGyro-std()-X = mean(427 fBodyGyro-std()-X),
                            fBodyGyro-std()-Y = mean(428 fBodyGyro-std()-Y),
                            fBodyGyro-std()-Z = mean(429 fBodyGyro-std()-Z),
                            fBodyGyro-meanFreq()-X = mean(452 fBodyGyro-meanFreq()-X),
                            fBodyGyro-meanFreq()-Y = mean(453 fBodyGyro-meanFreq()-Y),
                            fBodyGyro-meanFreq()-Z = mean(454 fBodyGyro-meanFreq()-Z),
                            fBodyAccMag-mean() = mean(503 fBodyAccMag-mean()),
                            fBodyAccMag-std() = mean(504 fBodyAccMag-std()),
                            fBodyAccMag-meanFreq() = mean(513 fBodyAccMag-meanFreq()),
                            fBodyBodyAccJerkMag-mean() = mean(516 fBodyBodyAccJerkMag-mean()),
                            fBodyBodyAccJerkMag-std() = mean(517 fBodyBodyAccJerkMag-std()),
                            fBodyBodyAccJerkMag-meanFreq() = mean(526 fBodyBodyAccJerkMag-meanFreq()),
                            fBodyBodyGyroMag-mean() = mean(529 fBodyBodyGyroMag-mean()),
                            fBodyBodyGyroMag-std() = mean(530 fBodyBodyGyroMag-std()),
                            fBodyBodyGyroMag-meanFreq() = mean(539 fBodyBodyGyroMag-meanFreq()),
                            fBodyBodyGyroJerkMag-mean() = mean(542 fBodyBodyGyroJerkMag-mean()),
                            fBodyBodyGyroJerkMag-std() = mean(543 fBodyBodyGyroJerkMag-std()),
                            fBodyBodyGyroJerkMag-meanFreq() = mean(552 fBodyBodyGyroJerkMag-meanFreq()) )
        
##NOTE: this final command did not work. 
##      After multiple tries and many hours I have created the finaldataset using MS Access.
        
## WRITE THE FILE TO DISK
        write.table(finaldataset, file = "./assignment GCD/finaldataset.txt", row.name = FALSE)

        