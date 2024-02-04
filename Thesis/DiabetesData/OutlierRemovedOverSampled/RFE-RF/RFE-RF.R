rm(list=ls())
data<-read.csv("C:/Users/BREB/OneDrive/Documents/MSc Thesis/Thesis/DiabetesData/OutlierRemoved/RFE-RF/Diabetes_Dataset_Train80p.csv")

library(caret)


# define the control using a random forest selection function
control <- rfeControl(functions=rfFuncs, method="LOOCV")
# run the RFE algorithm
system.time(results <- rfe(data[,1:16], as.factor(data[,17]),sizes =c(1:6), rfeControl=control))
# summarize the results
print(results)
# list the chosen features
rfeRanked = predictors(results)
# plot the results

write.csv(results[["variables"]],"C:/Users/BREB/OneDrive/Documents/MSc Thesis/Thesis/DiabetesData/OutlierRemoved/RFE-RF/RFE-RF Results with Ranks.csv")

plot(results, type=c("g", "o"))