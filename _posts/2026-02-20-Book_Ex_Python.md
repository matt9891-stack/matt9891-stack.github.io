---
layout: post
title: ""Unit 4 Data Visualisation Learnings Activity""
subtitle: "Book Exercises Python"
date: 2026-02-20
categories: [Module 3 Deciphering Big Data]
tags: [Python,Matplotlib,seaborn]
---
[PYTHON SCRIPT](https://github.com/matt9891-stack/Excercies/blob/main/Book_excercises.ipynb)

Data Visualisation with Python (Seaborn & Matplotlib) 

This guide demonstrates data visualisation in Python using Seaborn and Matplotlib with the mpg dataset. The examples cover scatterplots, regression lines, histograms, density plots, boxplots, and faceted charts. 
Each example includes an explanation of the code and visualisation logic.

# 1. Setup
    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import seaborn as sns

### Load the built-in mpg dataset
    df = sns.load_dataset("mpg")

pandas and numpy are used for data manipulation.

matplotlib.pyplot is the base plotting library.

seaborn is built on Matplotlib and simplifies statistical plots.

# 2. Explore the Dataset
### Quick overview of data structure
    df.info()
    
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 398 entries, 0 to 397
Data columns (total 9 columns):
 #   Column        Non-Null Count  Dtype  
---  ------        --------------  -----  
 0   mpg           398 non-null    float64
 1   cylinders     398 non-null    int64  
 2   displacement  398 non-null    float64
 3   horsepower    392 non-null    float64
 4   weight        398 non-null    int64  
 5   acceleration  398 non-null    float64
 6   model_year    398 non-null    int64  
 7   origin        398 non-null    object 
 8   name          398 non-null    object 
dtypes: float64(4), int64(3), object(2)
memory usage: 28.1+ KB

Shows number of rows, columns, missing values, and data types.

mpg has 398 rows, 9 columns, including numeric and categorical variables.

# 3. Scatterplots and Aesthetic Mappings

Seaborn allows mapping variables to visual aesthetics like colour, size, and style.

### Colour by model year
    sns.scatterplot(data=df, x='displacement', y='horsepower', hue='model_year')
    plt.show()
    
<img width="571" height="432" alt="image" src="https://github.com/user-attachments/assets/5feb390a-2b08-44e5-b0f3-3187393a5e50" />

hue adds colour based on a variable (here, model year).

### Style by model year

    sns.scatterplot(data=df, x='displacement', y='horsepower', style='model_year')
    plt.show()
    
<img width="571" height="432" alt="image" src="https://github.com/user-attachments/assets/01ecec17-9ec6-4080-b2e1-c63de4a0eebf" />

style changes marker type by variable.

### Size by weight

    sns.scatterplot(data=df, x='displacement', y='horsepower', size='weight')
    plt.show()
    
<img width="571" height="432" alt="image" src="https://github.com/user-attachments/assets/cda6500f-2ff7-4479-971e-5a33528ad714" />

size maps a continuous variable to marker size.

### Transparency via alpha

    sns.scatterplot(data=df, x='displacement', y='horsepower', size='weight', alpha=0.5)
    plt.show()
    
<img width="571" height="432" alt="image" src="https://github.com/user-attachments/assets/d367ff37-8e77-4e93-8f25-e0404fe8c646" />

Alpha controls transparency.
Unlike ggplot2 in R, Matplotlib scatter cannot map a variable directly to alpha. Attempting plt.scatter(x, y, alpha=df['weight']) raises a ValueError because alpha must be between 0 and 1.

# 4. Fixed Colours

### Fixed colour points

    sns.scatterplot(data=df, x='displacement', y='horsepower', color='red')
    plt.show()
    
<img width="571" height="432" alt="image" src="https://github.com/user-attachments/assets/2ead3534-a7b6-4263-ba8b-878a8004020c" />

Sets all points to red.

Works similarly to ggplot2’s geom_point(color = 'red').

# 5. Regression Lines (Geometric Objects)

## 5.1 Simple Regression

## Polynomial regression of order 3

    sns.regplot(data=df, x='displacement', y='horsepower', order=3)
    plt.show()
    
<img width="571" height="432" alt="image" src="https://github.com/user-attachments/assets/72078b7f-33af-4ec5-9ad7-f008fac82bb2" />

regplot() adds a regression line.

order=3 fits a cubic polynomial.

## 5.2 Limitation: hue not supported in regplot

### This will raise an error

     sns.regplot(data=df, x='displacement', y='horsepower', hue='model_year')

---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
Cell In[23], line 3
      1 # add more variables
----> 3 sns.regplot(data=df,x='displacement',y='horsepower', hue = 'model_year',order = 3)

TypeError: regplot() got an unexpected keyword argument 'hue'

regplot() cannot separate regression by groups.

Instead, use lmplot().

## 5.3 Grouped Regression with lmplot

### Regression line per model year

    sns.lmplot(data=df, x='displacement', y='horsepower', hue='model_year')
    plt.show()

<img width="577" height="489" alt="image" src="https://github.com/user-attachments/assets/f53a4dbf-37be-4089-b982-33762e6a5a4f" />

lmplot() automatically creates separate regression lines for each hue category.

### Remove regression lines, only show points

    sns.lmplot(data=df, x='displacement', y='horsepower', hue='model_year', fit_reg=False)
    plt.show()

<img width="577" height="489" alt="image" src="https://github.com/user-attachments/assets/846e256f-73f4-4469-83b5-35f9c0f519a7" />

fit_reg=False disables regression, useful if you want only the scatterplot.

# Add regression line over points without duplicating scatter

    sns.lmplot(data=df, x='displacement', y='horsepower', hue='model_year', fit_reg=False)  
    sns.regplot(data=df, x='displacement', y='horsepower', scatter=False, order=3, color='r')
    plt.show()

<img width="577" height="489" alt="image" src="https://github.com/user-attachments/assets/d078a0e9-550d-4b8a-a683-d956b9931be4" />
    
Here, regplot() overlays a single regression line without scatter points.    

# 6. Highlighting Specific Subsets

### Highlight cars in the top 5% for displacement or horsepower

    sns.scatterplot(data=df, x='displacement', y='horsepower')
    sns.scatterplot(
        data=df[(df['displacement'] > df['displacement'].quantile(0.95)) | 
            (df['horsepower'] > df['horsepower'].quantile(0.95))],
    x='displacement', y='horsepower', color='red'
    )
    plt.show()

<img width="571" height="432" alt="image" src="https://github.com/user-attachments/assets/746f537d-42d4-4519-8c8b-352224e88476" />

Uses Boolean filtering to highlight extreme values.

Red points show cars in the top 5% for displacement or horsepower.

# 7. Distribution Plots

## 7.1 Histogram

    sns.displot(data=df, x='mpg', bins=50)
    plt.show()

<img width="489" height="490" alt="image" src="https://github.com/user-attachments/assets/695679fc-f8bd-4621-9834-ab9a124dba10" />

displot() creates a histogram.

bins controls the number of bins.

## 7.2 Density Plot

    sns.kdeplot(data=df, x='mpg', fill=True)
    plt.axvline(df['mpg'].mean(), color='r', linestyle='--')
    plt.show()

<img width="576" height="432" alt="image" src="https://github.com/user-attachments/assets/d3f0c0b9-eef1-4989-bb01-92020e77c685" />

kdeplot() shows the smoothed density.

fill=True fills under the curve.

plt.axvline() adds a vertical line for the mean.

## 7.3 Boxplot

    sns.boxplot(data=df, x='model_year', orient='h')
    plt.show()

<img width="520" height="433" alt="image" src="https://github.com/user-attachments/assets/227108e0-ea3e-44f2-a742-6da83abedb01" />

Visualises median, quartiles, and outliers.

orient='h' makes the plot horizontal.

# 8. Faceting (Multiple Panels)

### Create a grid of scatterplots by model year

    g = sns.FacetGrid(data=df, col='model_year', col_wrap=4)
    g.map_dataframe(sns.scatterplot, x='displacement', y='horsepower')
    plt.show()

<img width="1189" height="1190" alt="image" src="https://github.com/user-attachments/assets/cd31993f-c696-42b2-9f49-3d492e899a49" />

FacetGrid splits the plot into multiple subplots.

col_wrap defines how many plots per row.

Works similarly to ggplot2’s facet_wrap(~model_year).
