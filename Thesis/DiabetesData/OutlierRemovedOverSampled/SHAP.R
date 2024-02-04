library("titanic")
titanic <- titanic_train[,c("Survived", "Pclass", "Sex", "Age", "SibSp", "Parch", "Fare", "Embarked")]
titanic$Survived <- factor(titanic$Survived)
titanic$Sex <- factor(titanic$Sex)
titanic$Embarked <- factor(titanic$Embarked)
titanic <- na.omit(titanic)
head(titanic)

library("randomForest")
library("lime")
set.seed(123)
model_rf <- randomForest(Survived ~ . , data = titanic)
model_rf

new_passanger <- data.frame(
  Pclass = 1,
  Sex = factor("male", levels = c("female", "male")),
  Age = 8,
  SibSp = 0,
  Parch = 0,
  Fare = 72,
  Embarked = factor("C", levels = c("","C","Q","S"))
)
predict(model_rf, new_passanger, type = "prob")

library("DALEX")
#exp_rf <- explain(model_rf, data = titanic[1:20,-1])

library("shapper")
#ive_rf <- shap(exp_rf, new_observation = new_passanger)

library("e1071")
model_svm <- svm(Survived~. , data = titanic, probability = TRUE)
model_svm


exp_svm <- explain(model_svm, data = titanic[,-1])
ive_svm <- lime(exp_svm, new_passanger)