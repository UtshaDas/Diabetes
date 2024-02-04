# -*- coding: utf-8 -*-
"""
Created on Thu Jun 30 10:04:25 2022

@author: Utsha Das
"""

from sklearn.linear_model import LogisticRegression
from sklearn.feature_selection import SelectFromModel
import pandas as pd 

data= pd.read_csv('Diabetes_Dataset_Train80p.csv')

X=data[["chol",	"stab.glu",	"hdl",	"ratio",	"glyhb",	"location",	"age",	"gender",	"height",	"weight",	"frame",	"bp.1s",	"bp.1d",	"waist",	"hip",	"time.ppn"]]
Y=data[["class"]]

logistic=LogisticRegression(C=1,penalty="l1",solver='liblinear',random_state=7).fit(X,Y)
model=SelectFromModel(logistic,prefit=True)

X_new=model.transform(X)

selected_features = pd.DataFrame(model.inverse_transform(X_new), 
                                 index=X.index,
                                 columns=X.columns)


Selected_columns=selected_features.columns[selected_features.var()!=0]

print(Selected_columns)