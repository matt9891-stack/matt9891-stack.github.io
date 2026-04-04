---
layout: post
title: "Unit 6 Data Logistic Regression R"
subtitle: "Logistic Regression model implementation"
date: 2026-03-09
categories: [Module 4 Visualising Data]
tags: [R]
---

[NOTEBOOK](https://github.com/matt9891-stack/Logistic_R/blob/main/SeminarLogistic%20Reg.R)

---
# The Project

A logistic regression model was fit to the Smarket dataset to predict the daily market direction (Direction) based on lagged returns (Lag1 through Lag5) and trading volume (Volume).

    library(tidyverse)  # Collection of packages for data manipulation and visualisation
    library(ggplot2)    # For creating plots
    library(dplyr)      # For data manipulation (filter, select, mutate, etc.)
    library(tidyr)      # For reshaping data (pivoting, etc.)
    
    library(ISLR2)
    names(Smarket)

    [1] "Year"      "Lag1"      "Lag2"      "Lag3"      "Lag4"      "Lag5"      "Volume"    "Today"    
    [9] "Direction"

    dim(Smarket)
    
    > dim(Smarket)
    [1] 1250    9
    
    summary(Smarket)

    > summary(Smarket)
      Year           Lag1                Lag2                Lag3                Lag4          
     Min.   :2001   Min.   :-4.922000   Min.   :-4.922000   Min.   :-4.922000   Min.   :-4.922000  
     1st Qu.:2002   1st Qu.:-0.639500   1st Qu.:-0.639500   1st Qu.:-0.640000   1st Qu.:-0.640000  
     Median :2003   Median : 0.039000   Median : 0.039000   Median : 0.038500   Median : 0.038500  
     Mean   :2003   Mean   : 0.003834   Mean   : 0.003919   Mean   : 0.001716   Mean   : 0.001636  
     3rd Qu.:2004   3rd Qu.: 0.596750   3rd Qu.: 0.596750   3rd Qu.: 0.596750   3rd Qu.: 0.596750  
     Max.   :2005   Max.   : 5.733000   Max.   : 5.733000   Max.   : 5.733000   Max.   : 5.733000  
          Lag5              Volume           Today           Direction 
     Min.   :-4.92200   Min.   :0.3561   Min.   :-4.922000   Down:602  
     1st Qu.:-0.64000   1st Qu.:1.2574   1st Qu.:-0.639500   Up  :648  
     Median : 0.03850   Median :1.4229   Median : 0.038500             
     Mean   : 0.00561   Mean   :1.4783   Mean   : 0.003138             
     3rd Qu.: 0.59700   3rd Qu.:1.6417   3rd Qu.: 0.596750             
     Max.   : 5.73300   Max.   :3.1525   Max.   : 5.733000 

The Smarket dataset contains daily stock market data from 2001 to 2005. 
The lagged returns (Lag1 to Lag5) have means close to zero, showing that most daily changes are small, though a few extreme values reach around ±5. 
The trading Volume varies from 0.36 to 3.15, with most days around the median of 1.42, indicating moderate activity on typical days. The Today returns follow a similar pattern to the lagged values. 
The Direction variable shows slightly more “Up” days (648) than “Down” days (602), suggesting a mild positive trend in the market over this period. Overall, the data reflects mostly small daily movements with occasional large swings.

    # Built-in R function for creating a matrix of scatterplots.
    # Each variable is plotted against every other variable in a grid.
    pairs(Smarket) 
    
    # The cor() function produces a matrix that contains all of the pairwise 
    #correlations among the predictors in a dataset.
    cor(Smarket[,-9])

 <img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/33672d38-a282-406a-9576-4f5b20c4e307" />

The correlation table shows how the variables in the Smarket dataset are related. Most of the lagged returns (Lag1 to Lag5) have very small correlations with each other and with Today, meaning that past daily returns don’t strongly predict today’s return. 
The trading Volume has a moderate positive correlation with Year, showing that volume tends to increase over time. Overall, the weak correlations explain why predicting the market direction is hard using just the previous days’ returns.

    attach(Smarket)
    plot(Volume)
    
<img width="994" height="546" alt="image" src="https://github.com/user-attachments/assets/6e179e14-3083-45a9-a698-5175c2f46c85" />

The plot of Volume shows daily trading activity with each day on the x-axis and volume on the y-axis.
The x-axis goes from 0 to 1200, representing all trading days in the dataset. Most of the trading days have moderate volume, but there are noticeable spikes where volume was unusually high. 
Overall, the plot shows that while daily volume fluctuates, there are some days with much higher trading activity compared to the rest.

    glm.fits <- glm(
      Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
      data = Smarket,
      family = binomial
    )

    summary(glm.fits)           # Display full model summary: coefficients, std errors, z-values, p-values
    coef(glm.fits)              # Extract only the estimated coefficients
    summary(glm.fits)$coef      # Extract coefficient matrix (estimates, std errors, z, p-values)
    summary(glm.fits)$coef[,4]

    > summary(glm.fits)           # Display full model summary: coefficients, std errors, z-values, p-values

    Call:
    glm(formula = Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + 
        Volume, family = binomial, data = Smarket)
    
    Coefficients:
                 Estimate Std. Error z value Pr(>|z|)
    (Intercept) -0.126000   0.240736  -0.523    0.601
    Lag1        -0.073074   0.050167  -1.457    0.145
    Lag2        -0.042301   0.050086  -0.845    0.398
    Lag3         0.011085   0.049939   0.222    0.824
    Lag4         0.009359   0.049974   0.187    0.851
    Lag5         0.010313   0.049511   0.208    0.835
    Volume       0.135441   0.158360   0.855    0.392
    
    (Dispersion parameter for binomial family taken to be 1)

Looking at the p-values (Pr(>|z|)), none of the predictors are statistically significant at the typical 0.05 level. 
The intercept has a p-value of 0.60, Lag1 is 0.15, Lag2 is 0.40, and the remaining variables all have p-values above 0.39. This means that individually, these predictors do not provide strong evidence that they influence daily market direction.
    
        Null deviance: 1731.2  on 1249  degrees of freedom
    Residual deviance: 1727.6  on 1243  degrees of freedom
    AIC: 1741.6
    
    Number of Fisher Scoring iterations: 3
    
    > coef(glm.fits)              # Extract only the estimated coefficients
     (Intercept)         Lag1         Lag2         Lag3         Lag4         Lag5       Volume 
    -0.126000257 -0.073073746 -0.042301344  0.011085108  0.009358938  0.010313068  0.135440659 
    
    > summary(glm.fits)$coef      # Extract coefficient matrix (estimates, std errors, z, p-values)
                    Estimate Std. Error    z value  Pr(>|z|)
    (Intercept) -0.126000257 0.24073574 -0.5233966 0.6006983
    Lag1        -0.073073746 0.05016739 -1.4565986 0.1452272
    Lag2        -0.042301344 0.05008605 -0.8445733 0.3983491
    Lag3         0.011085108 0.04993854  0.2219750 0.8243333
    Lag4         0.009358938 0.04997413  0.1872757 0.8514445
    Lag5         0.010313068 0.04951146  0.2082966 0.8349974
    Volume       0.135440659 0.15835970  0.8552723 0.3924004
    > summary(glm.fits)$coef[,4] 
    (Intercept)        Lag1        Lag2        Lag3        Lag4        Lag5      Volume 
      0.6006983   0.1452272   0.3983491   0.8243333   0.8514445   0.8349974   0.3924004

The small size of the coefficients and the high p-values suggest that past daily returns and trading volume have very little predictive power for whether the market goes up or down on a given day. 
The model’s residual deviance and AIC also indicate that it does not fit the data much better than a null model with no predictors. Overall, the results highlight the challenge of predicting short-term market movements using just a few lagged returns and volume.

    glm.probs <- predict(glm.fits, type = "response")
    glm.probs[1:10]
    > glm.probs[1:10]
        1         2         3         4         5         6         7         8         9        10 
    0.5070841 0.4814679 0.4811388 0.5152224 0.5107812 0.5069565 0.4926509 0.5092292 0.5176135 0.4888378 

The predicted probabilities from the logistic regression model (glm.probs) show the likelihood that each day will be an “Up” day. 
Looking at the first ten values, most probabilities are very close to 0.5, ranging from about 0.48 to 0.52. This indicates that the model is not very confident in its predictions and reflects the weak predictive power of the lagged returns and volume.

    contrasts(Direction)         # Show which value of 'Direction' is considered the baseline
    Up
    Down  0
    Up    1
    
The Direction variable uses “Down” as the baseline and “Up” as the second level. Using the predicted probabilities from the logistic regression model, days with probabilities above 0.5 were classified as “Up” and the rest as “Down.”

    # Initialise all predictions as "Down"
    glm.pred <- rep("Down", 1250)
    
    # Set predictions to "Up" if predicted probability > 0.5
    glm.pred[glm.probs > 0.5] <- "Up"

    table(glm.pred, Direction)  # Confusion matrix: predicted vs actual
    mean(glm.pred == Direction)  # Overall proportion of correct predictions

          Direction
    glm.pred Down  Up
        Down  145 141
        Up    457 507
        
    > mean(glm.pred == Direction)
    [1] 0.5216
The confusion matrix shows that the model correctly predicted 507 “Up” days and 145 “Down” days, while making 457 false positives and 141 false negatives.
  
    # Test set: data from 2005
    Smarket.2005 <- Smarket[!train, ]  
    dim(Smarket.2005)            # Show dimensions of test set
    
    # Extract true 'Direction' values for 2005
    Direction.2005 <- Direction[!train]

    #Fit Model on Training Set Only
    glm.fits <- glm(
      Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
      data = Smarket,
      family = binomial,
      subset = train

      #Predict on Test Set

      glm.probs <- predict(glm.fits, Smarket.2005, type = "response")

    # Convert probabilities to class labels
    glm.pred <- rep("Down", 252)
    glm.pred[glm.probs > 0.5] <- "Up"

    # Evaluate predictions
    table(glm.pred, Direction.2005)       # Confusion matrix
    mean(glm.pred == Direction.2005)      # Accuracy
    mean(glm.pred != Direction.2005)      # Misclassification rate

    > table(glm.pred, Direction.2005)       # Confusion matrix
        Direction. 2005
    glm.pred Down Up
        Down   77 97
        Up     34 44
    > mean(glm.pred == Direction.2005)      # Accuracy
    [1] 0.4801587
    > mean(glm.pred != Direction.2005)      # Misclassification rate
    [1] 0.5198413
    )

 Using the logistic regression model trained on data before 2005, predictions were made on the 2005 test set. 
 The confusion matrix shows that the model correctly predicted 44 “Up” days and 77 “Down” days, but misclassified 97 “Up” days and 34 “Down” days. 
 The overall accuracy is about 48%, and the misclassification rate is roughly 52%, which is slightly worse than random guessing. This shows that the model performs poorly out-of-sample and confirms that lagged returns and volume provide very limited predictive power for daily market direction.

    # Fit a Simpler Model Using Only Lag1 and Lag2
    glm.fits <- glm(Direction ~ Lag1 + Lag2,
                    data = Smarket,
                    family = binomial,
                    subset = train)
    
    glm.probs <- predict(glm.fits, Smarket.2005, type = "response")
    
    glm.pred <- rep("Down", 252)
    glm.pred[glm.probs > 0.5] <- "Up"

      table(glm.pred, Direction.2005)
    mean(glm.pred == Direction.2005)

    > table(glm.pred, Direction.2005)
        Direction.2005
    glm.pred Down  Up
        Down   35  35
        Up     76 106
    > mean(glm.pred == Direction.2005)
    [1] 0.5595238

A simpler logistic regression model using only Lag1 and Lag2 was tested on the 2005 data. The confusion matrix shows that the model correctly predicted 106 “Up” days and 35 “Down” days, while misclassifying 76 “Up” days and 35 “Down” days. 
The overall accuracy is about 56%, which is an improvement over the previous full model. This suggests that using only the most recent lagged returns slightly improves predictive performance, although the model still makes many mistakes, and short-term market direction remains difficult to predict.

    predict(glm.fits,
            newdata = data.frame(Lag1 = c(1.2, 1.5),
                                 Lag2 = c(1.1, -0.8)),
            type = "response"
    )
    > predict(glm.fits,
    +         newdata = data.frame(Lag1 = c(1.2, 1.5),
    +                              Lag2 = c(1.1, -0.8)),
    +         type = "response"
    + )
            1         2 
    0.4791462 0.4960939 

The logistic regression model using only Lag1 and Lag2 was used to predict the probability of an “Up” day for two new hypothetical observations. The predicted probabilities are approximately 0.48 and 0.50, both very close to 0.5. 
This shows that the model is not confident in predicting the market direction for these new cases, reflecting the limited predictive power of just the two lagged returns. Essentially, the model suggests that both days are almost equally likely to be “Up” or “Down.”
