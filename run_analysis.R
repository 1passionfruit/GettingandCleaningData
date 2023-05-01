features<-read.table("features.txt", sep="")
featurenames<-features$V2

activity_lab<-read.table("activity_labels.txt", col.names=c("activity", "desc"))

##training data processing
trainSubjects<-read.table("train/subject_train.txt", header=FALSE, sep="", col.names=c("subject"))
trainX<-read.table("train/X_train.txt", col.names=featurenames) ##label training data with feature names
trainactlabels<-read.table("train/y_train.txt", col.names=c("activity"))
nmdtrainlabels<-inner_join(activity_lab,trainactlabels) ##activities name & num for training data
actnmsubtrain<-cbind(nmdtrainlabels,trainSubjects)##add subject ID column to training 
trainInertiaXTA<-read.table("train/Inertial Signals/total_acc_x_train.txt", col.names=(sprintf("Xta%d",seq(1:128))))
trainInertiaYTA<-read.table("train/Inertial Signals/total_acc_y_train.txt",col.names=(sprintf("Yta%d",seq(1:128))))
trainInertiaZTA<-read.table("train/Inertial Signals/total_acc_z_train.txt",col.names=(sprintf("Zta%d",seq(1:128))))
trainInertiaXBA<-read.table("train/Inertial Signals/body_acc_x_train.txt",col.names=(sprintf("Xba%d",seq(1:128))))
trainInertiaYBA<-read.table("train/Inertial Signals/body_acc_y_train.txt",col.names=(sprintf("Yba%d",seq(1:128))))
trainInertiaZBA<-read.table("train/Inertial Signals/body_acc_z_train.txt",col.names=(sprintf("Zba%d",seq(1:128))))
trainInertiaXBG<-read.table("train/Inertial Signals/body_gyro_x_train.txt",col.names=(sprintf("Xbg%d",seq(1:128))))
trainInertiaYBG<-read.table("train/Inertial Signals/body_gyro_y_train.txt",col.names=(sprintf("Ybg%d",seq(1:128))))
trainInertiaZBG<-read.table("train/Inertial Signals/body_gyro_z_train.txt",col.names=(sprintf("Zbg%d",seq(1:128))))

##bind all training data
bindalltrain<-actnmsubtrain %>% 
  bind_cols(trainInertiaXTA)%>%bind_cols(trainInertiaYTA)%>%
  bind_cols(trainInertiaZTA)%>%bind_cols(trainInertiaXBA)%>%
  bind_cols(trainInertiaYBA)%>%bind_cols(trainInertiaZBA)%>%
  bind_cols(trainInertiaXBG)%>%bind_cols(trainInertiaYBG)%>%
  bind_cols(trainInertiaZBG)%>%bind_cols(trainX)


##test data processing 
testSubjects<-read.table("test/subject_test.txt", header=FALSE, sep="", col.names=c("subject"))
testX<-read.table("test/X_test.txt", col.names=featurenames)
testactlabels<-read.table("test/y_test.txt", col.names=c("activity"))
nmdtestlabels<-inner_join(activity_lab,testactlabels) ##activities name & num for test data
actnmsubtest<-cbind(nmdtestlabels,testSubjects)##add subject ID column to test
testInertiaXTA<-read.table("test/Inertial Signals/total_acc_x_test.txt", col.names=(sprintf("Xta%d",seq(1:128))))
testInertiaYTA<-read.table("test/Inertial Signals/total_acc_y_test.txt",col.names=(sprintf("Yta%d",seq(1:128))))
testInertiaZTA<-read.table("test/Inertial Signals/total_acc_z_test.txt",col.names=(sprintf("Zta%d",seq(1:128))))
testInertiaXBA<-read.table("test/Inertial Signals/body_acc_x_test.txt",col.names=(sprintf("Xba%d",seq(1:128))))
testInertiaYBA<-read.table("test/Inertial Signals/body_acc_y_test.txt",col.names=(sprintf("Yba%d",seq(1:128))))
testInertiaZBA<-read.table("test/Inertial Signals/body_acc_z_test.txt",col.names=(sprintf("Zba%d",seq(1:128))))
testInertiaXBG<-read.table("test/Inertial Signals/body_gyro_x_test.txt",col.names=(sprintf("Xbg%d",seq(1:128))))
testInertiaYBG<-read.table("test/Inertial Signals/body_gyro_y_test.txt",col.names=(sprintf("Ybg%d",seq(1:128))))
testInertiaZBG<-read.table("test/Inertial Signals/body_gyro_z_test.txt",col.names=(sprintf("Zbg%d",seq(1:128))))

##bind all test data
bindalltest<-actnmsubtest %>% 
  bind_cols(testInertiaXTA)%>%bind_cols(testInertiaYTA)%>%
  bind_cols(testInertiaZTA)%>%bind_cols(testInertiaXBA)%>%
  bind_cols(testInertiaYBA)%>%bind_cols(testInertiaZBA)%>%
  bind_cols(testInertiaXBG)%>%bind_cols(testInertiaYBG)%>%
  bind_cols(testInertiaZBG)%>%bind_cols(testX)

##bind test and training data
bindall<-rbind(bindalltrain,bindalltest)
actnmsuball<-rbind(actnmsubtrain, actnmsubtest)
##extract any column with "mean" or "std()" in its name
colswithmean<-bindall[,grepl("mean", colnames(bindall))]
colswithsd<-bindall[,grepl("std()", colnames(bindall))]
##join the selected colums to the columns with activity data and subject
semifinal<-bind_cols(actnmsuball,colswithmean)
semifinal<-bind_cols(semifinal,colswithsd)
##group by activity name and subject
byactsub<-semifinal%>%group_by(desc,subject)
##summarize columns with measurements
finaldata<-summarize(byactsub,across(colnames(semifinal[4:82]),mean, .names="mean_{.col}"))
write.table(finaldata, file="finaldata.txt", row.names=FALSE)