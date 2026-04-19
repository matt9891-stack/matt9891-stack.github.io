---
layout: post
title: "Seminar 6 Activity "
subtitle: "Module 4 – Seminar 6"
date: 2026-04-10
categories: [Module 4 Visualising Data]
tags: [R,tidyverse,tidyr,ggplot]
---

This analysis explores the USArrests dataset using both K-Means and Hierarchical Clustering to identify patterns in crime rates across states.

    import numpy as np
    import pandas as pd
    from sklearn.preprocessing import StandardScaler
    from sklearn.decomposition import PCA
    !pip install pydataset
    from pydataset import data
    import seaborn as sns
    import matplotlib.pyplot as plt

The USArrests dataset is loaded and converted into a pandas DataFrame. The first few rows are displayed to understand the structure of the data, which contains crime statistics for different states in the United States.

    df = data('USArrests')
    df1=pd.DataFrame(df)
    df1.head()

      	Murder	Assault	UrbanPop	Rape
    Alabama	13.2	236	58	21.2
    Alaska	10.0	263	48	44.5
    Arizona	8.1	294	80	31.0
    Arkansas	8.8	190	50	19.5
    California	9.0	276	91	40.6

The dataset index, which represents the state names, is reset and converted into a separate column called city. This step ensures that the state labels are treated as a variable rather than an index, making the dataset easier to manipulate and visualise in later steps.

    df1 = df1.reset_index()
    df1 = df1.rename(columns={'index': 'city'})

The dataset is reshaped from a wide format to a long (tidy) format using pd.melt(). The variables Murder, Assault, UrbanPop, and Rape are combined into a single column called Crime, with their corresponding values stored in another column.

This transformation allows for easier comparison across crime types and is particularly useful for grouped visualisations such as boxplots.

    df_vertical = pd.melt(frame=df1,id_vars='city',value_vars=['Murder','Assault','UrbanPop','Rape'],var_name = 'Crime')

    sns.boxplot(df_vertical,x = 'Crime',y = 'value',palette ='Set2');

<img width="571" height="434" alt="image" src="https://github.com/user-attachments/assets/2eacbb01-bcc0-48ed-a0a9-a961bc6f4865" />

This plot highlights differences in distribution, spread, and central tendency across the four crime categories. It provides an initial understanding of how crime rates vary between different types of offences. 
The use of colour improves visual separation between categories, making patterns easier to interpret.

# K-Means Clustering and Elbow Method
    from sklearn.cluster import KMeans

Before applying clustering algorithms, the dataset is standardised using StandardScaler. This step ensures that all variables contribute equally to distance calculations.

    # Standardize the features
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(df)

    # Elbow Method to find optimal k
    wcss = []  # Within-cluster sum of squares
    #Creates an empty list called wcss.
    #This will store the within-cluster sum of squares (WCSS) for different values of k.
    #WCSS measures how tightly grouped the data points are within each cluster (lower = better).
    for k in range(1, 11):
      #Looping through the value from 1 to 10 where each k represents a different number of clusters to test.
        kmeans = KMeans(n_clusters=k, random_state=42, n_init=10)
        #Creates a K-Means model for the current number of clusters (k).
        #n_init=10 runs the algorithm 10 times with different initial centroids and picks the best result.
        kmeans.fit(X_scaled)
        wcss.append(kmeans.inertia_)
        #kmeans.inertia_ gives the WCSS value for that model.

Within-cluster sum of squares (WCSS) is a measure used in clustering to evaluate how closely grouped the data points are within each cluster. It represents the total squared distance between each data point and the centroid of the cluster to which it belongs. 
A lower WCSS value indicates that the data points are located closer to their cluster centres, meaning the clusters are more compact and well-defined.

    # Plot the elbow curve
    plt.figure(figsize=(8,5))
    plt.plot(range(1,11), wcss, marker='o')
    plt.title("Elbow Method for Optimal k")
    plt.xlabel("Number of Clusters")
    plt.ylabel("WCSS (Inertia)")
    plt.show()

<img width="695" height="470" alt="image" src="https://github.com/user-attachments/assets/efc6f477-247f-4a05-8b04-21dc2593e2d2" />

The elbow curve is a plot of the number of clusters (k) against the within-cluster sum of squares (WCSS), used in K-Means clustering to evaluate how well the data is grouped for different values of k.

It represents the trade-off between model complexity and clustering quality:

As k increases → clusters become more compact → WCSS decreases

    # Choose k based on elbow (for example, k=3)
    k_optimal = 3
    kmeans = KMeans(n_clusters=k_optimal, random_state=42, n_init=10)
    clusters = kmeans.fit_predict(X_scaled)
    
K-Means clustering is applied to identify patterns within the data. 
The Elbow Method is used to determine the optimal number of clusters by plotting Within-Cluster Sum of Squares (WCSS) against different values of k. 
The results suggest that k = 3 provides a good balance between model simplicity and performance, as improvements beyond this point become marginal.

The dataset is then assigned cluster labels based on this value.
    
    # Add cluster labels to the dataframe
    df['Cluster'] = clusters

# PCA for Visualisation of Clusters

Principal Component Analysis (PCA) is a dimensionality reduction technique used to simplify complex datasets with many features while retaining most of the original variability. 
It does this by transforming the original correlated features into a smaller set of uncorrelated components, called principal components, which are linear combinations of the original features.

    # Visualise clusters using PCA (2 components)
    pca = PCA(n_components=2)
    X_pca = pca.fit_transform(X_scaled)
    
    # This creates a PCA (Principal Component Analysis) object.
    # n_components=2 means we want to reduce our data to 2 dimensions.

    plt.figure(figsize=(20,10))
    sns.scatterplot(x=X_pca[:,0], y=X_pca[:,1], hue=clusters, palette='Set2', s=100)
    # This uses Seaborn to create a scatter plot.
    # x=X_pca[:,0] → plot the first PCA component on the x-axis.
    # y=X_pca[:,1] → plot the second PCA component on the y-axis.
    # hue=clusters → colour the points based on which cluster they belong to.
    for i, state in enumerate(df.index):
        plt.text(X_pca[i,0]+0.1, X_pca[i,1]+0.1, state, fontsize=9)
    # This adds text labels (the state names) to each point on the plot.
    # enumerate(df.index) → loops through each state and its index.
    # X_pca[i,0]+0.1, X_pca[i,1]+0.1 → places the text slightly offset from the point so it doesn’t overlap the dot.
    plt.title("K-Means Clusters on USArrests Dataset")
    plt.xlabel("PCA Component 1")
    plt.ylabel("PCA Component 2")
    plt.legend(title='Cluster')
    plt.show()

<img width="1632" height="855" alt="image" src="https://github.com/user-attachments/assets/088a4eab-a90a-481b-a582-ba6790470598" />

The PCA plot shows that the clusters are relatively well separated, indicating that the K-Means algorithm has successfully identified meaningful groupings within the data. Cluster centres are also plotted, representing the average profile of each group in the reduced space.

    # Project cluster centres to PCA space
    centers_pca = pca.transform(kmeans.cluster_centers_)
    # Plot clusters
    plt.figure(figsize=(20,10))
    sns.scatterplot(x=X_pca[:,0], y=X_pca[:,1], hue=clusters, palette='Set2', s=100)
    
    # Plot cluster centres
    plt.scatter(centers_pca[:,0], centers_pca[:,1], c='black', s=250, marker='*', label='Centers')
    
    # Annotate states
    for i, state in enumerate(df.index):
        plt.text(X_pca[i,0]+0.1, X_pca[i,1]+0.1, state, fontsize=9)
    
    plt.title("K-Means Clusters with Cluster Centers")
    plt.xlabel("PCA Component 1")
    plt.ylabel("PCA Component 2")
    plt.legend()
    plt.show()

<img width="1632" height="855" alt="image" src="https://github.com/user-attachments/assets/59ad5c92-2e8f-4405-9629-9af42cecbfc8" />

    # Inspect cluster centres (in scaled space)
    print("Cluster centers (scaled features):\n", kmeans.cluster_centers_)

    Cluster centres (scaled features):
     [[-0.49440658 -0.3864845   0.58167593 -0.26431024]
     [ 1.01513667  1.02412028  0.19959126  0.85556386]
     [-0.88515915 -1.0213324  -0.94990286 -0.92016524]]

The cluster centroids  provide insight into the characteristics of each group. Positive values indicate above-average crime levels, while negative values indicate below-average levels. 
This helps to interpret differences between clusters in terms of crime intensity and urban population.

# Hierarchical clustering

It is a method of grouping data points into clusters based on their similarity. Unlike K-Means, it does not require choosing the number of clusters in advance. 
Instead, it builds a tree-like structure called a dendrogram, where each point starts as its own cluster and similar clusters are gradually merged step by step.

A dendrogram visualises the hierarchy of clusters and helps you understand the relationships between data points and the level of similarity required to form clusters.

    from scipy.cluster.hierarchy import dendrogram, linkage, fcluster
    
    scaler = StandardScaler()
    X_scaled1 = scaler.fit_transform(df[['Murder', 'Assault', 'UrbanPop', 'Rape']])
    
    # 'ward' minimises the variance within clusters (good default)
    linkage_matrix = linkage(X_scaled1, method='ward')
    
    plt.figure(figsize=(15, 7))
    dendrogram(linkage_matrix, labels=df.index, leaf_rotation=90, leaf_font_size=10)
    plt.title("Hierarchical Clustering Dendrogram")
    plt.xlabel("States")
    plt.ylabel("Distance")
    plt.show()

<img width="1229" height="720" alt="image" src="https://github.com/user-attachments/assets/0db7481e-cfba-42e9-aa26-fb4badef132c" />

# Conclusion

Both K-Means and Hierarchical Clustering identify similar patterns in the dataset, grouping states into distinct clusters based on crime-related variables. K-Means provides a faster and more efficient approach, while hierarchical clustering offers additional interpretability through the dendrogram structure.
From a learning perspective, this analysis demonstrates a developing understanding of unsupervised machine learning, including preprocessing, clustering, and dimensionality reduction. However, interpretation is still mainly based on visual patterns, and a deeper statistical or contextual analysis would be needed to fully explain why these clusters exist.
Further improvement could include testing cluster stability, using additional validation techniques, and incorporating external socio-economic variables for stronger interpretation.
