rm(list=ls())
data<-read.csv("E:/MSc/MSc Thesis/Thesis/DiabetesData/OutlierRemoved/Inlier_Samples.csv")

library(caTools)
set.seed(123)
split=sample.split(data$Class,SplitRatio =0.80)

training=subset(data,split==TRUE)
testing=subset(data,split==FALSE)
write.csv(training,"E:/MSc/MSc Thesis/Thesis/DiabetesData/OutlierRemoved/Diabetes_Dataset_Train80p.csv")
write.csv(testing,"E:/MSc/MSc Thesis/Thesis/DiabetesData/OutlierRemoved./Diabetes_Dataset_Test20p.csv")
