---
layout: post
title: "Exploratory Data Analysis Python - Unit 4"
subtitle: "Module 6 – Machine Learning - Linear Regression"
date: 2026-08-14
categories: [Module 6 Machine Learning]
tags: [EDA, Python]
---

# Linear Regression

Linear Regression is a supervised learning and statistical method used to model the relationship between a dependent variable (Y) and one or more independent variables (X).

The main objective is to use the values of the independent variables to estimate the value of the dependent variable.

# Simple Linear Regression

When there is only one independent variable, the relationship can be represented by a straight line:

$$y = b0 + b1x$$

where:

y is the predicted value of the dependent variable.
x is the independent variable.
b0 is the intercept, which represents the predicted value of y when x = 0.
b1 is the slope, which represents how much the predicted value of y changes when x increases by one unit.

# Multiple Linear Regression

When more than one independent variable is used, the equation becomes:

$$y = b0 + b1x1 + b2x2 + ... + bnxn$$

Each coefficient represents the expected change in y associated with a one-unit increase in that predictor, while keeping the other predictors constant.

The main challenge is to find the values of the coefficients that produce the best-fitting line.

For every observation, the model produces a predicted value:

$$y = b0 + b1X1$$

The difference between the actual value and the predicted value is called the residual.

The Ordinary Least Squares (OLS) method finds the coefficients that minimise the sum of the squared residuals.

# Ordinary Least Squares (OLS) Regression

Ordinary Least Squares (OLS) is a statistical method used to estimate the relationship between a dependent variable and one or more independent variables.

In this example, I use the Auto MPG dataset to predict mpg (miles per gallon) using information about the cars, such as cylinders, displacement, horsepower, weight, acceleration, model year, origin and car name.

# Preparing the data

First, the dataset is loaded using pandas:

    import pandas as pd
    import numpy as np

    df = pd.read_csv('Auto-mpg.csv')
    df.head()

<img width="821" height="171" alt="image" src="https://github.com/user-attachments/assets/8ba97cfb-82b3-4de4-a037-626b04656948" />


The target variable is mpg, while the remaining variables are used as predictors:

    X = df.drop(columns='mpg')
    y = df['mpg']

Here:

X contains the independent variables.
y contains the dependent variable that the model is trying to predict.

# Converting horsepower into a numerical variable

The horsepower column contains some values that need to be treated as missing or non-numeric values. I therefore convert the column to numeric format:

    df['horsepower'] = pd.to_numeric(
        df['horsepower'],
        errors='coerce'
    )

Using errors='coerce' means that values that cannot be converted to numbers are replaced with NaN. These missing values can then be handled during preprocessing.

# Separating numerical and categorical variables

The numerical variables are:

    numeric_features = [
        'cylinders',
        'displacement',
        'horsepower',
        'weight',
        'acceleration',
        'model year'
    ]

The categorical variables are:

    categorical_features = [
        'origin',
        'car name'
    ]

This separation is important because numerical and categorical variables require different preprocessing techniques.

# Preprocessing numerical variables

    X_numeric = numeric_pipeline.fit_transform(df[numeric_features])
    
    df_reg = pd.DataFrame(X_numeric,columns = numeric_features,index = df.index)
    df_reg

<img width="582" height="366" alt="image" src="https://github.com/user-attachments/assets/0488893e-222d-4f0c-b410-2dd6f03e3147" />

# Categorical variables require a different approach:

    categorical_pipeline = Pipeline([
        ('imputer', SimpleImputer(strategy='most_frequent')),
        ('onehot', OneHotEncoder(handle_unknown='ignore'))
    ])

Missing categorical values are replaced with the most frequent category.

OneHotEncoder then converts categorical variables into numerical binary columns.

For example, if origin contains three categories, these can be transformed into separate columns representing each category.

handle_unknown='ignore' is useful because it prevents an error if a new category appears when the model is later used on new data.

# Creating the final modelling dataset

The numerical and categorical variables are combined with the target variable:

    X_categorical = categorical_pipeline.fit_transform(
        df[categorical_features]
    )
    
    X_categorical_columns = (
        categorical_pipeline
        .named_steps['onehot']
        .get_feature_names_out(categorical_features)
    )
    
    X_categorical_df = pd.DataFrame(
        X_categorical.toarray(),
        columns=X_categorical_columns,
        index=df.index
    )
    
    df_ml = pd.concat(
        [
            df_reg,
            X_categorical_df,
            df[['mpg']]
        ],
        axis=1
    )

The resulting df_ml contains only numerical variables, making it suitable for regression modelling.

# OLS Regression
# Splitting the data

Before fitting the model, the data are divided into training and testing sets:

    X = df_ml.drop(columns='mpg')
    y = df_ml['mpg']

    X_train, X_test, y_train, y_test = train_test_split(
        X,
        y,
        test_size=0.2,
        random_state=42
    )

80% of the data are used for training and 20% for testing.

The random_state=42 makes the split reproducible.

# Fitting the OLS model

I use statsmodels to fit an OLS regression model:

    import statsmodels.api as sm
    
    X_train = sm.add_constant(X_train)
    
    model = sm.OLS(y_train, X_train)
    results = model.fit()
    
    results.summary()

<img width="721" height="559" alt="image" src="https://github.com/user-attachments/assets/4498453c-a17b-400c-942d-2f2c3f736105" />


sm.add_constant() adds the intercept to the model.

The OLS method estimates the coefficients by minimising the sum of squared residuals, where a residual is the difference between the observed and predicted value.

In simple terms, OLS finds the coefficients that produce the smallest overall squared prediction error on the training data.

# How to Read the OLS Table

<img width="450" height="251" alt="image" src="https://github.com/user-attachments/assets/6eee5b97-0f53-420a-b099-0dae0e293418" />


The OLS summary contains several statistics that can be used to understand the model and its individual predictors.

# R-squared (R²)

R² measures the proportion of the variability in the dependent variable that is explained by the predictors included in the model.

R² ranges from 0 to 1 in the usual regression setting, with higher values indicating that the model explains a larger proportion of the variation in the target variable.

However, a high R² does not automatically mean that the model is appropriate or that the relationships are causal.

# Adjusted R-squared

Adjusted R² is similar to R² but takes the number of predictors and the sample size into account.

Unlike ordinary R², it does not automatically increase when another predictor is added.

Therefore, Adjusted R² can decrease when a new variable does not provide enough additional explanatory information.

This makes it useful when comparing models with different numbers of predictors.

# F-statistic

The F-statistic tests the overall significance of the regression model.

The null hypothesis is that all slope coefficients are equal to zero under which, none of the predictors provides a linear contribution to explaining the target variable.

A larger F-statistic generally provides more evidence against this null hypothesis, but the F-statistic should be interpreted together with its p-value.

# Prob (F-statistic)

Prob (F-statistic) is the p-value associated with the overall F-test.

If the p-value is below a chosen significance level, such as 0.05, there is statistical evidence that the regression model as a whole has explanatory power.

This does not mean that every individual predictor is significant. Individual predictors are assessed separately using their coefficient, t-statistic and p-value.

# Coefficients

The lower part of the OLS table provides information about each predictor.

<img width="718" height="135" alt="image" src="https://github.com/user-attachments/assets/c1097ae6-62b9-4559-9291-2094cad4d189" />

# const

const is the intercept of the regression model.

It represents the expected value of mpg when all predictors are equal to zero.

Because the numerical variables in this example have been standardised, the interpretation of zero for those variables corresponds to their mean.

However, the intercept may not always have a meaningful real-world interpretation, particularly when a combination of zero values is unrealistic.

# Coef

Coef represents the estimated regression coefficient.

For a numerical predictor, it represents the expected change in mpg associated with a one-unit increase in that predictor, while holding the other predictors constant.

Because the numerical variables were standardised, a one-unit increase in a standardised numerical variable corresponds approximately to an increase of one standard deviation in the original variable.

For example, a negative coefficient for weight would indicate that, after controlling for the other variables, higher vehicle weight is associated with lower predicted mpg.

# Std err

Std err is the standard error of the estimated coefficient.

It measures the uncertainty associated with the coefficient estimate.

A smaller standard error generally means that the coefficient has been estimated more precisely.

However, the standard error should not be interpreted on its own. It is used together with the coefficient to calculate the t-statistic and p-value.

# t

The t statistic tests whether an individual coefficient is significantly different from zero.

It is calculated approximately as:

$$t = coefficient / standard error$$

A large absolute t-value provides stronger evidence against the null hypothesis that the coefficient is zero.

Therefore, it is more appropriate to consider the absolute value of the t-statistic rather than simply whether it is numerically high or low.

# P>|t|

This is the p-value associated with the individual coefficient.

A p-value below a chosen significance level, commonly 0.05, provides statistical evidence that the coefficient is different from zero, conditional on the model assumptions.

Therefore, a variable with p < 0.05 is commonly described as statistically significant in this model.

# Making predictions

After fitting the OLS model, predictions can be generated for the test data:

    res = results.predict(sm.add_constant(X_test))

res contains the predicted mpg values.

These predictions can then be compared with the actual y_test values.

# Evaluating the model

I use Mean Absolute Error (MAE) and Mean Absolute Percentage Error (MAPE):

    from sklearn.metrics import (
        mean_absolute_error,
        mean_absolute_percentage_error
    )

    MAE = mean_absolute_error(y_test, res)
    MAPE = mean_absolute_percentage_error(y_test, res)

    print(f'MAE: {MAE}')
    print(f'MAPE: {MAPE}')
    Mean Absolute Error (MAE)

<img width="424" height="33" alt="image" src="https://github.com/user-attachments/assets/8b2edac0-fb88-4ef9-ad01-6d127675165c" />


MAE measures the average absolute difference between the observed and predicted values.

Lower MAE indicates smaller prediction errors.

Mean Absolute Percentage Error (MAPE)

MAPE expresses the average prediction error as a percentage of the actual value.

Lower MAPE indicates that the predictions are closer to the observed values in relative terms.

# Linear Regression using Scikit-learn

OLS regression can also be implemented using Scikit-learn:

from sklearn.linear_model import LinearRegression

    X1 = df_ml.drop(columns='mpg')
    y2 = df_ml['mpg']
    
    X_train, X_test, y_train, y_test = train_test_split(
        X1,
        y2,
        test_size=0.2,
        random_state=42
    )

    model = LinearRegression()
    
    model.fit(X_train, y_train)
    
    res = model.predict(X_test)

LinearRegression() also uses the ordinary least squares approach to estimate the coefficients.

The main difference is that statsmodels provides a detailed statistical summary, including p-values, confidence intervals and F-statistics, while Scikit-learn is mainly designed around machine learning workflows such as training, prediction and model evaluation.

This makes statsmodels particularly useful when the objective is statistical inference, while Scikit-learn is convenient when the objective is prediction and machine learning.

# Analysing residuals

A residual is the difference between the observed and predicted value:

    y_residual = y_test - res

The residual can therefore be expressed as:

$$Residual = Actual value − Predicted value$$

Residuals are important because they help us understand how the model's errors are distributed.

A residual plot can be created using:

    sns.scatterplot(x=y_test, y=y_residual)
    
    plt.axhline(
        y=0,
        color='r',
        linestyle='--'
    )
    
    plt.xlabel("Actual MPG")
    plt.ylabel("Residual")
    plt.title("Residuals vs Actual MPG")
    
    plt.show()

<img width="565" height="432" alt="image" src="https://github.com/user-attachments/assets/088c0745-5cbf-47b9-be15-c02b289b95cc" />


The horizontal line at zero represents perfect predictions.

A residual above zero means that the model underestimated the actual mpg.
A residual below zero means that the model overestimated the actual mpg.
Residuals close to zero indicate predictions close to the observed values.

Ideally, residuals should be distributed randomly around zero without a clear pattern.

Patterns in the residuals may indicate that the linear model is not capturing some structure in the data. For example, a curved pattern could suggest a non-linear relationship, while increasing residual spread could indicate heteroscedasticity.

Therefore, residual analysis is an important part of assessing whether a linear regression model is appropriate for the data.

