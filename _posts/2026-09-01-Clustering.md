---
layout: post
title: "Clustering - Unit 5"
subtitle: "Module 6 – Machine Learning - Clustering"
date: 2026-09-01
categories: [Module 6 Machine Learning] 
tags: [Python]
---

# K-Means Clustering

Clustering is an unsupervised machine learning technique that partitions a dataset into distinct groups (called clusters) so observations within the same group are highly similar, while observations in different groups are clearly distinct.
Unlike supervised learning, clustering operates on unlabeled data—there is no target variable ($y$) guiding the algorithm. 
Instead, it discovers inherent patterns and structural relationships directly from the input features ($X$).

# Key Applications

- Customer Segmentation: Grouping users by purchasing behaviour, demographic profiles, or engagement levels to tailor marketing strategies.

- Anomaly & Fraud Detection: Identifying isolated data points that do not belong to any primary cluster.

- Image Segmentation & Compression: Grouping pixels with similar colour channels to simplify visual representation.

- Document & Content Categorisation: Organising large volumes of text articles or user logs based on semantic similarity.

# Types of Clustering

## 1. Exclusive (Hard) Clustering: Each observation belongs strictly to one cluster.

The cluster boundaries are crisp and mutually exclusive.

Example:

Customer $A \in \text{Cluster 1}$, Customer $B \in \text{Cluster 2}$.

Representative Algorithm: K-Means.

## 2. Overlapping (Fuzzy / Soft) Clustering where an observation can hold partial membership across multiple clusters, expressed as a set of probability distributions or degree values summing to $1$.

Example: A news article can belong to $60\%$ Sports and $40\%$ Business.

Representative Algorithm: Fuzzy C-Means (FCM), Gaussian Mixture Models (GMM).

## 3. Hierarchical Clustering, which constructs a tree-like hierarchy of nested clusters (represented via a Dendrogram). 

Does not require pre-specifying the number of clusters.

It can be Agglomerative when it starts with every point as its own cluster and recursively merging the closest pairs.

Or, Divisive (Top-Down): Starts with all points in one cluster and recursively splits them.

# The Core Concept of  Centroid

A centroid serves as the mathematical centre and geometric representative of a cluster. It is calculated as the mean position of all data points belonging to that specific cluster across all dimensions.

$$
\mathbf{\mu}_k = \frac{1}{N_k} \sum_{\mathbf{x}_i \in C_k} \mathbf{x}_i
$$

For example, if a cluster contains three points:

(10, 20)
(20, 30)
(30, 40)

the centroid is:

x = (10 + 20 + 30) / 3 = 20

y = (20 + 30 + 40) / 3 = 30

Therefore, the Centroid = (20, 30)

An algorithm such as K-means searches for $K$ centroids and point assignments that minimise the total variance within clusters.

# Key takeaway

In conclusion, **clustering** is an unsupervised learning technique used to discover natural groupings and hidden structures within unlabeled data. 

The algorithm works by measuring similarities between data points across feature space, aiming to maximise internal homogeneity while maintaining distinct boundaries between groups.

While several clustering approaches exist—ranging from soft probabilistic models like GMMs to structural dendrograms in Hierarchical clustering—the most widely used method is **K-Means**. 

It achieves efficiency by iteratively updating cluster **centroids** to minimise intra-cluster variance (WCSS). 

Understanding these different paradigms allows data scientists to select the optimal model based on data geometry, boundary constraints, and business goals.
