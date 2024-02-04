# -*- coding: utf-8 -*-
"""
Created on Sun May  7 23:43:12 2023

@author: BREB
"""

from collections import Counter
from imblearn.over_sampling import RandomOverSampler
import pandas as pd


#import data
df = pd.read_csv('Diabetes_Dataset_Train80p.csv')

df.info()

# Separating the independent variables from dependent variables
X = df.iloc[:,:-1]
y = df.iloc[:,-1]

# summarize class distribution
print("Before undersampling: ", Counter(y))

# define undersampling strategy
oversample = RandomOverSampler(sampling_strategy='minority')

# fit and apply the transform
X_under, y_under = oversample.fit_resample(X, y)

# summarize class distribution
print("After undersampling: ", Counter(y_under))

