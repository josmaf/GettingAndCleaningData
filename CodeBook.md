
### RAW DATA

- Test and train data sets of measures, as described in /UVI HAR Dataset/features_info.txt.
- Data set mapping measures and activity codes.
- Data set mapping subjects (person who generate data) and measures.
- Files with activities description.

### DATA PROCESSING STEPS

- 1. Read train data
- 2. Remove some columns. We only want the mean and standard deviation values, filtering by column name ("-mean" and "-std").
- 3. Add activity and subject ID to set.
- 4. Read test data
- 5. Remove some columns. We only want the mean and standard deviation values, filtering by column name ("-mean" and "-std").
- 6. Add activity and subject ID to set.
- 7. Combine train and test processed data sets.
- 8. Add Activity names to combined data set.
- 9. Remove Activity ID.
- 10. Group by Activiy name and Subject UD, calculating means for the features.
- 11. Write final data set to file "tidy.txt".

### PROCESSED DATA

- File ("tidi.txt") with:
	- Activity Name and Subject ID columns.
	- Average (of each mean and stantard deviation variable) for each activity name and each subject. 
