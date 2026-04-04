---
layout: post
title: "Unit 8 Marketing Campaign ML model Assignment"
subtitle: "Machine Learning models comparison"
date: 2026-03-22
categories: [Module 4 Visualising Data]
tags: [Python,Matplotlib,seaborn,sklearn]
---

[NOTEBOOK](https://github.com/matt9891-stack/Assignment/blob/main/Assignment_Full.ipynb)

# Project Description

This project focuses on analysing a Portuguese bank marketing dataset with the objective of predicting whether a client will subscribe to a long-term deposit. 
The dataset contains demographic, financial, and campaign-related variables, providing a comprehensive view of customer behaviour and external economic conditions influencing decision-making.

# Data Inspection

The analysis begins with data preparation and preprocessing. The dataset is first inspected to understand its structure, variable types, and overall quality. 
Although no missing values are present, several categorical variables include “unknown” entries, which are carefully considered during the analysis due to their potential relationship with negative outcomes. 
Categorical variables are transformed using encoding techniques, while numerical features are standardised to ensure consistent scaling across variables. 
Additionally, class imbalance in the target variable is addressed using SMOTE, allowing the models to better learn patterns associated with the minority class.

# Exploratory Data Analysis

An Exploratory Data Analysis (EDA) is conducted to uncover patterns, trends, and relationships within the data. 
This includes examining the distribution of numerical variables such as age, call duration, and number of contacts, as well as analysing categorical features like job type, education level, and contact method. 
Outliers are identified using boxplots, particularly in variables such as call duration and previous contact timing, and are evaluated in the context of their real-world plausibility. 
Correlation analysis highlights key predictors, with call duration, recency of contact, and previous interactions emerging as the most influential factors affecting subscription likelihood.

# Machine Learning models implementation

Following the exploratory phase, two supervised machine learning models are developed to address the classification problem. 
Logistic Regression is implemented as a baseline probabilistic model, with additional optimisation through threshold tuning based on ROC curve analysis to improve its ability to identify positive cases. 
A Decision Tree model is also constructed, with hyperparameters such as maximum depth tuned using GridSearchCV to balance model complexity and performance. 
These models provide complementary perspectives, with one offering interpretability through linear relationships and the other capturing non-linear decision rules.

# Performances Evaluation

Model performance is evaluated using a range of metrics, including accuracy, precision, recall, F1-score, and confusion matrices. 
Particular attention is given to recall, as identifying potential subscribers is critical in a marketing context. 
The results highlight a trade-off between the models, where Logistic Regression achieves higher recall, making it more suitable for maximising customer reach, while the Decision Tree provides better precision, reducing the number of false positives and improving targeting efficiency.

