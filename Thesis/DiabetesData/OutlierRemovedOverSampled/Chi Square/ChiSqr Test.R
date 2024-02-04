#library(mRMRe)
library(Biocomb)
file_n<-paste0("E:/MSc/MScThesis/Thesis/DiabetesData/OutlierRemoved/ChiSquare/Diabetes_Dataset_Train80p.csv")
data <- read.csv(file_n, header = TRUE)

# class label must be factor
data[,17]<-as.factor(data$class)
disc<-"equal interval width"
#minimal description length (MDL), equal frequency and equal interval width
attrs.nominal=numeric()
out=select.inf.chi2(data,disc.method=disc,attrs.nominal=attrs.nominal)
write.csv(out,"E:/MSc/MScThesis/Thesis/DiabetesData/OutlierRemoved/ChiSquare/Chi Square Results with Ranks.csv")
