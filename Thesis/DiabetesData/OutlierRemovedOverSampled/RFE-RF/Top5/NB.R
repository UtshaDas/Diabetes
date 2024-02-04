rm(list=ls())
library(e1071)

library(pROC)
training<-read.csv("C:/Users/BREB/OneDrive/Documents/MSc Thesis/Thesis/DiabetesData/OutlierRemovedOverSampled/RFE-RF/Top5/SMOTEOversampled_Diabetes_Dataset_Train80p.csv")
testing<-read.csv("C:/Users/BREB/OneDrive/Documents/MSc Thesis/Thesis/DiabetesData/OutlierRemovedOverSampled/RFE-RF/Top5/Diabetes_Dataset_Test20p.csv")


nb_default <- naiveBayes(as.factor(class)~., data=training,laplace = 3)
default_pred <- predict(nb_default, testing[,-6], type="class")

cm=table(default_pred, testing$class,dnn=c("Prediction","Actual"))

acc=((sum(diag(cm))/sum(cm)))
tp<-cm[2,2]
tn<-cm[1,1]
fn<-cm[1,2]
fp<-cm[2,1]

sen=tp/(tp+fn)
spe=tn/(tn+fp)
mcc=((tp*tn) - (fp*fn))/(sqrt((tp+fp)*(tp+fn)*(tn+fp)*(tn+fn)))
f1=2*tp/((2*tp)+fp+fn)

roc_obj<-roc(testing[,6],as.numeric(default_pred))
rocauc<-auc(roc_obj)
plot(roc_obj)
print('Accuracy')
print(acc)
print('sensitivity')
print(sen)
print('Specificity')
print(spe)
print('MCC')
print(mcc)
print('F1')
print(f1)
print('AUC')
print(rocauc)
