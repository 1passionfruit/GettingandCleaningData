trainSubjects<-read.table("train/subject_train.txt", header=FALSE, sep="", col.names=c("subject"))

features<-read.table("features.txt", sep="")

activity_lab<-read.table("activity_labels.txt", col.names=c("activity", "desc"))

trainX<-read.table("train/X_train.txt")
trainactlabels<-read.table("train/y_train.txt", col.names=c("activity"))
nmdtestlabels<-inner_join(activity_lab,testactlabels) ##activities name & num for test data


testX<-read.table("test/X_test.txt")
testactlabels<-read.table("test/y_test.txt", col.names=c("activity"))
nmdtrainlabels<-inner_join(activity_lab,trainactlabels) ##activities name & num for training data

trainInertiaXTA<-read.table("train/Inertial Signals/total_acc_x_train.txt")
trainInertiaYTA<-read.table("train/Inertial Signals/total_acc_y_train.txt")
trainInertiaZTA<-read.table("train/Inertial Signals/total_acc_z_train.txt")

trainInertiaXBA<-read.table("train/Inertial Signals/body_acc_x_train.txt")
trainInertiaYBA<-read.table("train/Inertial Signals/body_acc_y_train.txt")
trainInertiaZBA<-read.table("train/Inertial Signals/body_acc_z_train.txt")

trainInertiaXBG<-read.table("train/Inertial Signals/body_gyro_x_train.txt")
trainInertiaYBG<-read.table("train/Inertial Signals/body_gyro_y_train.txt")
trainInertiaZBG<-read.table("train/Inertial Signals/body_gyro_z_train.txt")
