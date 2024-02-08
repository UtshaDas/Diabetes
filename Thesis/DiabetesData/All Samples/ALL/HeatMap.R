#set.seed(123)                                                     # Set seed for reproducibility
#data<- matrix(rnorm(100, 0, 10), nrow = 10, ncol = 10)           # Create example data   
#colnames(data)<- paste0("col", 1:10)                             # Column names
#rownames(data)<- paste0("row", 1:10)                             # Row names
#head(data,5)



rm(list=ls())
data<-read.csv("./Diabetes_Dataset_Train80p.csv")
rownames(data)<- paste0("Sample", 1:299)
data<-data[,1:16]

heatmap(as.matrix(data), 
        main = "Heatmap for the Dataset", 
        xlab = "Features",
        ylab = "Samples") 