Read Me
========================================================

This is the peer assigment for the course getting and cleaning data.The main R code is show here.
## loading the data

```r
setwd("F:/coursera/Data Science/peer assignment/get clean and tidy data/UCI HAR Dataset")
x_test<-read.table("./test/X_test.txt")
y_test<-read.table("./test/y_test.txt")
subject_test<-read.table("./test/subject_test.txt")
x_train<-read.table("./train/X_train.txt")
y_train<-read.table("./train/y_train.txt")
subject_train<-read.table("./train/subject_train.txt")
```

## merging the data

```r
data_x<-rbind(x_train,x_test)
data_y<-rbind(y_train,y_test)
data_sub<-rbind(subject_train,subject_test)
data<-cbind(data_x,data_y,data_sub)
```

## Extracts only the measurements on the mean and standard deviation for each measurement

```r
Extractmean<-sapply(data,mean)
Extractsd<-sapply(data,sd)
```
## name of the dataset
The name of this dataset I use the title of UCI machine learning repository,name the dataset as Human_Activity_Recognition.

```r
Human_Activity_Recognition<-data
```

## name of each variable
The name of each variable use the information given in the activity_label file.The code of dealing the string is here:

```r
name<-read.table("./features.txt",stringsAsFactors = F)
namenew<-strsplit(name[,2],"-")

rr<-NULL
for(i in 1:502){
rr[i]<-paste(namenew[[i]][2],namenew[[i]][1],
 "-",namenew[[i]][3],sep="")
}
for(i in 503:554){
rr[i]<-paste(namenew[[i]][2],namenew[[i]][1],sep="")
}
rrr<-NULL
for(i in 555:561)
  rrr[i]<-namenew[[i]]


r<-chartr("()", "OF", rr)
dataname<-c(r,rrr[555:561],"labels","subject")
colnames(Human_Activity_Recognition)<-dataname

Human_Activity_Recognition$subject<-factor(Human_Activity_Recognition$subject)
```
## new dataset of independent tidy data set with the average of each variable for each activity and each subject
The R code:

```r
stat<-paste("stat",1:561)
for(i in 1:561){
assign(stat[i],tapply(Human_Activity_Recognition[,i],Human_Activity_Recognition$subject,mean))
}

statdata<-NULL
for(i in 1:561){
statdata<-rbind(statdata,get(stat[i]))
}
rownames(statdata)<-dataname[-c(562,563)]
```
At last ,we use the follow code to save the clean and tidy dataset:

```r
write.table(statdata,"statdata.txt",quote = F)
write.table(Human_Activity_Recognition,"Human_Activity_Recognition.txt",quote = F)
```
Now we get the dataset I uploaded before.
