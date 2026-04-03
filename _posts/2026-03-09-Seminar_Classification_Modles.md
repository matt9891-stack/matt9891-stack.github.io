---
layout: post
title: "Unit 6 Classification Logistic Regression Random Forest"
subtitle: "Implementation of Classification Models for predicting the burnout levels in Students."
date: 2026-03-09
categories: [Module 4 Visualising Data]
tags: [Python,Matplotlib,seaborn,sklearn,Plotly]
---

[NOTEBOOK](https://github.com/matt9891-stack/Seminar_Classification_Models/blob/main/Seminar_Classification_Methods.ipynb)

# Data Import and Exploration

The first step involved importing the dataset from Kaggle using the kagglehub library and loading it into a Pandas DataFrame.

    import pandas as pd
    import numpy as np
    import seaborn as sns
    import matplotlib.pyplot as plt
    
    import os
    
    import kagglehub 
    
    path = kagglehub.dataset_download("sehaj1104/student-mental-health-and-burnout-dataset")
    
    print("Path to dataset files:", path)
    
    from google.colab import files
    
    files = os.listdir(path) 
    print(files)
    
    file_path = path + "/student_mental_health_burnout.csv"   
    
    df.head()

  <img width="1720" height="199" alt="image" src="https://github.com/user-attachments/assets/f995d944-6b25-40d9-aa54-95861f7a9afd" />

I explored the structure of the dataset by checking its shape, null values, and data types. The dataset contains 150,000 rows and 13 columns, with no significant missing values, making it suitable for further analysis. 
The columns include both numeric variables, such as daily study hours, sleep hours, and CGPA, and categorical variables, such as gender, course, and self-reported burnout level.

    print('Shape of Dataset')
    print('')
    print(f'the dataset has {df.shape[0]} rows and {df.shape[1]} columns')
    print('')
    print('Null Values')
    print('')
    for col in df.columns:
      null = df[col].isnull().sum()/len(df) * 100
      print(f'The coulmn {col} has {null} % of null values')
    print('')
    print('Dtypes')
    print('')
    for col in df.columns:
      t = df[col].dtype
      print(f'the coulumn {col} is a {t}')
    print('')
    print('Distribution')
    print()
    numerics = df.select_dtypes(include = ['float','int'])
    print(numerics.describe())

    Shape of Dataset

    the dataset has 150000 rows and 20 columns
    
    Null Values
    
    The coulmn student_id has 0.0 % of null values
    The coulmn age has 0.0 % of null values
    The coulmn gender has 0.0 % of null values
    The coulmn course has 0.0 % of null values
    The coulmn year has 0.0 % of null values
    The coulmn daily_study_hours has 0.0 % of null values
    The coulmn daily_sleep_hours has 0.0 % of null values
    The coulmn screen_time_hours has 0.0 % of null values
    The coulmn stress_level has 0.0 % of null values
    The coulmn anxiety_score has 0.0 % of null values
    The coulmn depression_score has 0.0 % of null values
    The coulmn academic_pressure_score has 0.0 % of null values
    The coulmn financial_stress_score has 0.0 % of null values
    The coulmn social_support_score has 0.0 % of null values
    The coulmn physical_activity_hours has 0.0 % of null values
    The coulmn sleep_quality has 0.0 % of null values
    The coulmn attendance_percentage has 0.0 % of null values
    The coulmn cgpa has 0.0 % of null values
    The coulmn internet_quality has 0.0 % of null values
    The coulmn burnout_level has 0.0 % of null values
    
    Dtypes
    
    the coulumn student_id is a int64
    the coulumn age is a int64
    the coulumn gender is a object
    the coulumn course is a object
    the coulumn year is a object
    the coulumn daily_study_hours is a float64
    the coulumn daily_sleep_hours is a float64
    the coulumn screen_time_hours is a float64
    the coulumn stress_level is a object
    the coulumn anxiety_score is a int64
    the coulumn depression_score is a int64
    the coulumn academic_pressure_score is a int64
    the coulumn financial_stress_score is a int64
    the coulumn social_support_score is a int64
    the coulumn physical_activity_hours is a float64
    the coulumn sleep_quality is a object
    the coulumn attendance_percentage is a float64
    the coulumn cgpa is a float64
    the coulumn internet_quality is a object
    the coulumn burnout_level is a object
    
    Distribution
    
              student_id            age  daily_study_hours  daily_sleep_hours  \
    count  150000.000000  150000.000000      150000.000000      150000.000000   
    mean   175000.500000      21.000380           5.507869           6.499361   
    std     43301.414527       2.581216           2.595592           1.443859   
    min    100001.000000      17.000000           1.000000           4.000000   
    25%    137500.750000      19.000000           3.300000           5.200000   
    50%    175000.500000      21.000000           5.500000           6.500000   
    75%    212500.250000      23.000000           7.700000           7.700000   
    max    250000.000000      25.000000          10.000000           9.000000   
    
           screen_time_hours  anxiety_score  depression_score  \
    count      150000.000000  150000.000000     150000.000000   
    mean            6.502819       5.493907          5.497360   
    std             3.178948       2.872607          2.869022   
    min             1.000000       1.000000          1.000000   
    25%             3.700000       3.000000          3.000000   
    50%             6.500000       5.000000          5.000000   
    75%             9.300000       8.000000          8.000000   
    max            12.000000      10.000000         10.000000   
    
           academic_pressure_score  financial_stress_score  social_support_score  \
    count            150000.000000           150000.000000         150000.000000   
    mean                  5.507427                5.496027              5.516060   
    std                   2.875524                2.864698              2.870493   
    min                   1.000000                1.000000              1.000000   
    25%                   3.000000                3.000000              3.000000   
    50%                   6.000000                6.000000              6.000000   
    75%                   8.000000                8.000000              8.000000   
    max                  10.000000               10.000000             10.000000   
    
           physical_activity_hours  attendance_percentage           cgpa  
    count            150000.000000          150000.000000  150000.000000  
    mean                  0.998115              75.009528       6.997389  
    std                   0.578866              14.409510       1.732180  
    min                   0.000000              50.000000       4.000000  
    25%                   0.500000              62.500000       5.500000  
    50%                   1.000000              75.000000       6.990000  
    75%                   1.500000              87.500000       8.500000  
    max                   2.000000             100.000000      10.000000  

# Data Visualisation

To better understand the distributions, I created histograms and boxplots for all numeric features. The visualisations confirmed the absence of significant outliers, with most variables showing symmetric distributions around the median. 
For example, age ranged from 17 to 25, daily study and sleep hours fell within realistic human limits, and psychological measures were contained within the expected 1–10 range.

<img width="1790" height="1989" alt="image" src="https://github.com/user-attachments/assets/aa698573-0959-47f0-9529-761f9dd7ddda" />

Boxplots reinforced that extreme values, such as zero hours of physical activity or ten hours of study, were valid observations rather than anomalies.

<img width="1790" height="1989" alt="image" src="https://github.com/user-attachments/assets/061a00de-39f5-4014-9227-c7c1a31bb271" />

# Categorical Analysis and Crosstabs

Next, I analysed categorical variables using countplots and crosstabs to explore how burnout levels distribute across different demographic, academic, and lifestyle factors. 

<img width="1790" height="1189" alt="image" src="https://github.com/user-attachments/assets/1824ddc4-7cc9-44fe-aca0-d3a43d767fdd" />

The crosstabs revealed that burnout levels are remarkably balanced across gender, course, and year of study.

    burnout_level   High    Low  Medium
    gender                             
    Female         16708  16575   16705
    Male           16470  16809   16685
    Other          16588  16881   16579
     
    burnout_level  High   Low  Medium
    course                           
    BBA            8309  8346    8448
    BCA            8322  8338    8313
    BSc            8156  8448    8290
    BTech          8331  8287    8231
    MBA            8365  8418    8448
    MCA            8283  8428    8239
     
    burnout_level   High    Low  Medium
    year                               
    1st            12511  12552   12617
    2nd            12346  12536   12394
    3rd            12419  12507   12496
    4th            12490  12670   12462
     
    burnout_level   High    Low  Medium
    stress_level                       
    High           16768  16868   16659
    Low            16357  16711   16547
    Medium         16641  16686   16763
     
    burnout_level   High    Low  Medium
    sleep_quality                      
    Average        16497  16764   16715
    Good           16571  16717   16855
    Poor           16698  16784   16399
     
    burnout_level      High    Low  Medium
    internet_quality                      
    Average           16682  16790   16666
    Good              16631  16749   16493
    Poor              16453  16726   16810
     
    burnout_level   High    Low  Medium
    burnout_level                      
    High           49766      0       0
    Low                0  50265       0
    Medium             0      0   49969

# Correlation Analysis

I computed the correlation matrix for numeric features to assess relationships between variables. 
Most correlation values were close to zero, indicating weak linear relationships between features. 

<img width="929" height="829" alt="image" src="https://github.com/user-attachments/assets/cde2504d-d447-43d5-9fec-b7241eced102" />

Mental health scores, academic indicators, and lifestyle variables were largely independent, suggesting that multicollinearity would not pose an issue for regression or tree-based models. 
However, this also implied that no single variable strongly explains variation in burnout levels, posing a challenge for predictive modelling.

# Logistic Regression Modelling

For the first predictive approach, I implemented a multinomial Logistic Regression. Categorical features were one-hot encoded, and numeric features were standardised to address differences in scale. 
Hyperparameters were optimised using GridSearchCV. The resulting model achieved an overall accuracy of approximately 33%, with precision, recall, and F1-scores around 0.33 for each burnout class. 

<img width="562" height="432" alt="image" src="https://github.com/user-attachments/assets/39362f9a-12aa-4c21-b6da-1b5d36c32a06" />

                  precision    recall  f1-score   support
    
            High       0.33      0.25      0.28     16422
             Low       0.33      0.38      0.35     16675
          Medium       0.33      0.37      0.35     16403
    
        accuracy                           0.33     49500
       macro avg       0.33      0.33      0.33     49500
    weighted avg       0.33      0.33      0.33     49500


This baseline-level performance indicates that the model predictions are nearly random, reflecting the balanced distribution of the target variable and the limited predictive power of the features.

The confusion matrix supported this finding, showing that predictions were evenly distributed across classes, with no clear dominance along the diagonal.
Logistic Regression struggled to distinguish between High, Medium, and Low burnout levels, highlighting the limitations of the current dataset features.

# Random Forest Modelling

I then implemented a Random Forest classifier with 200 estimators to explore whether a non-linear, tree-based model could improve performance. 

                  precision    recall  f1-score   support
    
            High       0.33      0.33      0.33     16422
             Low       0.33      0.34      0.34     16675
          Medium       0.33      0.32      0.32     16403
    
        accuracy                           0.33     49500
       macro avg       0.33      0.33      0.33     49500
    weighted avg       0.33      0.33      0.33     49500

    
The Random Forest also achieved an overall accuracy of 33%, with precision, recall, and F1-scores near baseline. 

The classification Report again confirmed that the model frequently confused classes, producing predictions that were close to random.

To examine feature importance, I extracted the 10 most influential features according to the Random Forest model. These included student ID, attendance percentage, CGPA, and screen time hours. 
Using only these top features produced minimal improvement, slightly increasing recall for the Low burnout class, but the overall performance remained essentially equivalent to random guessing.

          	              0
          student_id	0.078032
          attendance_percentage	0.076702
          cgpa	0.076515
          screen_time_hours	0.072281
          daily_study_hours	0.071110
          daily_sleep_hours	0.066544
          physical_activity_hours	0.057967
          social_support_score	0.046892
          anxiety_score	0.046800
          academic_pressure_score	0.046502

This result underscores that even the most important features carry a limited signal for predicting burnout levels.

                  precision    recall  f1-score   support
    
            High       0.33      0.21      0.26     16422
             Low       0.34      0.47      0.39     16675
          Medium       0.33      0.32      0.33     16403
    
        accuracy                           0.33     49500
       macro avg       0.33      0.33      0.33     49500
    weighted avg       0.33      0.33      0.33     49500

Conclusion

Comparing Logistic Regression and Random Forest demonstrates that model complexity alone does not improve predictions for this dataset. 
Both models perform at baseline, indicating that the current features—demographic, academic, and lifestyle variables—are insufficient to reliably classify burnout levels. 
These findings emphasise the importance of feature engineering, including the creation of composite indicators from mental health, lifestyle, and academic variables, to extract meaningful predictive signals. 
Overall, the analysis highlights the challenges of predicting student burnout and the critical role of high-quality, informative features over the choice of model algorithm.
