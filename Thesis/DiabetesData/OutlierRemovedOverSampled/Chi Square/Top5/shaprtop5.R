rm(list=ls())
library(xgboost)
library(shapr)

data("Boston", package = "MASS")

x_var <- c("stab.glu", "ratio", "glyhb", "age","waist")
y_var <- "class"


training<-read.csv("C:/Users/BREB/OneDrive/Documents/MSc Thesis/Thesis/DiabetesData/OutlierRemovedOverSampled/Chi Square/Top5/SMOTEOversampled_Diabetes_Dataset_Train80p.csv")
testing<-read.csv("C:/Users/BREB/OneDrive/Documents/MSc Thesis/Thesis/DiabetesData/OutlierRemovedOverSampled/Chi Square/Top5/Diabetes_Dataset_Test20p.csv")



x_train <- as.matrix(training[, x_var])
y_train <- training[, y_var]
x_test <- as.matrix(testing[, x_var])

# Fitting a basic xgboost model to the training data
model <- xgboost(
  data = x_train,
  label = y_train,
  nround = 20,
  verbose = FALSE
)
explainer <- shapr(x_train, model)
#> The specified model provides feature classes that are NA. The classes of data are taken as the truth.

p <- mean(y_train)

explanation <- explain(
  x_test,
  approach = "gaussian",
  explainer = explainer,
  prediction_zero = p
)

print(explanation$dt)


# Plot the resulting explanations for observations 15 and 13, 10, 27, 31, 40, 
plot(explanation, plot_phi0 = FALSE, index_x_test = c(10, 27, 31, 40))
