---
layout: post
title: "Unit 7 Principal Component Analysis"
subtitle: "PCA on USA arrests R"
date: 2026-03-15
categories: [Module 4 Visualising Data]
tags: [R]
---

# Principal Component Analysis (PCA) and SVD – Results Commentary

This analysis explores the structure of the USArrests dataset using Principal Component Analysis (PCA) and Singular Value Decomposition (SVD), followed by an application of SVD for missing data imputation.

## Data Exploration

The dataset consists of crime statistics across U.S. states. Initial inspection using glimpse() and summary statistics (mean and variance) shows that the variables are measured on different scales. 
For example, variables like Assault have much larger variance than Murder, making standardization necessary before PCA.

    library(tidyverse)  # Collection of packages for data manipulation and visualization
    library(ggplot2)    # For creating plots
    library(dplyr)      # For data manipulation (filter, select, mutate, etc.)
    library(tidyr)      # For reshaping data (pivoting, etc.)
    
    glimpse(table2)  # Show structure of dataset 'table2' (columns, types, preview)
    
    states <- row.names(USArrests)  # Get row names (state names) from dataset
    states                          # Print state names
    
    apply(USArrests, 2, mean)  # Compute mean of each column (variables)
    apply(USArrests, 2, var)   # Compute variance of each column

    glimpse(table2)  # Show structure of dataset 'table2' (columns, types, preview)
    Rows: 12
    Columns: 4
    $ country <chr> "Afghanistan", "Afghanistan", "Afghanistan", "Afghanistan", "Brazil", "Brazil", "Brazil…
    $ year    <dbl> 1999, 1999, 2000, 2000, 1999, 1999, 2000, 2000, 1999, 1999, 2000, 2000
    $ type    <chr> "cases", "population", "cases", "population", "cases", "population", "cases", "populati…
    $ count   <dbl> 745, 19987071, 2666, 20595360, 37737, 172006362, 80488, 174504898, 212258, 1272915272, …
    > 
    > states <- row.names(USArrests)  # Get row names (state names) from dataset
    > states                          # Print state names
     [1] "Alabama"        "Alaska"         "Arizona"        "Arkansas"       "California"    
     [6] "Colorado"       "Connecticut"    "Delaware"       "Florida"        "Georgia"       
    [11] "Hawaii"         "Idaho"          "Illinois"       "Indiana"        "Iowa"          
    [16] "Kansas"         "Kentucky"       "Louisiana"      "Maine"          "Maryland"      
    [21] "Massachusetts"  "Michigan"       "Minnesota"      "Mississippi"    "Missouri"      
    [26] "Montana"        "Nebraska"       "Nevada"         "New Hampshire"  "New Jersey"    
    [31] "New Mexico"     "New York"       "North Carolina" "North Dakota"   "Ohio"          
    [36] "Oklahoma"       "Oregon"         "Pennsylvania"   "Rhode Island"   "South Carolina"
    [41] "South Dakota"   "Tennessee"      "Texas"          "Utah"           "Vermont"       
    [46] "Virginia"       "Washington"     "West Virginia"  "Wisconsin"      "Wyoming"       
    > 
    > apply(USArrests, 2, mean)  # Compute mean of each column (variables)
      Murder  Assault UrbanPop     Rape 
       7.788  170.760   65.540   21.232 
    > apply(USArrests, 2, var)   # Compute variance of each column
        Murder    Assault   UrbanPop       Rape 
      18.97047 6945.16571  209.51878   87.72916 

## PCA with Standardisation

PCA was performed using prcomp() with scaling enabled (scale = TRUE), ensuring that all variables contribute equally.

The principal components (PCs) represent linear combinations of the original variables.
The loadings (rotation) indicate how strongly each variable contributes to each component.
The scores (x) represent the transformed observations in the new coordinate system.

The signs of loadings and scores were flipped for better interpretability, which does not affect the results but improves visualisation consistency.

    pr.out <- prcomp(USArrests, scale = TRUE)  
    # Perform PCA, scaling variables to have unit variance
    
    
    names(pr.out)     # Show components of PCA object
    pr.out$center     # Means used for centering variables
    pr.out$scale      # Scaling (standard deviations)
    pr.out$rotation   # Principal component loadings (eigenvectors)
    dim(pr.out$x)     # Dimensions of transformed data (scores)
    
    #Adjust signs for visualization
    
    pr.out$rotation = -pr.out$rotation  # Flip signs of loadings
    pr.out$x = -pr.out$x                # Flip scores accordingly
    
    biplot(pr.out, scale = 0)  
    # Plot PCA biplot (observations + variable directions)

 <img width="995" height="546" alt="image" src="https://github.com/user-attachments/assets/02dd3568-e4bf-4df2-ba85-ed528d4ce82f" />

## Variance Explained

The proportion of variance explained (PVE) shows how much information each principal component captures:

PC1 explains the largest portion of variance, indicating a dominant underlying pattern in the data.
PC2 explains a smaller but still significant portion.
The scree plot shows a clear drop after the first two components, suggesting that most of the variability can be summarized in 2 principal components.

The cumulative PVE confirms that a reduced-dimensional representation is appropriate.

    pr.out$sdev         # Standard deviations of principal components
    pr.var <- pr.out$sdev^2  # Variance of each principal component
    pr.var
    
    pve <- pr.var / sum(pr.var)  # Proportion of variance explained (PVE)
    pve
    
    # Scree plots
    
    par(mfrow = c(1,2))  # Set plotting area to show 2 plots side by side
    
    plot(pve,
         xlab = 'Principal Component',
         ylab = 'Proportion of Variance Explained',
         ylim = c(0,1),
         type = 'b')  # Plot PVE
    
    plot(cumsum(pve),
         xlab = 'Principal Component',
         ylab = 'Cumulative Proportion of Variance Explained',
         ylim = c(0,1),
         type = 'b')  # Plot cumulative PVE

<img width="995" height="546" alt="image" src="https://github.com/user-attachments/assets/1fb59ef0-b44a-4865-b4b9-f55b18c03698" />

## PCA vs SVD

PCA results were compared with Singular Value Decomposition (SVD):

The right singular vectors (v) correspond to PCA loadings.
The reconstructed scores from SVD match the PCA scores (pcob$x), confirming the mathematical equivalence between PCA and SVD on standardized data.

This validates that both methods produce consistent results when applied correctly.

# Standardize data and PCA again

    X <- data.matrix(scale(USArrests))  # Convert to matrix and standardize variables
    
    pcob <- prcomp(X)  # PCA on already standardized data
    summary(pcob)      # Summary (variance explained, etc.)
    
    # Singular Value Decomposition (SVD)
    
    sX <- svd(X)     # Compute SVD of matrix X
    names(sX)        # Components: u, d, v
    round(sX$v, 3)   # Right singular vectors (rounded)
    
    pcob$rotation    # Compare with PCA loadings
    
    t(sX$d * t(sX$u))  # Reconstruct principal component scores from SVD
    pcob$x             # PCA scores (should match SVD result)

    X <- data.matrix(scale(USArrests))  # Convert to matrix and standardize variables
    > 
    > pcob <- prcomp(X)  # PCA on already standardized data
    > summary(pcob)      # Summary (variance explained, etc.)
    Importance of components:
                              PC1    PC2     PC3     PC4
    Standard deviation     1.5749 0.9949 0.59713 0.41645
    Proportion of Variance 0.6201 0.2474 0.08914 0.04336
    Cumulative Proportion  0.6201 0.8675 0.95664 1.00000
    > 
    > # Singular Value Decomposition (SVD)
    > 
    > sX <- svd(X)     # Compute SVD of matrix X
    > names(sX)        # Components: u, d, v
    [1] "d" "u" "v"
    > round(sX$v, 3)   # Right singular vectors (rounded)
           [,1]   [,2]   [,3]   [,4]
    [1,] -0.536 -0.418  0.341  0.649
    [2,] -0.583 -0.188  0.268 -0.743
    [3,] -0.278  0.873  0.378  0.134
    [4,] -0.543  0.167 -0.818  0.089
    > 
    > pcob$rotation    # Compare with PCA loadings
                    PC1        PC2        PC3         PC4
    Murder   -0.5358995 -0.4181809  0.3412327  0.64922780
    Assault  -0.5831836 -0.1879856  0.2681484 -0.74340748
    UrbanPop -0.2781909  0.8728062  0.3780158  0.13387773
    Rape     -0.5434321  0.1673186 -0.8177779  0.08902432
    > 
    > t(sX$d * t(sX$u))  # Reconstruct principal component scores from SVD
                 [,1]        [,2]        [,3]         [,4]
     [1,] -0.97566045 -1.12200121  0.43980366  0.154696581
     [2,] -1.93053788 -1.06242692 -2.01950027 -0.434175454
     [3,] -1.74544285  0.73845954 -0.05423025 -0.826264240
     [4,]  0.13999894 -1.10854226 -0.11342217 -0.180973554
     [5,] -2.49861285  1.52742672 -0.59254100 -0.338559240
     [6,] -1.49934074  0.97762966 -1.08400162  0.001450164
     [7,]  1.34499236  1.07798362  0.63679250 -0.117278736
     [8,] -0.04722981  0.32208890  0.71141032 -0.873113315
     [9,] -2.98275967 -0.03883425  0.57103206 -0.095317042
    [10,] -1.62280742 -1.26608838  0.33901818  1.065974459
    [11,]  0.90348448  1.55467609 -0.05027151  0.893733198
    [12,]  1.62331903 -0.20885253 -0.25719021 -0.494087852
    [13,] -1.36505197  0.67498834  0.67068647 -0.120794916
    [14,]  0.50038122  0.15003926 -0.22576277  0.420397595
    [15,]  2.23099579  0.10300828 -0.16291036  0.017379470
    [16,]  0.78887206  0.26744941 -0.02529648  0.204421034
    [17,]  0.74331256 -0.94880748  0.02808429  0.663817237
    [18,] -1.54909076 -0.86230011  0.77560598  0.450157791
    [19,]  2.37274014 -0.37260865  0.06502225 -0.327138529
    [20,] -1.74564663 -0.42335704  0.15566968 -0.553450589
    [21,]  0.48128007  1.45967706  0.60337172 -0.177793902
    [22,] -2.08725025  0.15383500 -0.38100046  0.101343128
## Missing Data Imputation using SVD

Artificial missing values were introduced into the dataset to test imputation.

Process:
Missing entries were initially replaced with column means.
An iterative algorithm was applied:
Perform low-rank SVD approximation (M = 1)
Update missing values using reconstructed data
Repeat until convergence (based on relative error)
Results:
The algorithm converges as the relative error decreases across iterations.
The final imputed values show a positive correlation with the true values, indicating that the low-rank structure captures meaningful patterns in the data.

# Introduce missing values

    nomit <- 20  # Number of missing values to introduce
    
    set.seed(15)  
    ina <- sample(seq(50), nomit)         # Random row indices
    inb <- sample(1:4, nomit, replace=TRUE)  # Random column indices
    
    Xna <- X  # Copy of original matrix
    
    index.na <- cbind(ina, inb)  # Combine row/column indices
    Xna[index.na] <- NA          # Insert missing values
    
    # Function for low-rank SVD approximation
    
    fit.svd <- function(X, M = 1) {
      svdob <- svd(X)  # Perform SVD
      
      with(svdob,
           u[,1:M, drop = FALSE] %*%
             (d[1:M] * t(v[,1:M, drop = FALSE])))
      # Reconstruct matrix using first M components (rank-M approximation)
    }
    
    svdob$u[,1:M,drop = FALSE] %*%
      (svdob$d[1:M]*t(svdob$v[,1:M,drop = FALSE]))
    
    # Initialize missing value imputation
    
    Xhat <- Xna  # Initialize reconstructed matrix
    
    xbar <- colMeans(Xna, na.rm = TRUE)  # Column means (ignoring NA)
    
    Xhat[index.na] <- xbar[inb]  # Replace missing values with column means
    
    # Iterative SVD imputation
    
    thresh <- 1e-7  # Convergence threshold
    rel_err <- 1    # Initial relative error
    iter <- 0       # Iteration counter
    
    ismiss <- is.na(Xna)  # Logical matrix of missing values
    
    mssold <- mean((scale(Xna, xbar, FALSE)[!ismiss])^2)  # Initial error
    mss0 <- mean(Xna[!ismiss]^2)  # Normalization factor
    
    while(rel_err > thresh) {
      iter <- iter + 1
      
      # Step 2(a): Low-rank approximation (NOTE: typo here!)
      Xapp <- fit.svd(Xhat, M = 1)  
    
      
      # Step 2(b): Update missing values
      Xhat[ismiss] <- Xapp[ismiss]
      
      # Step 2(c): Compute reconstruction error
      mss <- mean(((Xna - Xapp)[!ismiss])^2)
      
      # Relative improvement
      rel_err <- (mssold - mss) / mss0
      
      mssold <- mss
      
      cat("iter:", iter, "MSS:", mss, "Rel.Err:", rel_err, "")
    }
    
    cor(Xapp[ismiss], X[ismiss])  
    # Correlation between imputed values and true values

Conclusion

This analysis demonstrates how dimensionality reduction techniques like PCA can simplify complex datasets while preserving most of the information. 
Additionally, SVD proves to be a powerful tool not only for decomposition but also for handling missing data in a principled way.
