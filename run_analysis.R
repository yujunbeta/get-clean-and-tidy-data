setwd("F:/coursera/Data Science/peer assignment/get clean and tidy data/UCI HAR Dataset")
x_test<-read.table("./test/X_test.txt")
y_test<-read.table("./test/y_test.txt")
subject_test<-read.table("./test/subject_test.txt")
x_train<-read.table("./train/X_train.txt")
y_train<-read.table("./train/y_train.txt")
subject_train<-read.table("./train/subject_train.txt")

data_x<-rbind(x_train,x_test)
data_y<-rbind(y_train,y_test)
data_sub<-rbind(subject_train,subject_test)
data<-cbind(data_x,data_y,data_sub)

Extractmean<-sapply(data,mean)
Extractsd<-sapply(data,sd)

Human_Activity_Recognition<-data

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

stat<-paste("stat",1:561)
for(i in 1:561){
assign(stat[i],tapply(Human_Activity_Recognition[,i],Human_Activity_Recognition$subject,mean))
}

statdata<-NULL
for(i in 1:561){
statdata<-rbind(statdata,get(stat[i]))
}
rownames(statdata)<-dataname[-c(562,563)]

write.table(statdata,"statdata.txt",quote = F)
write.table(Human_Activity_Recognition,"Human_Activity_Recognition.txt",quote = F)
