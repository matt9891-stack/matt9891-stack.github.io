---
layout: post
title: "Exploratory Data Analysis Python - Unit 3"
subtitle: "Module 6 – Machine Learning - Polynomial Regression"
date: 2026-08-15
categories: [Module 6 Machine Learning]
tags: [EDA, Python]
---

# Polynomial Regression

In a Linear Regression model, we assume that the relationship between the independent variables and the target variable can be represented by a straight line.

However, real-world relationships are not always linear. For example, when plotting the residuals of a Linear Regression model, we may observe a systematic curved pattern rather than a random distribution around zero.

This can indicate that the model is not capturing an important pattern in the data.

Polynomial Regression can be used to model these types of non-linear relationships.

The main idea is to transform the original features into polynomial features and then apply Linear Regression to the transformed data.

For example, with one feature (X), a second-degree polynomial creates:

$$
X,\quad X^2
$$

A third-degree polynomial creates:

$$
X,\quad X^2,\quad X^3
$$

The model can therefore learn a curved relationship while still using Linear Regression as the underlying algorithm.

For example, a second-degree model can be written as:

$$
y = \beta_0 + \beta_1X + \beta_2X^2
$$

Although the model is called Polynomial Regression, the final model is still fitted using LinearRegression() in Scikit-learn.

# Python Workflow 

From Linear Regression to Polynomial Regression the general workflow is:

- Split the data into training and testing sets.

- Create polynomial features from the training data.

- Transform the test data using the same polynomial transformation.

- Fit a Linear Regression model using the transformed training data.

- Make predictions using the transformed test data.

- Evaluate the model using metrics such as MAE and RMSE.

- Compare different polynomial degrees to identify an appropriate level of complexity.

The important point is that the polynomial transformation is performed before fitting the Linear Regression model.

# Project Development

## Importing the Libraries
    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    import seaborn as sns
    
    from sklearn.linear_model import LinearRegression
    from sklearn.preprocessing import PolynomialFeatures
    from sklearn.model_selection import train_test_split
    from sklearn.metrics import mean_absolute_error, mean_squared_error

I use PolynomialFeatures to create the polynomial variables and LinearRegression to fit the model.

# Loading the Dataset

    df = pd.read_csv('Advertising.csv')
    
    df.head()
    
<img width="255" height="362" alt="image" src="https://github.com/user-attachments/assets/a8a02ddb-194b-4129-b4b2-c1a4ba2c485d" />

The dataset contains advertising expenditure for:

TV
Radio
Newspaper
and the target variable is:

Sales

# Defining the Features and Target

As with Linear Regression, I first separate the independent variables from the target variable.

    X = df.drop('sales', axis=1)
    y = df['sales']

X contains the predictors, while y contains the target variable that the model will try to predict.

# Train-Test Split

I then divide the data into training and testing sets.

    X_train, X_test, y_train, y_test = train_test_split(
        X,
        y,
        test_size=0.33,
        random_state=101
    )

The training data will be used to build the model, while the test data will be used to evaluate its performance on unseen observations.

# Creating Polynomial Features

This is the main additional step compared with standard Linear Regression.

    polynomial_converter = PolynomialFeatures(
        degree=2,
        include_bias=False
    )

The original dataset has three features:

TV
Radio
Newspaper

With degree 2, PolynomialFeatures creates additional terms such as:

TV²
Radio²
Newspaper²
TV × Radio
TV × Newspaper
Radio × Newspaper

Therefore, the model receives more information about possible curved and interaction relationships between the variables.

# Fitting and Transforming the Training Data

    poly_X_train = polynomial_converter.fit_transform(X_train)

Here, fit_transform() does two things:

It learns the transformation from the training data.
It applies that transformation to the training data.

The result is a new dataset containing the polynomial features.

We do not use fit_transform() on the test data because the test data represents unseen data.

Instead we used

    poly_X_test = polynomial_converter.transform(X_test)

The transformation learned from the training data is therefore applied to the test data without fitting it again.

This helps prevent data leakage.

# Fitting the Linear Regression Model

Once the polynomial features have been created, the remaining steps are similar to standard Linear Regression.

    model = LinearRegression()
    
    model.fit(poly_X_train, y_train)

The important distinction is that the model is no longer fitted using the original X_train.

Instead, it is fitted using:

poly_X_train

which contains the transformed polynomial features.

<img width="189" height="56" alt="image" src="https://github.com/user-attachments/assets/f9cc32ba-2a79-45a6-8573-2f1d03cf96da" />

# Making Predictions

I can now make predictions using the transformed test data.

    prediction = model.predict(poly_X_test)

    df_p=pd.DataFrame(X_test)
    df_p['prediction']=prediction
    df_p

<img width="290" height="360" alt="image" src="https://github.com/user-attachments/assets/fd849d32-2111-4b91-8ef7-1ee230ed2976" />

The model has never seen these test observations during training

# Evaluating the Model

We evaluate the predictions using MAE and RMSE.

    MAE = mean_absolute_error(y_test, prediction)
    
    MSE = mean_squared_error(y_test, prediction)
    
    RMSE = np.sqrt(MSE)

    print(f'MAe: {MAE}')
    print(f'RMSE: {RMSE}')

<img width="406" height="37" alt="image" src="https://github.com/user-attachments/assets/874bba05-57da-430c-a599-0585ac566612" />
    
# MAE

MAE represents the average absolute difference between the actual and predicted values.

# RMSE

RMSE also measures prediction error, but gives greater weight to larger errors because the errors are squared before taking the square root.

For both metrics, lower values indicate smaller prediction errors.

# Checking the Residuals

Residuals are the differences between the actual and predicted values.

    residuals = y_test - prediction

Visualise the residual using:

    plt.scatter(y_test, residuals)
    
    plt.axhline(
        y=0,
        color='red',
        linestyle='--'
    )
    
    plt.xlabel('Actual Sales')
    plt.ylabel('Residuals')
    plt.title('Residual Plot')
    plt.show()

    <img width="559" height="413" alt="image" src="https://github.com/user-attachments/assets/618948c0-4a1b-4a4c-8c9d-85a4adaf2ccb" />

Ideally, the residuals should be distributed relatively randomly around zero.

If a clear systematic pattern remains, such as a curve, this may indicate that the model is still failing to capture some structure in the data.

Polynomial Regression can help to address this when the underlying relationship is curved.

# Predicting Completely New Data

Once the model has been trained, it can also be used with completely new observations.

For example:

    df_new = pd.DataFrame({
        'TV': [100, 150, 200],
        'radio': [20, 30, 40],
        'newspaper': [10, 20, 30]
    })

However, we cannot pass these original variables directly to the model.

They must first go through the same polynomial transformation used during training.

    new_X2 = polynomial_converter.transform(df_new)

We can then make predictions:

    new_predictions = model.predict(new_X2)
    
    new_predictions

The workflow is therefore:

New data
   ↓
Polynomial transformation
   ↓
Linear Regression model
   ↓
Prediction

This same transformation step must be applied to future data before making predictions.

# How to chose the Polynomial Degree

One of the most important decisions is choosing the polynomial degree.

A higher degree gives the model greater flexibility, but excessive complexity can lead to overfitting.

For this reason, I can test several polynomial degrees and compare their performance.

    MAE_errors = []
    RMSE_errors = []

    for d in range(1, 10):

    poly_converter = PolynomialFeatures(
        degree=d,
        include_bias=False
    )

    poly_X_train = poly_converter.fit_transform(X_train)
    poly_X_test = poly_converter.transform(X_test)

    model = LinearRegression()

    model.fit(poly_X_train, y_train)

    pred_test = model.predict(poly_X_test)

    MAE_errors.append(
        mean_absolute_error(y_test, pred_test)
    )

    RMSE_errors.append(
        np.sqrt(mean_squared_error(y_test, pred_test))
    )

WE can then compare the errors for the different polynomial degrees.

    plt.plot(
        range(1, 10),
        MAE_errors,
        label='MAE'
    )
    
    plt.plot(
        range(1, 10),
        RMSE_errors,
        label='RMSE'
    )
    
    plt.xlabel('Polynomial Degree')
    plt.ylabel('Error')
    plt.legend()
    plt.show()

<img width="556" height="413" alt="image" src="https://github.com/user-attachments/assets/38281666-e4c0-4f20-ae19-a0b5d7f45aa9" />


The degree with the lowest validation/test error provides an indication of which level of complexity performs better on the selected data.

In this example, degree 4 produced the lowest error among the degrees tested.

However, the lowest error on a single train-test split should not automatically be treated as the universally correct degree. 

# Key Takeaway

Polynomial Regression does not replace Linear Regression. Instead, it extends Linear Regression by transforming the input variables into polynomial features.

The main advantage is that the model can capture curved relationships and interactions between variables that a simple linear model may not capture.

The main risk is that increasing the polynomial degree also increases model complexity. If the degree becomes too high, the model may fit the training data too closely and perform poorly on unseen data.

Therefore, the objective is not simply to use the highest possible degree, but to find a suitable balance between model flexibility and generalisation.
