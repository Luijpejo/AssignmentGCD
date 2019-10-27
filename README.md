This document is part of the final assignment of Joost Luijpers for course 3, Getting and Cleaining Data, of the specialisation Data Scientist of the John Hopkins University, as provided via Coursera.
The documents that are part of this assignment are this Readme.md-document, the codebook and the tidy dataset "finaldataset.txt"
 
In this document I describe the working of my R-script called "run_analysis.R".
Purpose of this script is to deliver a tidy data set, based on the raw data which was provided for the assignment. For both the context and the content of the raw data I refer to the description of the assignment at Coursera.org and to the Codebook.
 
The construction of my R-script is as follows:

- First I open all the relevant libraries - plyr, dplyr and readr
- The raw data consists of two parts: train and test. The same actions are taken for both parts, starting with Train

TRAIN
With the files for train, the script does the following:
- Read in all the files
	- subject_train.txt (subjects) from the train-directory, using read.delim()
	- y_train.txt (activitycodes) from the train-directory, using read.delim()
	- activity_labels.txt (activitynames) in the rootdirectory, using read.delim()
    	- X_train.txt (measurement results) from the train-directory, using read,table()
	- features.txt (result variablenames) from the main directory, using readLines()
  
- Merge the various dataframes for train
      	- merging the activitycodes with the activitynames (activitiesmerged), using merge()
	- creating the dataset for train by combining subjects, activitiesmerged and the measurements resutts, using cbind()  
  
- Add the columnnames to the train dataset
	- complete the column names by combining three column values (subject, activity codes and activity names) with the result variable names, using c()
	- assign the column names to the dataset for train.
  
 TEST
With the test files for train, the same steps are taken:
- Read in all the files
	- subject_test.txt (subjects) from the test-directory, using read.delim()
	- y_test.txt (activitycodes) from the test-directory, using read.delim()
	- X_test.txt (measurement results) from the test-directory, using read,table()
	  
- Merge the various dataframes for test
      	- merging the activitycodes with the activitynames (activitiesmerged), using merge()
	- creating the dataset for test by combining subjects, activitiesmerged and the measurements resutts, using cbind()  
  
- Add the columnnames to the test data set
	- assign the same column names to the dataset for train.
   

Now the two datasets (train and test) have been created.
They need to be combined to the total dataset
         
- combine the dataset for train with the dataset for test to create the total dataset, using rbind()
 

From this total data set a dataframe must be created which is a subset concerning the mean-variables and the standard deviation (std) variables.
	- create a dataframe with the two columns - subject and activitynames      
	- create a dataframe with only the columns having either "mean" or "std" in the variable name, combining the use of select() and grep()
      	- combine these two dataframes to get the total dataset, using cbind() 
        
 The final step is to group the totaldataset and calculate the means of each column
	- group the total data set on subject and activityname., using group_by
	- calculate the mean for each column, using ddply().
NOTE: this command does not work. After many hours and multiple tries I have eventually created the finaldataset file using MS Access.

Finally the file is written to disk, using write.table() with row.name = FALSE.
	- write the file "finaldataset.txt"
