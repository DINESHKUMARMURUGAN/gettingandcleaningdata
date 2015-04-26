---
title: "Cookbook"
output: html_document
---
#Introduction
The script run_analysis.Rperforms the 5 steps described in the course project's definition.

First, all the similar data is merged using the rbind() function. By similar, we address those files having the same number of columns and referring to the same entities.
Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from features.txt.
As activity data is addressed with values 1:6, we take the activity names and IDs from activity_labels.txt and they are substituted in the dataset.
On the whole dataset, those columns with vague column names are corrected.
Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called tidydata.txt, and uploaded to this repository.

#Variables
dActiTest, dActiTrain, dSubjTrain,dSubjTest, dFeatuTest and dFeatuTrain contain the data from the downloaded files.
dSubject, dActivity and dFeatures merge the previous datasets to further analysis.
features contains the correct names for the dFeatuNames dataset, which are applied to the column names stored in dFeatuMean, a numeric vector used to extract the desired data.

A similar approach is taken with activity names through the activities variable.
Data merges dSubject, dActivity and dFeatures in a big dataset.
Finally, Data2 contains the relevant averages which will be later stored in a tidydata.txt file. 