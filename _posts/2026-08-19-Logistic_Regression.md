---
layout: post
title: "Exploratory Data Analysis Python - Unit 4"
subtitle: "Module 6 – Machine Learning - Logistic Regression"
date: 2026-08-19
categories: [Module 6 Machine Learning]
tags: [EDA, Python]
---

# Logistic Regression

Logistic Regression is a classification algorithm rather than a regression algorithm.

Linear Regression predicts a continuous numerical value, while Logistic Regression predicts the probability that an observation belongs to a particular class.

For binary classification, the model predicts the probability of belonging to one of two classes.

For example:

0 → Not purchased
1 → Purchased

The Logistic Regression model uses the sigmoid function to convert the model's output into a probability between 0 and 1.

The predicted probability can then be converted into a class.

For example, for a Probability = 0.82 there will be a Predicted class = 1

For a binary classification problem, the sigmoid function is:

$$
\sigma(z)=\frac{1}{1+e^{-z}}
$$

# Multiclass Logistic Regression

Logistic Regression can also be used when there are more than two possible classes.

For example, the Iris dataset contains three species:

setosa
versicolor
virginica

Therefore, this is a multiclass classification problem.

Instead of predicting a continuous value, the model estimates the probability of each class.

Loading the Dataset

We use the Iris dataset for this example.

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import seaborn as sns
    
    from google.colab import files
    
    files.upload()
    
    df = pd.read_csv('iris.csv')

We can inspect the structure of the dataset:

    df.shape
    df.info()

<img width="352" height="195" alt="image" src="https://github.com/user-attachments/assets/727f9b1b-f004-4fb7-85eb-2fa6885d955d" />

I can also check the possible target classes:

    df['species'].unique()

<img width="474" height="28" alt="image" src="https://github.com/user-attachments/assets/0afaf5ea-5c79-4b16-9fee-54dfc4f6022b" />

The target contains three possible outcomes:

setosa
versicolor
virginica

Therefore, this is a multiclass classification problem.

# Defining Features and Target

As with the regression models, We first separate the predictors from the target.

    X = df.drop('species', axis=1)
    
    y = df['species']

X contains the flower measurements, while y contains the species to be predicted.

# Train-Test Split

We then divide the data into training and test sets.

    from sklearn.model_selection import train_test_split

    X_train, X_test, y_train, y_test = train_test_split(
        X,
        y,
        test_size=0.30,
        random_state=101,
        stratify=y
    )

We use stratify=y so that the class proportions are maintained approximately in both the training and test sets.

# Feature Scaling

Logistic Regression uses coefficients and regularisation, so feature scaling is useful, particularly when the predictors have different scales.

    from sklearn.preprocessing import StandardScaler

    scaler = StandardScaler()

    X_train_scaled = scaler.fit_transform(X_train)
    
    X_test_scaled = scaler.transform(X_test)

The scaler is fitted only on the training data, while the test data is then transformed using the same scaling parameters.

This prevents information from the test set from being used during preprocessing.

# Hyperparameter Tuning

Before fitting the final Logistic Regression model, we can use GridSearchCV to test different combinations of hyperparameters.

This is useful because the performance of Logistic Regression can depend on settings such as:

- C
- penalty
- solver

The objective is to identify a combination that performs well using Cross-Validation.

# The C Parameter

C controls the strength of regularisation, where:

Small C:
Stronger regularisation and more restriction on coefficients

Large C: Weaker regularisation and Less restriction on coefficients

A very small C can make the model too simple, while a very large C allows the model to fit the training data more closely.

# The penalty Parameter

The penalty determines the type of regularisation.

L1: Lasso-style regularisation

It can force some coefficients to zero and therefore perform feature selection.

L2: Ridge-style regularisation

It shrinks coefficients but normally does not force them exactly to zero.

# The solver Parameter

The solver is the optimisation algorithm used to find the model coefficients.

Different solvers support different regularisation options.

For this example, we can use:

liblinear
saga

liblinear works well for relatively small datasets, while saga supports a wider range of configurations and is suitable for multiclass problems.

The important point is that the chosen solver must support the selected penalty.

# GridSearchCV

We can now create the parameter grid to find the best parameter for the model.

    from sklearn.model_selection import GridSearchCV
    from sklearn.linear_model import LogisticRegression

    param_grid = {
        'C': [0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000],
        'penalty': ['l1', 'l2'],
        'solver': ['liblinear', 'saga']
    }

GridSearchCV will test the combinations of these parameters.

# Creating the Logistic Regression Model

    logistic_model = LogisticRegression(
        max_iter=5000
    )

I then create the GridSearchCV object:

    grid = GridSearchCV(
        logistic_model,
        param_grid,
        cv=5,
        scoring='accuracy',
        n_jobs=-1
    )

Here cv=5 means that I use 5-Fold Cross-Validation for each combination of hyperparameters.

scoring='accuracy' means that the parameter combinations are compared using classification accuracy.

n_jobs=-1 allows Scikit-learn to use all available CPU cores.

    grid.fit(X_train_scaled, y_train)

    print(grid.best_params_)

<img width="333" height="32" alt="image" src="https://github.com/user-attachments/assets/5e662af1-7490-4ecf-982d-e1426db9cade" />

# Using the Best Model

One advantage of GridSearchCV is that it automatically stores the best model.

I can access it using:

    best_model = grid.best_estimator_

This is preferable to manually creating another Logistic Regression model using the parameters printed by best_params_.

    best_model = grid.best_estimator_

<img width="527" height="167" alt="image" src="https://github.com/user-attachments/assets/ba7c2beb-a9bc-4c98-9e83-b6f1efdc93a1" />

# Evaluating the Model

For classification, accuracy is one possible evaluation metric.

    accuracy = best_model.score(
        X_test_scaled,
        y_test
    )
    
print(f'{accuracy:.3f}')

<img width="150" height="25" alt="image" src="https://github.com/user-attachments/assets/899164ad-7269-4b93-a2d6-caa289afb170" />

# Classification Report

Accuracy alone does not provide information about the performance for each individual class.

I can therefore use a classification report.

    from sklearn.metrics import classification_report

    print(
        classification_report(
            y_test,
            prediction
        )
    )

<img width="457" height="158" alt="image" src="https://github.com/user-attachments/assets/e98f65c4-8748-4024-b770-bbc4d935e84a" />

### Precision

Of the observations predicted as a particular class, how many actually belonged to that class?

### Recall

Of the observations that actually belonged to a particular class, how many did the model identify correctly?

### F1-score

The harmonic mean of precision and recall.

### Support

The number of observations belonging to each class in the test set.

# Confusion Matrix

A confusion matrix provides a visual way to understand the classification errors.

from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay

    cm = confusion_matrix(
        y_test,
        prediction
    )

    print(cm)

<img width="187" height="61" alt="image" src="https://github.com/user-attachments/assets/e757a049-1351-4631-b35b-fabc7f1c0033" />

We can also display the matrix

      disp = ConfusionMatrixDisplay( confusion_matrix=cm, 
                              display_labels=best_model.classes_ ) 
                              
      disp.plot() 
      
      plt.show()

<img width="513" height="389" alt="image" src="https://github.com/user-attachments/assets/4da700f1-77b5-43cc-8bb0-ea1437871f3e" />

For a three-class problem, the matrix contains three rows and three columns.

The diagonal represents correctly classified observations.

The off-diagonal cells represent classification errors.

# Predicting Probabilities

Logistic Regression can also provide the predicted probability for each class.

    probabilities = best_model.predict_proba(
        X_test_scaled
    )

# Key Takeaway

Logistic Regression is a classification algorithm that can be used for both binary and multiclass classification.

In this example, the Iris dataset contains three possible classes, so we use multiclass Logistic Regression.

Before fitting the final model, we use GridSearchCV to test different combinations of:

C – controls the strength of regularisation;
penalty – determines the type of regularisation;
solver – determines the optimisation algorithm.

GridSearchCV evaluates each combination using 5-Fold Cross-Validation and selects the combination with the highest mean accuracy.

The final model is then evaluated on the separate test set using accuracy, classification metrics and a confusion matrix.
      
