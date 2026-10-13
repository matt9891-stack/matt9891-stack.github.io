---
layout: post
title: "Cross Validation- Unit 4"
subtitle: "Module 6 – Machine Learning - Cross Validation"
date: 2026-08-17
categories: [Module 6 Machine Learning]
tags: [Python]
---
[Notebook Cross Validation](https://github.com/matt9891-stack/ML_Projects/blob/875ae1383312e2450fadfcda6e1e1974b95ba2d6/6%20Cross_Validation.ipynb)

# Cross-Validation

When building a machine learning model, it is important to know whether the model can generalise to unseen data.

A common approach is to divide the dataset into a training set and a test set, however, a single train-test split has limitations, for instance, the performance of the model depends on the particular observations that were selected for the training and test sets.

Cross-Validation reduces this dependency by repeatedly training and validating the model on different subsets of the data and it is therefore particularly useful when comparing models, selecting model parameters and estimating how well a model is likely to generalise.

# How does Cross-Validation work

K-Fold Cross-Validation, with 5-Fold Cross-Validation, divides the dataset into five approximately equal parts called folds.

The model is then trained five times, and, during each iteration, four folds are used for training, and one fold is used for validation.

The validation fold changes each time following the below schema.

Iteration 1
Training:   Fold 2 + 3 + 4 + 5
Validation: Fold 1

Iteration 2
Training:   Fold 1 + 3 + 4 + 5
Validation: Fold 2

Iteration 3
Training:   Fold 1 + 2 + 4 + 5
Validation: Fold 3

Iteration 4
Training:   Fold 1 + 2 + 3 + 5
Validation: Fold 4

Iteration 5
Training:   Fold 1 + 2 + 3 + 4
Validation: Fold 5

Each observation is therefore used for validation once and for training four times.

The five iteration performance scores are then averaged.

# Main uses of Cross-Validation

# 1. Model Selection

The first important use is comparing different models.

Linear Regression
Random Forest
Polynomial Regression

We can use the same Cross-Validation procedure for each model, and then assess their averaged performance metrics.

Linear Regression : RMSE
Random Forest : RMSE
Polynomial Regression: RMSE 

The scores provide a more consistent basis for comparing the models because each model has been evaluated across multiple validation folds.

The model with the lower RMSE has produced smaller prediction errors on average across the validation folds.

# Python Implementation - Model Selection

    from sklearn.model_selection import cross_val_score
    from sklearn.linear_model import LinearRegression
    from sklearn.preprocessing import PolynomialFeatures
    from sklearn.ensemble import RandomForestRegressor

    df = pd.read_csv('Advertising.csv') 
    
    X = df.drop('sales', axis=1) 
    y = df['sales']

- Create the candidate models

      models = {
          'Linear Regression': LinearRegression(),
  
      'Polynomial Regression': make_pipeline(
          PolynomialFeatures(degree=2),
          LinearRegression()
      ),
  
      'Random Forest': RandomForestRegressor(
          n_estimators=100,
          random_state=101
      )
      }

 - Cross-Validation

        cv_results = {}
        
        for name, model in models.items():
        
            scores = cross_val_score(
                model,
                X,
                y,
                cv=5,
                scoring='neg_mean_squared_error'
            )
        
            rmse = np.sqrt(-scores.mean())
        
            cv_results[name] = rmse
   
- Display results

      for model, rmse in cv_results.items():
          print(f'{model}: RMSE = {rmse:.3f}')
  
<img width="263" height="58" alt="image" src="https://github.com/user-attachments/assets/7cd300f8-e1bd-4fb8-8e76-f67a32c53462" />

# 2. Hyperparameters Tuning

A second important use is selecting the best hyperparameters before training the model.

For example, in Polynomial Regression, the polynomial degree is an hyperparameter:

degree = 1
degree = 2
degree = 3
degree = 4
...

We can use Cross-Validation to evaluate each degree.

    degrees = range(1, 11) 
    
    cv_scores = {} 
    
    
    for d in degrees: 
      
      pipeline = make_pipeline( PolynomialFeatures(degree=d), 
                               LinearRegression() ) 
    
      scores = cross_val_score( 
          pipeline, X, y, cv=5, scoring='neg_mean_squared_error' ) 
      
      rmse = np.sqrt(-scores.mean()) 
    
      cv_scores[d] = rmse

cv=5 means that we are using 5-Fold Cross-Validation.

The process is repeated for every polynomial degree from 1 to 10.

      best_degree = min( cv_scores, key=cv_scores.get ) 

      print(f"Best degree: {best_degree}")

<img width="119" height="29" alt="image" src="https://github.com/user-attachments/assets/cfa566ac-c2ed-4c0d-8491-83f87a137ab8" />

This means that, among the degrees tested, degree 4 produced the lowest average cross-validated RMSE.

# 3. Estimating Generalisation Performance

A third use of Cross-Validation is obtaining a more robust estimate of how a model performs on unseen data.

Instead of evaluating the model using only one validation split, we can evaluate it several times.

For example:

    scores = cross_val_score( models['Random Forest'],
                             X, y, cv=5,
                              scoring='neg_mean_squared_error' )

    for i, score in enumerate(scores):
    print(f'Fold {i + 1}: {score}')

<img width="197" height="84" alt="image" src="https://github.com/user-attachments/assets/88f05533-d7c6-46cf-b246-446070961585" />

This produces five scores:

Fold 1 → MSE
Fold 2 → MSE
Fold 3 → MSE
Fold 4 → MSE
Fold 5 → MSE

And calculate the average performance

    mean_mse = -scores.mean()

and convert it to RMSE:

    rmse = np.sqrt(mean_mse)
    
    print(f"Cross-validated RMSE: {rmse:.3f}")

<img width="236" height="29" alt="image" src="https://github.com/user-attachments/assets/575629c8-d687-4d21-9323-5b960dcecbdc" />

# Key Takeaway

Cross-Validation is not a machine learning model itself. It is an evaluation and model-selection technique.

The three main uses demonstrated here are:

- Model selection – comparing different algorithms.
- Hyperparameter tuning – finding suitable model settings, such as the polynomial degree.
- Performance estimation – obtaining a more robust estimate of model performance across different subsets of the data

The key advantage is that the decision is not based on one particular train-validation split, but on performance across multiple folds.



