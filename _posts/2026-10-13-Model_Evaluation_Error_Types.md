---
layout: post
title: "Model Evaluation- Unit 11"
subtitle: "Module 6 – Machine Learning - Model Evaluation"
date: 2026-10-13
categories: [Module 6 Machine Learning]
tags: [Python]
---


## Sensitivity, Specificity and Classification Errors

Sensitivity, specificity, and Type I and Type II errors are metrics used to evaluate the performance of classification models, which provide a more detailed understanding of how well a model identifies observations belonging to a particular class and distinguishes them from observations belonging to other classes.

### Sensitivity (True Positive Rate)

Sensitivity, also known as the True Positive Rate (TPR) or recall, measures the proportion of actual positive observations that are correctly identified by the model.

<img width="262" height="102" alt="image" src="https://github.com/user-attachments/assets/6b111524-03d5-4590-a18a-094f6f417c7d" />

Where:
- **TP (True Positives):** observations correctly classified as positive.
- **FN (False Negatives):** positive observations incorrectly classified as negative.

A high sensitivity indicates that the model identifies most observations belonging to the selected class, resulting in fewer false negatives. 

On the other hand, a low sensitivity indicates that the model fails to identify a larger proportion of actual positive observations.

### Specificity (True Negative Rate)

Specificity, also known as the True Negative Rate (TNR), measures the proportion of actual negative observations that are correctly identified as negative by the model.

<img width="272" height="67" alt="image" src="https://github.com/user-attachments/assets/cb554961-db4d-44cb-865a-5c36f77df594" />

Where:
- **TN (True Negatives):** observations correctly classified as negative.
- **FP (False Positives):** negative observations incorrectly classified as positive.

A high specificity indicates that the model correctly rejects most observations that do not belong to the selected class while a low specificity indicates that more negative observations are incorrectly classified as positive.

### Type I Error (False Positive Rate)

A Type I error occurs when the model incorrectly predicts that an observation belongs to the selected class when it actually belongs to another class. 

This is also known as a false positive.

The Type I error rate measures the proportion of actual negative observations that are incorrectly classified as positive.

<img width="298" height="70" alt="image" src="https://github.com/user-attachments/assets/baf581bb-6b11-4406-a4cb-eb85c28ecc32" />

A high Type I error rate indicates that the model produces more false positive predictions. 

This error rate is directly related to specificity:

<img width="303" height="49" alt="image" src="https://github.com/user-attachments/assets/36bbe810-34b4-495e-9ce5-b4329b3d9c6f" />

A higher specificity corresponds to a lower Type I error rate.

### Type II Error (False Negative Rate)

A Type II error occurs when an observation actually belongs to the selected class, but the model incorrectly predicts that it belongs to another class. 

This is also known as a false negative.

The Type II error rate measures the proportion of actual positive observations that are incorrectly classified as negative.

<img width="298" height="65" alt="image" src="https://github.com/user-attachments/assets/c6221290-ab21-4bf4-9503-a278c19800e6" />

A high Type II error rate indicates that the model fails to identify a larger proportion of actual positive observations which is directly related to sensitivity:

<img width="282" height="49" alt="image" src="https://github.com/user-attachments/assets/57b9216e-5b96-4550-9d5d-9b028d91871b" />

Therefore, higher sensitivity corresponds to a lower Type II error rate.

### Applying These Metrics to Classification Models

Finally, while Sensitivity focuses on correctly identifying positive observations, specificity focuses on correctly identifying negative observations. 

Type I and Type II error rates quantify the corresponding types of misclassification.

For multiclass classification problems, these metrics should be interpreted alongside other evaluation measures, such as accuracy, precision, the F1-score and the confusion matrix, to provide a more complete assessment of a classification model's performance.
