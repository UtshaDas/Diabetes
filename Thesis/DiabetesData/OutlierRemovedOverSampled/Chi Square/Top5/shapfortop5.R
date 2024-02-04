rm(list=ls())

library(shapper)

library(DALEX)
library(e1071)
library(pROC)
library(shapper)

training<-read.csv("C:/Users/BREB/OneDrive/Documents/MSc Thesis/Thesis/DiabetesData/OutlierRemovedOverSampled/Chi Square/Top5/SMOTEOversampled_Diabetes_Dataset_Train80p.csv")
testing<-read.csv("C:/Users/BREB/OneDrive/Documents/MSc Thesis/Thesis/DiabetesData/OutlierRemovedOverSampled/Chi Square/Top5/Diabetes_Dataset_Test20p.csv")


  
set.seed(131)
wts <- 100 / table(training$class)
  system.time(svm_tune <- tune(svm, train.x=training[,1:5], train.y=as.factor(training[,6]), 
                               kernel="radial",class.weights = wts,tunecontrol = tune.control(sampling = "cross"), ranges=list(cost=2^(-8:8), gamma=c(2^(-8:8)))))
  
  classifier=svm(formula=factor(class) ~ .,
                 data=training,
                 scale=TRUE,
                 type='C-classification',
                 kernel='radial',
                 probability = TRUE,
                 cost=svm_tune$best.parameters$cost,
                 gamma=svm_tune$best.parameters$gamma)
  print(classifier)
  attr(predict(classifier, newdata =  testing[,1:5], probability = TRUE), "probabilities")
  
  # Prepare the data for explanation
 
  exp_svm <- explain(classifier, data = training[,1:5])
  
  ive_svm <- shap(exp_svm, new_observation = testing[,1:5],  nsamples = "auto")
  
  plot(ive_svm)

