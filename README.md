# GettingandCleaningData
##Course Project

The submission consists of the following files:
1.  file with the resulting data named
1. **run_analysis.R** File with the script to convert input test and training data to resulting data.
1. **Smartphone_Dataset_code_book.txt** File with codes for the resulting data
1. **README.MD** File with general information about the submission


The resulting data was obtained as follows:
1. Using the script run_analysis.R to combine the test and training data together with the subject and activities data.
1. The data from the previous step data was filtered to get data for all observations for every variable that has the phrase *"mean"* or *"std()"* in its name.
1. The data from the previous step was grouped by activity and subject and then the means for the each variable in each group was obtained.

Notes: 
======
* The name of each variable for which the mean was calculated in the resulting data set was derived by concatenating the word "mean" to the name of the variable.