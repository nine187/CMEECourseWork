#!/usr/bin/env python coding: utf-8
# Author: Pasith Prayoonrat
# Script: data_prep.py
# Description: Data prep script
# Date: December 22

import pandas as pd
import seaborn as sns

#print the column
data = pd.read_csv("../data/LogisticGrowthData.csv")
print("Loaded {} columns.".format(len(data.columns.values)))
print(data.columns.values)

#look at the metadata
pd.read_csv("../data/LogisticGrowthMetaData.csv")

#glimpse into some data
data.head()

#print the response and independent variables unit
print(data.PopBio_units.unique()) #response variable unit
print(data.Time_units.unique()) #independent variable unit

#combine the columns
data.insert(1, "ID", data.Species + "_" + data.Temp.map(str) + "_" + data.Medium + "_" + data.Citation)
print(data.ID.unique())

### creates unique IDs ### 
data_subset = data[data['ID']=='Chryseobacterium.balustinum_5_TSB_Bae, Y.M., Zheng, L., Hyun, J.E., Jung, K.S., Heu, S. and Lee, S.Y., 2014. Growth characteristics and biofilm formation of various spoilage bacteria isolated from fresh produce. Journal of food science, 79(10), pp.M2072-M2080.']
data_subset.head()
data['ID'] = pd.factorize(data.ID)[0]
#replace the 0 ID with 285
data['ID'] = data['ID'].replace(0, 285)

#plot
sns.lmplot(x= "Time", y = "PopBio", data = data_subset, fit_reg = False) # will give warning - you can ignore it

### missing and problematic values ###


#delete all the negative PopBio and Time value since it could be an issue (negative population is illogical and negative time seems irrelevent)
data.drop(data[data["Time"] < 0].index, inplace=True)
data.drop(data[data["PopBio"] < 0].index, inplace=True)


### save the modified data to csv ###
data.to_csv('../results/Wrangled_Data.csv')