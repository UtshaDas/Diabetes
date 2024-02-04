rm(list=ls())

library(shapper)
library(lime)
library(MASS)
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
classifier<-as_classifier(classifier, labels = NULL)

#training<-as.data.frame(training)
#testing<-as.data.frame(testing)

explainer <- lime(training, classifier)
#testing[,6]=factor(testing[,6])

explanation <- explain(testing,explainer,
                       labels= c("0","1"),
                       n_features=5,
                       n_permutations = 5000,
                       feature_select = "auto",
                       dist_fun = "gower",
                       kernel_width = NULL,
                       gower_pow = 1)

# explanation <- explain(
#   x = train, 
#   explainer = explainer_svm, 
#   n_permutations = 5000,
#   dist_fun = "gower",
#   kernel_width = .75,
#   n_features = 5,
#   feature_select = "auto",
#   labels= c("1")
# )
plot_features(explanation)
