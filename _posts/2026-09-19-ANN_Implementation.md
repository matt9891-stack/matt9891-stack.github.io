---
layout: post
title: "Artificial Neural Network Implementation- Unit 8"
subtitle: "Module 6 – Machine Learning - ANN Implementation"
date: 2026-09-19
categories: [Module 6 Machine Learning] 
tags: [Python]
---

# Artificial Neural Network

The following example demonstrates how to build an Artificial Neural Network for a binary classification problem using the Titanic dataset.

# Import Libraries
    import pandas as pd
    import numpy as np
    import seaborn as sns
    
    from sklearn.model_selection import train_test_split
    from sklearn.impute import SimpleImputer
    from sklearn.preprocessing import StandardScaler, OneHotEncoder
    
    import tensorflow as tf
    from tensorflow import keras
    
# Load the Dataset

The Titanic dataset contains information about passengers and whether they survived.

    df = sns.load_dataset("titanic")
    
    df.head()

<img width="954" height="179" alt="image" src="https://github.com/user-attachments/assets/779ae20d-bbd7-424a-bc9f-83fd05a9cdfe" />

We can inspect the data

    df.info()

<img width="501" height="427" alt="image" src="https://github.com/user-attachments/assets/60293834-4ce4-4a13-8af6-a4c05b885075" />

Select Features and Target

The selected features contain both numerical and categorical variables.

    features = [
                "age", 
                "fare", 
                "sibsp", 
                "parch", 
                "pclass", 
                "sex", 
                "embarked" ] 
    
    X = df[features] 
    y = df["survived"]

X contains the passenger information used by the model.

y is the binary target: 1 or 0.

# Separate Numerical and Categorical Features

    numeric_features = [ "age", "fare", "sibsp", "parch", "pclass" ] 
    
    categorical_features = [ "sex", "embarked" ]
    
This separation allows different preprocessing methods to be applied to the two types of variables.

Train-Test Split

The dataset is split before fitting the preprocessing transformations.

    X_train, X_test, y_train, y_test = train_test_split(
        X,
        y,
        test_size=0.2,
        random_state=42,
        stratify=y
    )

The test set is kept separate so that it can later be used to evaluate the model on unseen observations.

stratify=y helps maintain a similar proportion of the two classes in the training and test sets.

# Numerical Missing Values

    X_train[numeric_features].isna().sum()

<img width="120" height="139" alt="image" src="https://github.com/user-attachments/assets/aace2a16-a631-4847-b874-6c9fca49caf3" />

A median imputer can be used:

    numeric_imputer = SimpleImputer(
        strategy="median"
    )

The imputer is fitted only on the training data:

    X_train_num = pd.DataFrame(
        numeric_imputer.fit_transform(
            X_train[numeric_features]
        ),
        columns=numeric_features,
        index=X_train.index
    )

The same fitted imputer is then applied to the test data:

    X_test_num = pd.DataFrame(
        numeric_imputer.transform(
            X_test[numeric_features]
        ),
        columns=numeric_features,
        index=X_test.index
    )

The important point is that the test data uses transform() rather than fit_transform().

This prevents information from the test set from being used to calculate the preprocessing parameters.

    X_train_num[numeric_features].isna().sum()

<img width="114" height="137" alt="image" src="https://github.com/user-attachments/assets/6587639a-2a75-4908-8bb0-063e82145e01" />

# Categorical Missing Values

Categorical variables can also contain missing values.

    X_train[categorical_features].isna().sum()

<img width="136" height="67" alt="image" src="https://github.com/user-attachments/assets/216c0cc8-91e1-4f50-88e2-e5ad41bfbdd5" />

    categorical_imputer = SimpleImputer(
        strategy="most_frequent"
    )

The imputer is fitted on the training data:

    X_train_cat = pd.DataFrame(
        categorical_imputer.fit_transform(
            X_train[categorical_features]
        ),
        columns=categorical_features,
        index=X_train.index
    )

The same transformation is applied to the test set:

    X_test_cat = pd.DataFrame(
        categorical_imputer.transform(
            X_test[categorical_features]
        ),
        columns=categorical_features,
        index=X_test.index
    )

# One-Hot Encoding

Keras expects numerical inputs, so the categorical variables must be converted into numerical values.

    encoder = OneHotEncoder(
        handle_unknown="ignore",
        sparse_output=False
    )

The encoder is fitted on the training data:

    X_train_cat_encoded = encoder.fit_transform(
        X_train_cat
    )

The same fitted encoder is applied to the test data:

    X_test_cat_encoded = encoder.transform(
        X_test_cat
    )

handle_unknown="ignore" means that if a new category appears in future data, the encoder will not produce an error.

# Standardisation

The numerical variables are standardised:

scaler = StandardScaler()

Again, the scaler is fitted only on the training data:

    X_train_num_scaled = scaler.fit_transform(
        X_train_num
    )

The fitted scaler is then used for the test data:

    X_test_num_scaled = scaler.transform(
        X_test_num
    )

Standardisation gives the numerical variables a comparable scale, which is useful when training a neural network.

# Recombine the Numerical and Categorical Data

The processed numerical and categorical features can now be combined.

    X_train_processed_arr = np.hstack([ X_train_num_scaled, X_train_cat_encoded ]) 
    X_test_processed_arr = np.hstack([ X_test_num_scaled, X_test_cat_encoded ])

# Build the ANN

The network can now be created using Keras.

model = keras.Sequential([

    keras.layers.Input(
        shape=(X_train_processed_arr.shape[1],)
    ),

    keras.layers.Dense(
        32,
        activation="relu"
    ),

    keras.layers.Dense(
        16,
        activation="relu"
    ),

    keras.layers.Dense(
        1,
        activation="sigmoid"
    )
    ])

The number of input neurons is determined by the number of processed features:

    X_train_processed_arr.shape[1]

The final layer contains one neuron because this is a binary classification problem.

The sigmoid activation converts its output into a probability between 0 and 1.

# Compile the Model

Before training, we specify the optimiser, loss function and evaluation metric.

    model.compile(
        optimizer="adam",
        loss="binary_crossentropy",
        metrics=["accuracy"]
    )

Here:

- adam is the optimiser.
- binary_crossentropy measures the classification error.
- accuracy measures the proportion of correctly classified observations.

# Train the Model
    history = model.fit(
        X_train_processed_arr,
        y_train,
        validation_split=0.2,
        epochs=50,
        batch_size=32
    )

<img width="899" height="621" alt="image" src="https://github.com/user-attachments/assets/e38603bb-858d-4688-8e79-d22c262cd05a" />
    
## epochs=50

The model can see the complete training data up to 50 times.

## batch_size=32

The model processes 32 observations at a time before calculating an update to the weights.

## validation_split=0.2

Keras keeps part of the supplied training data for validation.

The validation data is not used to directly update the model weights. It is used to monitor how the model performs on data that was not used for those weight updates.

# Evaluate the Model

The test set can now be used for the final evaluation.

    model.evaluate(
        X_test_processed_arr,
        y_test
    )

 <img width="576" height="86" alt="image" src="https://github.com/user-attachments/assets/383236d9-b9aa-4293-9c5e-1224fd01107a" />

This would mean:

0.4466 is the binary cross-entropy loss.
0.7933 means that approximately 79.33% of the test observations were classified correctly.

Loss and accuracy measure different things.

Loss considers the predicted probabilities and how far they are from the actual values.

Accuracy only considers whether the final predicted class is correct.



# Generate Probabilities

The model can produce probabilities instead of immediately producing classes.

    y_pred_probability = model.predict(
        X_test_processed_arr
    )

<img width="308" height="48" alt="image" src="https://github.com/user-attachments/assets/347951df-9379-484a-9dda-4ff3e9ccc879" />

    X_test_processed['probability'] = y_pred_probability
    X_test_processed
    
<img width="1007" height="355" alt="image" src="https://github.com/user-attachments/assets/24f363b2-8452-4221-837a-de6f6afe6ed7" />

# Convert Probabilities into Classes

    y_pred = (y_pred_probability >= 0.5).astype(int)
    X_test_processed['probability class'] = y_pred
    X_test_processed

 The threshold of 0.5 is a common starting point, although in some applications a different threshold may be appropriate.
 
<img width="1096" height="327" alt="image" src="https://github.com/user-attachments/assets/ca816d8a-c5c2-4e93-84a3-e650541036ec" />


# Tuning the ANN

The first model should be treated as a baseline model.

Instead of assuming that:

32 → 16 → 1

is the optimal architecture, different configurations can be tested.

For example:

    model = keras.Sequential([
        keras.layers.Input(
            shape=(X_train_processed_arr.shape[1],)
        ),

    keras.layers.Dense(
        64,
        activation="relu"
    ),

    keras.layers.Dense(
        32,
        activation="relu"
    ),

    keras.layers.Dense(
        1,
        activation="sigmoid"
    )
    ])

This increases the number of neurons and therefore the capacity of the network.

However, increasing the size of the network can also increase the risk of overfitting.

# Tuning the Learning Rate

The learning rate can also be changed.

For example:

    optimizer = keras.optimizers.Adam(
        learning_rate=0.001
    )
    
    model.compile(
        optimizer=optimizer,
        loss="binary_crossentropy",
        metrics=["accuracy"]
    )

Other values can then be tested:

0.01
0.001
0.0001

The validation performance can be compared for each configuration.

# Tuning Batch Size

Different batch sizes can also be tested:

batch_size=16
batch_size=32
batch_size=64

The same model can therefore be trained under different conditions, and the validation results can be compared.

# Early Stopping

Rather than automatically training for a fixed number of epochs, early stopping can be used.

    early_stopping = keras.callbacks.EarlyStopping(
        monitor="val_loss",
        patience=5,
        restore_best_weights=True
    )

The callback can then be passed to fit():

    history = model.fit(
        X_train_processed_arr,
        y_train,
        validation_split=0.2,
        epochs=100,
        batch_size=32,
        callbacks=[early_stopping]
    )

Here, 100 is the maximum number of epochs rather than a requirement to train for exactly 100 epochs.

If validation loss stops improving, training can finish earlier.

# Adding Dropout

Dropout can be added between hidden layers:

    model = keras.Sequential([
        keras.layers.Input(
            shape=(X_train_processed_arr.shape[1],)
        ),

    keras.layers.Dense(
        32,
        activation="relu"
    ),

    keras.layers.Dropout(0.2),

    keras.layers.Dense(
        16,
        activation="relu"
    ),

    keras.layers.Dropout(0.2),

    keras.layers.Dense(
        1,
        activation="sigmoid"
    )
    ])

This can help reduce overfitting by randomly dropping a proportion of neurons during training.

   
