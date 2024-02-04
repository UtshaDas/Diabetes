# -*- coding: utf-8 -*-
"""
Created on Sun Apr  3 12:40:03 2022

@author: BREB
"""


import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
from sklearn.ensemble import IsolationForest

df = pd.read_csv('Diabetes.csv')

df.head()

x = df.values

#plt.scatter(x[:,0], x[:,1])

clf = IsolationForest(contamination=.1)
print(clf.get_params())
clf.fit(x)
predictions = clf.predict(x)
(predictions<0).mean()
abn_ind = np.where(predictions < 0)
plt.scatter(x[:,0],x[:,1])
plt.scatter(x[abn_ind,0], x[abn_ind,1], edgecolors="r")