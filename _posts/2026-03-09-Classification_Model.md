---
layout: post
title: "Unit 6 Data Logistic Regression Python"
subtitle: "Logistic Regression model implementation"
date: 2026-03-09
categories: [Module 4 Visualising Data]
tags: [Python,Matplotlib,seaborn,sklearn]
---

[NOTEBOOK](https://github.com/matt9891-stack/Classification_model/blob/main/Classification.ipynb)

# Logistic Regression

This analysis aims to develop and evaluate a machine learning model capable of classifying breast tumours as malignant or benign using the Breast Cancer dataset available in the Scikit-learn library. Accurate early detection of malignant tumours is critical in medical diagnostics, as it enables timely treatment and significantly improves patient outcomes.

## 1) Load the dataset

The Breast Cancer dataset was loaded and converted into a pandas DataFrame. Its structure was examined to determine the number of rows and columns, the presence of null values, and the data types of each column.

    import pandas as pd
    import numpy as np
    from sklearn.datasets import load_breast_cancer
    
    # Load dataset
    df = load_breast_cancer()
    df1 = pd.DataFrame(data=df.data, columns=df.feature_names)

    mean radius	mean texture	mean perimeter	mean area	mean smoothness	mean compactness	mean concavity	mean concave points	mean symmetry	mean fractal dimension	...	worst radius	worst texture	worst perimeter	worst area	worst smoothness	worst compactness	worst concavity	worst concave points	worst symmetry	worst fractal dimension
    0	17.99	10.38	122.80	1001.0	0.11840	0.27760	0.3001	0.14710	0.2419	0.07871	...	25.38	17.33	184.60	2019.0	0.1622	0.6656	0.7119	0.2654	0.4601	0.11890
    1	20.57	17.77	132.90	1326.0	0.08474	0.07864	0.0869	0.07017	0.1812	0.05667	...	24.99	23.41	158.80	1956.0	0.1238	0.1866	0.2416	0.1860	0.2750	0.08902
    2	19.69	21.25	130.00	1203.0	0.10960	0.15990	0.1974	0.12790	0.2069	0.05999	...	23.57	25.53	152.50	1709.0	0.1444	0.4245	0.4504	0.2430	0.3613	0.08758
    3	11.42	20.38	77.58	386.1	0.14250	0.28390	0.2414	0.10520	0.2597	0.09744	...	14.91	26.50	98.87	567.7	0.2098	0.8663	0.6869	0.2575	0.6638	0.17300
    4	20.29	14.34	135.10	1297.0	0.10030	0.13280	0.1980	0.10430	0.1809	0.05883	...	22.54	16.67	152.20	1575.0	0.1374	0.2050	0.4000	0.1625	0.2364	0.07678
    5 rows × 30 columns
        
    # Add target variable
    df1['target'] = df.target
    
    # Check dataset structure
    print(f'The dataset has {df1.shape[0]} rows and {df1.shape[1]} columns')
    
    # Check for null values
    for col in df1.columns:
        null = df1[col].isnull().sum() / len(df1) * 100
        print(f'The column {col} has {null:.2f}% null values')
    
    # Check data types
    for col in df1.columns:
        print(f'The column {col} is a {df1[col].dtype}')

        Shape
       the dataset has 569 rows amd 30 columns
       
      Null values
      The column mean radius has 0.0 % of null values
      The column mean texture has 0.0 % of null values
      The column mean perimeter has 0.0 % of null values
      The column mean area has 0.0 % of null values
      The column mean smoothness has 0.0 % of null values
      The column mean compactness has 0.0 % of null values
      The column mean concavity has 0.0 % of null values
      The column mean concave points has 0.0 % of null values
      The column mean symmetry has 0.0 % of null values
      The column mean fractal dimension has 0.0 % of null values
      The column radius error has 0.0 % of null values
      The column texture error has 0.0 % of null values
      The column perimeter error has 0.0 % of null values
      The column area error has 0.0 % of null values
      The column smoothness error has 0.0 % of null values
      The column compactness error has 0.0 % of null values
      The column concavity error has 0.0 % of null values
      The column concave points error has 0.0 % of null values
      The column symmetry error has 0.0 % of null values
      The column fractal dimension error has 0.0 % of null values
      The column worst radius has 0.0 % of null values
      ...
      the column worst concavity is a float64
      the column worst concave points is a float64
      the column worst symmetry is a float64
      the column worst fractal dimension is a float64

The dataset contains 569 rows and 30 columns, all numerical, with no missing values. This indicates that all features can be used directly for modelling. The target variable indicates whether a tumour is malignant (0) or benign (1).

# 2) Explore correlations

Correlations between features and the target variable were calculated to identify features with high predictive value.

    plt.figure(figsize = (15,10))
    sns.heatmap(df1.select_dtypes(include=['float','int']).corr(), annot=True,linewidth = '0.2',linecolor = 'w');

  <img width="1264" height="970" alt="image" src="https://github.com/user-attachments/assets/aa64741b-a145-4a96-84b9-ddcd18ad296c" />

    df1.select_dtypes(include=['float','int']).corr()['target']

    mean radius               -0.730029
    mean texture              -0.415185
    mean perimeter            -0.742636
    mean area                 -0.708984
    mean smoothness           -0.358560
    mean compactness          -0.596534
    mean concavity            -0.696360
    mean concave points       -0.776614
    mean symmetry             -0.330499
    mean fractal dimension     0.012838
    radius error              -0.567134
    texture error              0.008303
    perimeter error           -0.556141
    area error                -0.548236
    smoothness error           0.067016
    compactness error         -0.292999
    concavity error           -0.253730
    concave points error      -0.408042
    symmetry error             0.006522
    fractal dimension error   -0.077972
    worst radius              -0.776454
    worst texture             -0.456903
    worst perimeter           -0.782914
    worst area                -0.733825
    worst smoothness          -0.421465
    ...
    worst concave points      -0.793566
    worst symmetry            -0.416294
    worst fractal dimension   -0.323872
    target                     1.000000

  Features such as “worst concave points”, “worst perimeter”, and “mean concave points” show strong negative correlations with the target. This suggests that higher values of these features are associated with malignant tumours.

# 3) Define features and target

The feature matrix X was defined as all numerical features, and y was set as the target variable. The dataset was split into a training set (70%) and a test set (30%), ensuring that the model is trained on one portion of the data and evaluated on unseen data.

    from sklearn.model_selection import train_test_split
    
    X = df1.drop(columns='target')
    y = df1['target']
    
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.3, random_state=42
    )

# 4) Train a logistic regression model

A logistic regression model was trained, with a maximum of 5000 iterations to ensure convergence.

    from sklearn.linear_model import LogisticRegression
    
    model = LogisticRegression(max_iter=5000)
    model.fit(X_train, y_train)

Predictions on the test set were obtained, both as class labels and as probabilities for the benign class.

    res = model.predict(X_test)
    res_proba = model.predict_proba(X_test)[:, 1]

# 5) Evaluate initial predictions

The classification performance was evaluated using the classification report, which provides precision, recall, F1-score, and support for each class.

    from sklearn.metrics import classification_report
    
    print(classification_report(res, y_test))

                    precision    recall  f1-score   support

               0       0.97      0.97      0.97        63
               1       0.98      0.98      0.98       108

        accuracy                           0.98       171
       macro avg       0.97      0.97      0.97       171
    weighted avg       0.98      0.98      0.98       171

The model achieved 98% accuracy, with very high precision and recall for both classes. This indicates that almost all malignant and benign tumours were classified correctly.

# 6) Calculate the optimal threshold (Youden Index)

To find the threshold that best balances sensitivity and specificity, the ROC curve was calculated, and the Youden Index was used.

    from sklearn.metrics import roc_curve
    
    # ROC curve
    fpr, tpr, thresholds = roc_curve(y_test, res_proba)
    
    # Youden Index
    J = tpr - fpr
    best_idx = np.argmax(J)
    best_threshold = thresholds[best_idx]
    print("Best threshold (Youden Index):", best_threshold)
    
    # Apply threshold
    y_pred = (res_proba >= best_threshold).astype(int)

Here, TPR = TP / (TP + FN) and FPR = FP / (FP + TN), where the divisor is the total number of actual positives and actual negatives, respectively. The threshold corresponding to the maximum Youden Index maximises the difference between TPR and FPR, providing the optimal balance.

# 7) Confusion matrix using the optimal threshold

The confusion matrix was generated and displayed with readable labels.

    from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay
    import matplotlib.pyplot as plt
    
    cm = confusion_matrix(y_test, y_pred)
    disp = ConfusionMatrixDisplay(cm, display_labels=['malignant', 'benign'])
    disp.plot()
    plt.show()

  <img width="568" height="432" alt="image" src="https://github.com/user-attachments/assets/bec5b749-3519-45ee-932c-50e229882da8" />

  The matrix shows that almost all tumours were classified correctly, confirming the effectiveness of the chosen threshold.

 # 8) Plot the ROC curve with the optimal point

The ROC curve provides a visual representation of the model’s discriminative ability. The point corresponding to the maximum Youden Index was highlighted.

    roc_disp = RocCurveDisplay(fpr=fpr, tpr=tpr)
    plt.plot(fpr, tpr, label="ROC Curve")
    plt.scatter(fpr[best_indx], tpr[best_indx], color='red',
                label=f'Best threshold = {best_threshold:.2f}')
    plt.xlabel('False Positive Rate')
    plt.ylabel('True Positive Rate')
    plt.show()


<img width="567" height="432" alt="image" src="https://github.com/user-attachments/assets/587285db-4cb5-4cb9-b284-0451fd55c0f3" />

The point near the top-left corner represents the optimal balance between maximising true positives and minimising false positives.

# 9) Interpretation of results

The model demonstrates excellent performance in classifying malignant and benign tumours. Using the Youden Index, an optimal threshold was selected that balances sensitivity and specificity. This threshold differs slightly from the default 0.5 and ensures that the number of false negatives and false positives is minimised relative to the total number of cases. The confusion matrix confirms that almost all cases are classified correctly. The ROC curve illustrates the model’s discriminative ability, with the optimal threshold clearly marked near the top-left corner, indicating a very effective classifier.

Through this step-by-step approach, including dataset exploration, logistic regression modelling, threshold optimisation, and visualisation, the model’s performance is objectively demonstrated, providing a clear and reproducible evaluation.
