# Getting and Cleaning Data
## Course Project

The submission consists of the following files:

1. **finaldata.txt** - File with the resulting data
1. **run_analysis.R** - File with the script to convert input test and training data to resulting data.
1. **Smartphone_Dataset_code_book.txt** - File with codes for the resulting data
1. **README.MD** - File with general information about the submission


The resulting data was obtained as follows:

1. Using the script run_analysis.R to first combine the test and training data  together with the subject and activities data.
1. The data from the previous step data was filtered to get data for all observations for every variable that has the phrase *"mean"* or *"std()"* in its name.
1. The data from the previous step was grouped by activity and subject and then the means for the each variable in each group was obtained.

Notes: 

* The name of each variable for which the mean was calculated in the resulting data set was derived by concatenating the word "mean" to the name of the variable.
* The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g' and is therefore the unit of measure for all variables with the sub string "Acc" in its name.
* The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second and is therefor the unit of measure for all variables with the sub string "Gyro" in its name. 
