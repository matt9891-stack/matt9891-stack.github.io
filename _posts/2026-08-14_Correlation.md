---
layout: post
title: "Exploratory Data Analysis Python - Unit 3"
subtitle: "Module 6 – Machine Learning - Correlation"
date: 2026-08-14
categories: [Module 6 Machine Learning]
tags: [EDA, Python]
---

# Pearson’s Correlation

Pearson’s correlation is a statistical measure used to describe the strength and direction of the linear relationship between two numerical variables.

In this example, I use Study Hours and Exam Score to understand whether students who study more hours tend to achieve higher exam scores.

    import numpy as np
    import matplotlib.pyplot as plt
    from scipy.stats import pearsonr
    
# 1. Preparing the data

First, two numerical variables are created:

    study_hours = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    exam_score = np.array([45, 50, 54, 60, 65, 68, 73, 78, 84, 88])

study_hours represents the number of hours studied, while exam_score represents the score obtained in the exam.

Each position in the two arrays represents one student.

# 2. Covariance

Before calculating Pearson’s correlation, it is useful to understand covariance.

Covariance measures whether two variables tend to change together.

The sample covariance is calculated as:

$r = \frac{\text{Cov}(X,Y)}{s_x \times s_y}$

The formula compares each value with its variable's mean.

If both values are above or both are below their means, their contribution is positive.
If one value is above its mean and the other is below, their contribution is negative.

Therefore, a positive covariance indicates that the two variables tend to increase together, while a negative covariance indicates that when one increases, the other tends to decrease.

In Python, covariance can be calculated using:

    covariance = np.cov(study_hours, exam_score)[0, 1]

np.cov() returns a covariance matrix. The [0, 1] position gives the covariance between study_hours and exam_score.

However, covariance has a limitation, as its value depends on the units of the variables, making it difficult to interpret the strength of the relationship directly.

# 3. Pearson’s correlation

Pearson’s correlation solves this problem by standardising the covariance using the standard deviation of both variables.

The formula is:


$r=\frac{Cov(X,Y)}{s_Xs_Y}$
  

where:

Cov(X,Y) is the covariance between the two variables.
sX is the standard deviation of X.
sY is the standard deviation of Y.

The result, called the Pearson correlation coefficient (r), is always between -1 and +1.

+1 = perfect positive linear relationship

<img width="173" height="221" alt="image" src="https://github.com/user-attachments/assets/302efb04-1bdb-4c8c-a065-7f84f65a8888" />

0 = no linear relationship

<img width="168" height="228" alt="image" src="https://github.com/user-attachments/assets/754f3cde-29dd-473c-865d-c224a65dc110" />


-1 = perfect negative linear relationship

<img width="170" height="231" alt="image" src="https://github.com/user-attachments/assets/355df277-1f79-41b7-b427-7edbb8a53128" />

Values close to +1 indicate a strong positive linear relationship, while values close to -1 indicate a strong negative linear relationship.

In Python, Pearson’s correlation is calculated using:

    correlation, p_value = pearsonr(study_hours, exam_score)
    
The correlation variable contains the Pearson correlation coefficient, while p_value provides a statistical test of whether the observed correlation is statistically significant.

<img width="228" height="43" alt="image" src="https://github.com/user-attachments/assets/c97939a5-a490-4f71-8edc-c019c1f71c71" />


# 4. Visualising the relationship

A scatter plot can be used to visualise the relationship between the two variables:

    plt.scatter(study_hours, exam_score)
    
    plt.xlabel("Study Hours")
    plt.ylabel("Exam Score")
    plt.title("Study Hours vs Exam Score")
    
    plt.show()

<img width="562" height="455" alt="image" src="https://github.com/user-attachments/assets/ea5a54e1-baf1-44b8-87ee-18d9ea2a69c6" />

# 5. Interpreting the result

The result can be interpreted by considering both the direction and the strength of the correlation.

For this dataset, Pearson’s correlation is strongly positive which means that higher study hours are associated with higher exam scores in the sample.

However, correlation does not necessarily mean causation as a positive correlation does not prove that studying more hours directly causes a higher exam score. 

Other factors, such as previous knowledge, study quality, motivation or teaching methods, could also influence exam performance.

Therefore, Pearson’s correlation is useful for identifying and measuring a linear relationship between variables.
