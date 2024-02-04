# -*- coding: utf-8 -*-
"""
Created on Thu Jun 30 11:01:24 2022

@author: BREB
"""

from sklearn.ensemble import RandomForestClassifier
model= RandomForestClassifier(n_estimators=340)
import pandas as pd 

data= pd.read_csv('Diabetes_Dataset_Train80p.csv')

X=data[["chol",	"stab.glu",	"hdl",	"ratio",	"glyhb",	"location",	"age",	"gender",	"height",	"weight",	"frame",	"bp.1s",	"bp.1d",	"waist",	"hip",	"time.ppn"]]
Y=data[["class"]]

model.fit(X,Y)

importances=model.feature_importances_
final_df=pd.DataFrame({"Features": pd.DataFrame(X).columns, "Importances":importances})
final_df.set_index("Importances")


final_df.plot.bar(color='teal')