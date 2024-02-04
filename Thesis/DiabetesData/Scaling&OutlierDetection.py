import numpy as np
import pandas as pd 
import matplotlib.pyplot as plt
from sklearn.ensemble import IsolationForest
from sklearn.preprocessing import MinMaxScaler


data= pd.read_csv('Diabetes.csv')

scaler = MinMaxScaler(feature_range=(0, 1))
data[['chol','stab.glu','hdl','ratio','glyhb','age','height','weight','bp.1s','bp.1d','waist','hip','time.ppn']] = scaler.fit_transform(data[['chol','stab.glu','hdl','ratio','glyhb','age','height','weight','bp.1s','bp.1d','waist','hip','time.ppn']])

random_state = np.random.RandomState(40)
model=IsolationForest(n_estimators=100,max_samples='auto',contamination=.05,random_state=random_state)
model.fit(data)
print(model.get_params())

#data['scores'] = model.decision_function(data)

data['anomaly_score'] = model.predict(data)


data[data['anomaly_score']==1].to_csv('Inlier_Samples.csv')
data[data['anomaly_score']==-1].to_csv('Outlier_Samples.csv')

data=data.values
plt.scatter(data[:,3], data[:,4])

outlier=pd.read_csv('Outlier_Samples.csv')
outlier=outlier.values
plt.scatter(data[:,4], data[:,5], edgecolors="r")
plt.title("Data Visualization")
plt.xlabel("ratio")
plt.ylabel("glyhb")