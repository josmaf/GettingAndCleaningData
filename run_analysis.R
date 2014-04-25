## Script that generate a tidy data set,
## with the average of each mean and stantard deviation variables
## for each activity name and each subject


## Function to read test and train data sets.
## Parameter t must take two values: "train" or "test"
## Parameter dir indicates directory containing data (UCI HAR Dataset)
## Returns a data frame with measurements on the mean and standard deviation, 
## and two additional columns: Activity and subject IDs.

readData<-function(t,dir) {
  
  ## Read X values  
  x_full <- read.table(paste("./",dir,"/",t,"/X_",t,".txt", sep=""))
  
  ## Read features
  feat <- read.table(paste("./",dir,"/","features.txt",sep=""))
  
  ## get names of features with mean and standard deviation values
  f_names <- feat[c(grep("-mean",feat[,2]), grep("-std",feat[,2])),2]
  
  ## Take a subset of the columns representing 
  ## only the mean and standard deviation values
  x <- x_full[, c(grep("-mean",feat[,2]), grep("-std",feat[,2]))]
  
  ## Associate names to data frame
  names(x) <- f_names
  
  ## Associate two new columns representing activity IDs and subject IDs
  ## Warning!: don't do this in one line: x$ActivityID <- read.table(...)
  ## read activities
  act_path <- paste("./",dir,"/",t,"/y_",t,".txt" ,sep="")
  y_data <-read.table(act_path, header=F, col.names= "ActivityID")
  x$ActivityID <- y_data$ActivityID
  ## read subjects
  sub_path <- paste("./",dir,"/",t,"/subject_",t,".txt",sep="")
  s_data <- read.table(sub_path , header=F, col.names= "SubjectID")
  x$SubjectID <- s_data$SubjectID 
  
  ## Return data frame
  x
}

###############################
## START of script execution ##

## load library
library("reshape2")

## Set data directory
dir <- "UCI HAR Dataset"

## Read train data
trainData <- readData("train",dir)

## Read test data
testData <- readData("test",dir)

## Combine data frames
tidy <- rbind(trainData, testData)

## get activity descriptions, reading file of activities
act_path <- paste("./",dir,"/","activity_labels.txt", sep="")
acti_d <- read.table(act_path, header=F, as.is=T, 
                     col.names=c("ActivityID", "ActivityName"))

## Add an activity description column
tidy <- merge(acti_d,tidy)

## Remove activity ID and reorder columns
tidy <- subset(tidy,select=c(2,82,3:81))

## Grouping and calculating mean of measures
id_vars <- c("ActivityName", "SubjectID")
m_vars <- setdiff(colnames(tidy), id_vars)
melted_data <- melt(tidy, id=id_vars, measure.vars=m_vars)
tidy<- dcast(melted_data, ActivityName + SubjectID ~ variable, mean) 

## Write tidy data to disk
write.table(tidy, "tidy.txt")

## END of script ##
###################

