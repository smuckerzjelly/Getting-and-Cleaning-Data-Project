Purpose  

This is coursera's week four final project in the course "Getting and Cleaning Data".
Students were required to make a "tidy data set" from given data taken from 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 



The dataset includes the following files:
=========================================

- README.txt

Explains the purpose and the files in the repository 

- CodeBook.txt

States all variables and calculations used 

- tidydatafinal.txt

Final 'tidy set' to fulfill the course objective 

- run_analysis.r 

Steps used in deriving the tidy data set:

1)  Unzip files 
2)  Read all files using the read.table function 
3)  Set names of all variables using the set.names function 
4)  Merge all files into one dataset using the rbind(), cbind(), and merge() functions 
5)  Extract the mean and standard deviation 
6)  Construct a final tidy data set using the write.table() function 

R Packages used:  plyr, data.table, reshape2 



