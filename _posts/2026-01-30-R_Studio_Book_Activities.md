---
layout: post
title: "R_Studio Visualisation"
subtitle: "Visualisation Exercises of the Penguins Dataset "
date: 2026-01-30
categories: [Module 4 Visualising Data]
tag: [R, ggplot]
---
[Notebook](https://github.com/matt9891-stack/Data_Visualisation_Penguins/blob/main/Book%20Excercises.R)

# Data_Visualisation_Penguins
R_Studio_Script _on_Penguins_Dataset

This activity explored fundamental and intermediate data‑visualisation techniques in R using ggplot2, with a focus on understanding how aesthetics, geoms, and faceting influence the interpretation of multivariate data. Two datasets were used: penguins from the palmerpenguins package and mpg/diamonds from ggplot2. The aim was to develop both technical fluency and analytical reasoning when interpreting graphical output.

## 1. Understanding the Data
We began by inspecting the penguins dataset using functions such as glimpse(), nrow(), and help().
This revealed:
- 344 observations and 8 variables
- A mix of numerical and categorical variables
- bill_depth_mm describes the vertical height of the penguin’s bill in millimetres
This initial exploration established the foundation for later visual analysis.

<img width="1025" height="187" alt="image" src="https://github.com/user-attachments/assets/88e7f91c-a1cb-47c5-af08-e378292d173f" />

----------------------------------------------------------------------------------
## 2. Scatterplots and Relationships Between Variables
A scatterplot of bill_length_mm vs bill_depth_mm showed:
- No strong linear relationship
- A slight negative trend when all species are combined
- Considerable variation driven by species differences
When colour was mapped to species, three distinct clusters emerged. This demonstrated that species identity is a major driver of morphological variation.
Faceting by species (facet_wrap(~ species)) further clarified:
- Each species has its own internal pattern
- The overall negative trend disappears when species are separated
- Species‑specific morphology explains the apparent global relationship
This highlighted the importance of grouping variables in multivariate analysis.

<img width="826" height="546" alt="image" src="https://github.com/user-attachments/assets/51ab7967-e473-4984-8991-765f8a117e2b" />  <img width="826" height="546" alt="image" src="https://github.com/user-attachments/assets/ad02a652-1a7c-42a1-b471-d43015b9fe54" />

----------------------------------------------------------------------------------
## 3. Appropriate Geoms for Different Variable Types
Plotting species vs bill_depth_mm using points illustrated why scatterplots are unsuitable for categorical x‑axes.
A bar plot or boxplot provides a clearer summary of distributions when dealing with categorical variables.

<img width="826" height="546" alt="image" src="https://github.com/user-attachments/assets/ebae74a7-60ad-49f5-bd58-8fed74828817" />

----------------------------------------------------------------------------------
## 4. Handling Missing Data
Using na.rm = TRUE in geom_point() removed missing values silently.
The default (FALSE) produces warnings.
This reinforced the importance of handling NA values explicitly in visualisation workflows.
----------------------------------------------------------------------------------
## 5. Using labs() to Improve Readability
The labs() function was used to add:
- Titles
- Subtitles
- Axis labels
- Captions
- Legend titles
This improved the clarity and professionalism of the plots, demonstrating good practice for reporting.

<img width="826" height="546" alt="image" src="https://github.com/user-attachments/assets/6a2023c1-b60d-4708-88b2-ce1accf64484" />

----------------------------------------------------------------------------------
## 6. Mapping Variables to Aesthetics
We explored how different aesthetics behave:
- Colour: works well for categorical or numerical variables
- Size: best for numerical variables
- Shape: only suitable for categorical variables
- Linewidth: has no effect on points, as geom_point() does not use line thickness
Mapping the same variable to multiple aesthetics (e.g., colour + size + shape) reinforces the same information through multiple visual channels.

<img width="826" height="546" alt="image" src="https://github.com/user-attachments/assets/de1100fb-4a2f-4b17-83d7-b73c383a1ecc" />

----------------------------------------------------------------------------------
## 7. Histograms and Binwidth
Using the diamonds dataset, experimenting with different binwidth values showed:
- Large binwidths oversimplify the distribution
- Smaller binwidths reveal more structure and multimodality
This demonstrated how binwidth selection affects the interpretability of histograms.

<img width="826" height="546" alt="image" src="https://github.com/user-attachments/assets/a7bcf3c5-88b3-4bbc-81f9-cc7bd4f70d5e" />

----------------------------------------------------------------------------------
## 8. Stacked Bar Plots and Interpretation
Two stacked bar plots were created:
- island (x) filled by species
- Answers: What proportion of each species is found on each island?
- species (x) filled by island
- Answers: How are penguins of each species distributed across islands?
Although visually similar, the interpretation differs depending on which variable is placed on the x‑axis.

<img width="826" height="546" alt="image" src="https://github.com/user-attachments/assets/82e67324-9927-443f-8d58-b193bf306296" />


# Final Findings

Across the activity, several key insights emerged:

### **Visualisation choices strongly influence interpretation:**

Colouring and faceting revealed species‑specific patterns that were hidden in the combined scatterplot.

### **Understanding variable types is essential:**

Numerical vs categorical variables require different geoms and aesthetics.

### **Aesthetic mappings are powerful:**

They allow multidimensional relationships to be visualised in a single plot.

### **Good practice matters:**

Clear labels, captions, and thoughtful handling of missing data improve the quality of analysis.

### **Exploratory data visualisation is iterative:**

Adjusting binwidths, aesthetics, and geoms helps uncover meaningful patterns.
