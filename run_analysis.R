

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
       subjectfile <- "./train/subject_train.txt"
       subjects <- read.delim(subjectfile, header = FALSE, sep = "\n")
  
     ##Read file with the activitycodes
       activitycodesfile <- "./train/y_train.txt"
       activitycodes <- read.delim(activitycodesfile, header = FALSE, sep = "\n")
   
    ##Read file with the activity names
      activitynamesfile <- "./activity_labels.txt"
      activitynames <- read.delim(activitynamesfile, header = FALSE, sep = " ")
   
    ## Read file with the measurement results
      trainresultsfile <- "./train/X_train.txt"
      trainresults <- read.table(trainresultsfile, header = FALSE)
   
    ## Read file with the measurements results variablenames
      resultvariablenamesfile <- "./features.txt"
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
        subjectfile <- "./test/subject_test.txt"
        subjects <- read.delim(subjectfile, header = FALSE, sep = "\n")
   
     ##Read file with the activitycodes
        activitycodesfile <- "./test/y_test.txt"
        activitycodes <- read.delim(activitycodesfile, header = FALSE, sep = "\n")
   
     ## Read file with the measurement results
        testresultsfile <- "./test/X_test.txt"
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
        finaldataset <- totaldataset %>%
          group_by(subject, activityname) %>%
          summarise_all(funs(mean))
        
## WRITE THE FILE TO DISK
        write.table(finaldataset, file = "./finaldataset.txt", row.name = FALSE)
