---
layout: post
title: "Exploratory Data Analysis Python - Unit 3"
subtitle: "Module 6 – Machine Learning - Regularisation Linear Regression"
date: 2026-08-18
categories: [Module 6 Machine Learning]
tags: [EDA, Python]
---
# Regularised Linear Regression

Linear Regression tries to find coefficients that minimise the prediction error.

When the dataset contains many features, highly correlated variables, or polynomial features, the model can become too complex and may fit the training data too closely.

This can lead to overfitting.

Regularisation addresses this problem by adding a penalty to the model's objective function.

The penalty discourages the model from assigning excessively large coefficients to the features.

There are three important regularised linear regression techniques:

Ridge Regression → L2 regularisation
Lasso Regression → L1 regularisation
Elastic Net → combination of L1 and L2 regularisation

Regularisation could be particularly useful with Polynomial Features because Polynomial Regression can create a large number of features.

As the polynomial degree increases, the number of features can grow rapidly, giving the model greater flexibility but also increasing the risk of overfitting.

Regularisation can help control this complexity by penalising large coefficients.

# 1. Ridge Regression

Ridge Regression uses L2 regularisation.

The objective function can be represented as:

$$
\text{Loss} =
\text{MSE} +
\alpha \sum_{j=1}^{p}\beta_j^2
$$

The additional term penalises large coefficients.

The parameter controlling the strength of this penalty is called alpha in Scikit-learn.

# How alpha works

alpha = 0
    ↓
No regularisation
    ↓
Similar to standard Linear Regression

Small alpha
    ↓
Weak regularisation

Large alpha
    ↓
Strong regularisation
    ↓
Coefficients become smaller

If alpha is too large, however, the model can become too constrained and may underfit the data.

# Finding the best alpha with RidgeCV

Instead of choosing alpha manually, we can use RidgeCV.

     import numpy as np
    import pandas as pd
      import matplotlib.pyplot as plt
      import seaborn as sns

    from sklearn.linear_model import RidgeCV

    df=pd.read_csv('Advertising.csv')

    X=df.drop('sales',axis=1)
    y=df['sales']
    
    X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.3,random_state=101)
    
    scaler = StandardScaler()

    X_train=scaler.fit_transform(X_train)

    X_test=scaler.transform(X_test)

    alphas = np.logspace(-3,3,10)
    ridge_cv_model = RidgeCV(alphas=alphas)

    ridge_cv_model.fit(X_train,y_train)

<img width="595" height="81" alt="image" src="https://github.com/user-attachments/assets/5f98d922-3e95-4b47-ab19-8a51517e4773" />

    print(ridge_cv.alpha_)

<img width="157" height="26" alt="image" src="https://github.com/user-attachments/assets/7ebe7515-a325-44f4-b1e7-61e01381f9cb" />

# Making predictions with Ridge

Once the model has been fitted:

    ridge_model = Ridge(alpha=0.021544346900318832)
  
    ridge_model.fit(X_train,y_train)

  <img width="236" height="54" alt="image" src="https://github.com/user-attachments/assets/8d960fa8-fa69-47e8-a552-49cc0207d97a" />

    ridge_predictions = ridge_model.predict(X_test_scaled)

  <img width="579" height="200" alt="image" src="https://github.com/user-attachments/assets/c8e1852e-58ae-48a1-9609-50520c980ccd" />


We can evaluate it using MAE and RMSE:

    from sklearn.metrics import mean_absolute_error, mean_squared_error
    
    MAE = mean_absolute_error(y_test, ridge_predictions)
    
    MSE = mean_squared_error(y_test, ridge_predictions)
    
    RMSE = np.sqrt(MSE)
    
    print(f'MAE: {MAE:.3f}')
    print(f'RMSE: {RMSE:.3f}')
    
<img width="334" height="22" alt="image" src="https://github.com/user-attachments/assets/f0f12c14-1d3a-4bf3-ad2c-b679cd71c987" />

# 2. Lasso Regression

Lasso stands for:

Least Absolute Shrinkage and Selection Operator.

Lasso uses L1 regularisation.

Its objective function can be represented as:

$$
\text{Loss} =
\text{MSE} +
\alpha \sum_{j=1}^{p}|\beta_j|
$$

The difference from Ridge is the type of penalty:

Ridge → β²
Lasso → |β|

This difference has an important consequence.

Lasso can force some coefficients to become exactly zero.

For example:

Feature              Coefficient

TV                    0.82
Radio                 0.45
Newspaper             0.00
TV × Radio            0.13
TV²                   0.00
Radio²                0.07

The features with coefficients equal to zero are effectively excluded from the model.

Therefore, Lasso can perform a form of automatic feature selection.

# Finding the best alpha with LassoCV

Instead of manually selecting alpha, we can use LassoCV.

    from sklearn.linear_model import LassoCV

    lasso_cv = LassoCV(
        cv=5,
        max_iter=100000
    )

    lasso_cv.fit(X_train_scaled, y_train)

The model tests different alpha values using 5-Fold Cross-Validation.

We can then retrieve the selected alpha:

    print(lasso_cv.alpha_)

<img width="165" height="28" alt="image" src="https://github.com/user-attachments/assets/f936ff66-33a6-4af3-84fa-289eac28b5d0" />


One of the advantages of Lasso is that I can inspect which coefficients have been reduced to zero.

    lasso_cv.coef_

<img width="580" height="76" alt="image" src="https://github.com/user-attachments/assets/fb04ab9a-26f3-4843-bc76-2e5d1044c26d" />

A coefficient of zero means that Lasso has excluded that feature from the final linear model.

This can be particularly useful when Polynomial Features have generated a large number of variables.

# Lasso predictions

    lasso_predictions = lasso_cv.predict(X_test_scaled) 
    
    MAE = mean_absolute_error(y_test, lasso_predictions) 
    
    MSE = mean_squared_error(y_test, lasso_predictions) 
    
    RMSE = np.sqrt(MSE) 
    
    print(f'MAE: {MAE:.3f}') print(f'RMSE: {RMSE:.3f}')

<img width="348" height="29" alt="image" src="https://github.com/user-attachments/assets/19f6ae16-d42c-4704-aed6-589c92bcd7ee" />

# 3. Elastic Net Regression

Elastic Net combines the two approaches.

It uses both:

L1 regularisation, from Lasso
L2 regularisation, from Ridge

The objective function can be represented conceptually as:

$$\text{MSE}
+
\alpha
\left[
l1_ratio\sum|\beta_j|
+
(1-l1_ratio)\sum\beta_j^2
\right]
$$

The two important parameters are:

Alpha, which controls the overall strength of regularisation.

Higher alpha
→ stronger regularisation

L1 ratio, which controls the balance between Lasso and Ridge.

l1_ratio = 1
        ↓
Lasso-like behaviour

l1_ratio = 0
        ↓
Ridge-like behaviour

Values between 0 and 1 combine the two penalties.

# ElasticNetCV

As with Ridge and Lasso, we can use Cross-Validation to find suitable parameters.

    from sklearn.linear_model import ElasticNetCV

    elastic_cv = ElasticNetCV(
        l1_ratio=[0.1, 0.5, 0.7, 0.9, 1.0],
        cv=5,
        max_iter=100000
    )

    elastic_cv.fit(X_train_scaled, y_train)

Here we are testing several values of l1_ratio.

The model also searches for an appropriate value of alpha.

We can then inspect the selected parameters:

    print("Best alpha:", elastic_cv.alpha_)
    print("Best l1_ratio:", elastic_cv.l1_ratio_)

# Making Elastic Net Predictions

    elastic_predictions = elastic_cv.predict(X_test_scaled)

We can then calculate the performance metrics:

    MAE = mean_absolute_error(y_test, elastic_predictions)
    
    MSE = mean_squared_error(y_test, elastic_predictions)
    
    RMSE = np.sqrt(MSE)
    
    print(f'MAE: {MAE:.3f}')
    print(f'RMSE: {RMSE:.3f}')

# Conclusion


The main differences can be summarised as follows:

<img width="486" height="159" alt="image" src="https://github.com/user-attachments/assets/fd81d28d-17e8-4788-920d-02ef7e912e3d" />


A useful conceptual comparison is:

Ridge -> Keeps all features -> Shrinks their coefficients


Lasso -> Can remove features-> Some coefficients become exactly zero


Elastic Net -> Combines both approaches -> Useful when there are many correlated features
