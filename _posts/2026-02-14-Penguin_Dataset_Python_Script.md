---
layout: post
title: "Unit 3 Data Visualisation Seminar Activity"
subtitle: "Data Visualisation of Penguin Dataset using Python"
date: 2026-02-14
categories: [Module 4 Visualising Data]
tags: [Python, Seaborn, Matplotlib]
---

## How many rows are in penguins? How many columns?

The script begins by importing the required Python libraries. pandas is imported as pd for data manipulation, numpy as np for numerical operations, matplotlib.pyplot as plt for plotting, and seaborn as sns for statistical data visualisation built on top of Matplotlib. 
The command print(sns.get_dataset_names()) lists all example datasets available within Seaborn, allowing confirmation that datasets such as “penguins”, “diamonds”, and “mpg” are accessible.

The dataset penguins is then loaded using sns.load_dataset('penguins') and assigned to the variable df. The command df.head() displays the first five rows, giving an overview of the variables and structure. 
The shape of the dataset is printed using df.shape, where df.shape[0] represents the number of rows (observations) and df.shape[1] represents the number of columns (variables). This confirms the dataset dimensions and establishes how many penguins and variables are included.

# shape

    print(f'\nthe shape of the dataset is row:{df.shape[0]} and col:{df.shape[1]}\n') 

# Data Types

    for col in df.columns:
      print(f'the column {col} has type {df[col].dtype}')
      print()

# Null values

    for col in df.columns:
        null = (df[col].isnull().sum()/len(df)).round(4) * 100 
        print(f'the column {col} has {null} % of null values')

<img width="442" height="345" alt="image" src="https://github.com/user-attachments/assets/266f1cfc-7aeb-4745-9ee9-0fb630699502" />

## What does the bill_depth_mmthe bill_depth_mm variable in the penguins data frame describe?

The next section inspects data types. A loop iterates through each column name in df.columns, printing the data type of each variable using df[col].dtype. 
This reveals which variables are numerical (such as bill measurements and body mass) and which are categorical (such as species, island, and sex). This distinction is important for determining appropriate visual encodings.

    print('Bill depth (mm) is the vertical thickness of the penguin’s bill, measured from the top to the bottom of the beak in millimetres.')

<img width="1001" height="40" alt="image" src="https://github.com/user-attachments/assets/d9f2b884-feac-46e5-a00e-5fbbe5c87fad" />

## Make a scatterplot of bill_depth_mm versus bill_length_mm. Describe the relationship between these two variables.

The following loop calculates the percentage of missing values in each column. For each variable, the number of null values is divided by the total dataset length and multiplied by 100 to obtain a percentage. This identifies data quality issues and shows that certain measurements contain missing entries. 
A bar plot of null counts is then created using sns.barplot(df.isnull().sum()), visually highlighting which variables contain missing data. The axes are rotated and labelled, and a title is added for clarity.

A scatterplot is created to examine the relationship between bill_length_mm (x-axis) and bill_depth_mm (y-axis). The variables are extracted into x and y, and sns.scatterplot() is used to visualise their relationship. 
The correlation between these two variables is calculated using df[['bill_length_mm','bill_depth_mm']].corr() and printed. The output indicates a negative correlation, suggesting that as bill length increases, bill depth tends to decrease overall when all species are combined.

    x=df['bill_length_mm']
    y = df['bill_depth_mm']

    sns.scatterplot(data=df,x=x,y=y)

    print(f'{df[['bill_length_mm','bill_depth_mm']].corr().iloc[:,0]}\n')

    print('It looks like there is no linear relationship between bill_depth and bill_length and the correlation functions shows a negative relationship.\
     When the length increases, the depth decreases.')
     
<img width="1427" height="563" alt="image" src="https://github.com/user-attachments/assets/36377818-0fa0-40c2-b611-890af72a2e93" />

## What happens if you make a scatterplot of species versus bill_depth_mm? What might be a better choice of geom?

A scatterplot of species versus bill_depth_mm is then generated. Since species is categorical, the scatterplot is not ideal for summarising central tendency. 
Therefore, a bar plot is also created using sns.barplot() to show the average bill depth per species. This representation is more appropriate for comparing grouped numerical summaries.

    sns.scatterplot(data = df, x='species',y = 'bill_depth_mm');

<img width="566" height="435" alt="image" src="https://github.com/user-attachments/assets/434c66a6-0c01-4b6a-a41c-ae057e9e0198" />

    sns.barplot(data=df,x='species',y='bill_depth_mm',edgecolor='black',color='lightblue',errorbar=None)
    plt.title('Bill lenght in different penguins species');

<img width="576" height="455" alt="image" src="https://github.com/user-attachments/assets/89006361-c6b6-41e6-815b-5ee3ab4215f8" />

## Re-create the following visualisation. What aesthetic should bill_depth_mm be mapped to? And should it be mapped at the global level or at the geom level?

Next, a regression plot is produced using sns.regplot() to model the relationship between flipper_length_mm and body_mass_g. The order=3 argument fits a third-degree polynomial curve without displaying scatter points. A second scatterplot overlays individual points and maps bill_depth_mm to colour using the hue aesthetic. 
This reveals how bill depth varies alongside flipper length and body mass, showing multidimensional encoding in one figure.

<img width="638" height="408" alt="image" src="https://github.com/user-attachments/assets/77697d96-95c0-4445-aa85-45938ee2dd93" />

    plt.figure(figsize=(10,5))

    sns.regplot(data = df,x='flipper_length_mm',y='body_mass_g',order = 3,scatter = False,color = 'red')

    sns.scatterplot(data = df,x='flipper_length_mm',y='body_mass_g',hue = 'bill_depth_mm',palette='Blues')
    plt.title('Relationship between flipper length - body mass and bill_depth')
    plt.legend(bbox_to_anchor=(1,1),title = 'bill_depth_mm');

<img width="979" height="470" alt="image" src="https://github.com/user-attachments/assets/b19f47d6-4efa-45ee-8f85-f688b93a9753" />

## Make a bar plot of species of penguins, where you assign species to the y aesthetic. How is this plot different?

A count plot is created with sns.countplot(), assigning species to the y-axis, producing a horizontal bar chart showing species frequency. This differs from vertical orientation by changing how categories are read visually. 
Two side-by-side count plots are then compared: one emphasises edge colour while the other applies fill colour. The comparison demonstrates that fill colour is generally more perceptually effective than edge colour for distinguishing categorical groups.

    sns.countplot(data = df,y = 'species',color = 'lightblue',edgecolor = 'black');

<img width="612" height="432" alt="image" src="https://github.com/user-attachments/assets/d427dff8-b316-40cd-a660-3752b4d49d44" />

# How are the following two plots different? Which aesthetic, color or fill, is more useful for changing the color of bars?

Histograms are then created to explore body mass distribution by sex. Separate histograms for males and females are overlaid with different colours and transparency. Kernel density estimates (kde=True) are added to smooth the distribution curves. Vertical lines indicate median body mass for each sex. 
The visualisation shows that male penguins tend to have higher median body mass than females, and the distribution shapes differ slightly between groups.

    fig,axis=plt.subplots(1,2,figsize=(10,5))
    sns.countplot(data = df,x='species',edgecolor = 'red',ax=axis[0])
    sns.countplot(data = df,x='species',color = 'red',ax=axis[1])
    plt.tight_layout();

    print('the second chart is the one with the mst effective color application')

<img width="989" height="490" alt="image" src="https://github.com/user-attachments/assets/269a040d-bd0b-43b7-aa0b-e974a8adbf90" />

    sns.histplot(data=df[df['sex']=='Male'],x='body_mass_g',bins=100,color='orange',alpha = 0.5,kde=True)
    sns.histplot(data=df[df['sex']=='Female'],x='body_mass_g',bins=100,color='blue',kde=True)
    plt.axvline(x=df[df['sex']=='Male']['body_mass_g'].median(),color='green',linestyle='--',linewidth=3,label = 'male median body mass')
    plt.axvline(x=df[df['sex']=='Female']['body_mass_g'].median(),color='purple',linestyle='--',linewidth=3,label = 'female median body mass')
    plt.legend();

<img width="554" height="433" alt="image" src="https://github.com/user-attachments/assets/75c9f163-a5c2-49bf-af6d-a11f6b44ed08" />

## Make a histogram of the carat variable in the diamonds dataset that is available when you load the tidyverse package. Experiment with different binwidth values. What value reveals the most interesting patterns?

The diamonds dataset is loaded to examine the carat variable. Two histograms are plotted with different bin settings. One uses 50 bins, and another uses 500 bins with a smaller binwidth. 
Reducing binwidth reveals more detailed structure in the distribution, showing that carat values cluster below 3 and display peaks at common commercial sizes. This demonstrates how bin choice influences pattern visibility. 

    df1=sns.load_dataset('diamonds')
    fig,axis=plt.subplots(1,2,figsize=(10,5))
    sns.histplot(data=df1,x='carat',bins=50,binwidth=1,label='histogram of diamonds carat with 50 bins',ax=axis[0])
    sns.histplot(data=df1,x='carat',bins=500,binwidth=0.3,label='histogram of diamonds carat with 500 bins',ax=axis[1])
    plt.tight_layout();

    print('Reducing the binwidth is possible to appreciate all the differencies in carat as this parameter doesn\'t go over 3.')

<img width="990" height="490" alt="image" src="https://github.com/user-attachments/assets/6522bb26-38cd-42ef-857f-9262efe8f6dc" />

## The mpg data frame that is bundled with the ggplot2 package contains 234 observations collected by the US Environmental Protection Agency on 38 car models. Which variables in mpg are categorical? Which variables are numerical?

The mpg dataset is then loaded, and a loop prints each column’s data type. This distinguishes categorical variables (such as origin) from numerical variables (such as horsepower and displacement).

    df3=sns.load_dataset('mpg')

    for col in df3.columns:
        print(f'The column {col} is a {df3[col].dtype}')for col in df3.columns:
        print(f'The column {col} is a {df3[col].dtype}')
        
    The column mpg is a float64
    The column cylinders is a int64
    The column displacement is a float64
    The column horsepower is a float64
    The column weight is a int64
    The column acceleration is a float64
    The column model_year is a int64
    The column origin is a object
    The column name is a object

## Make a scatterplot of hwy versus displ using the mpg data frame. Next, map a third, numerical variable to color, then size, then both color and size, and then shape. How do these aesthetics behave differently for categorical versus numerical variables?

Scatterplots are created to examine the relationship between horsepower and displacement. Initially, a simple scatterplot shows their positive relationship. Colour is then mapped to mpg, introducing a third numerical dimension. 
Size is subsequently mapped to mpg, scaling point size based on fuel efficiency. Finally, shape (style) is mapped to origin, introducing a categorical aesthetic.
These variations illustrate how colour and size can encode numerical variables continuously, whereas shape is more suited to categorical differentiation.

create a scatterplot

    sns.scatterplot(data=df3,x='horsepower',y = 'displacement')
    plt.title( 'Hp v Displacement')

<img width="571" height="455" alt="image" src="https://github.com/user-attachments/assets/47cc859f-e347-4b7f-8a1d-b1efb52cd046" />

    sns.scatterplot(data=df3,x='horsepower',y = 'displacement',hue = 'mpg',palette='BrBG')
    plt.title( 'Hp v Displacement v mpg')

<img width="571" height="455" alt="image" src="https://github.com/user-attachments/assets/29502657-3d6e-4edb-be07-f9f4dd542a7f" />

    sns.scatterplot(data=df3,x='horsepower',y = 'displacement',hue = 'mpg',palette='BrBG',size = 'mpg',sizes=(20,200),alpha=0.5)

<img width="571" height="432" alt="image" src="https://github.com/user-attachments/assets/5a42517a-6dfb-4a5a-a514-3f285c28c201" />

    sns.scatterplot(data=df3,x='horsepower',y = 'displacement',hue = 'mpg',palette='BrBG',size = 'mpg',sizes=(20,200),alpha=0.5,style = 'origin')

<img width="571" height="432" alt="image" src="https://github.com/user-attachments/assets/99dc35d3-b179-48b4-a322-f2b11f20feab" />

## In the scatterplot of hwy versus displ, what happens if you map a third variable to linewidth?

A line plot is added to show weight versus horsepower, demonstrating how linewidth applies differently to lines compared to scatter points. This highlights that linewidth is meaningful for line geometries but not ideal for encoding additional variables in scatterplots.

    sns.scatterplot(data=df3,x='horsepower',y = 'displacement',hue = 'mpg',palette='BrBG',size = 'mpg',sizes=(20,200),alpha=0.5,style = 'origin')
    sns.lineplot(data = df3,x='horsepower',y='weight',linestyle='--',color='r')

<img width="580" height="432" alt="image" src="https://github.com/user-attachments/assets/d9d1961c-1ea3-4d4c-ad06-3c97aa79693b" />

## Make a scatterplot of bill_depth_mm versus bill_length_mm and colour the points by species. What does adding colouring by species reveal about the relationship between these two variables? What about faceting by species?

Another scatterplot of bill_depth_mm versus bill_length_mm is created, this time colouring points by species and styling by island. Adding colour reveals that within individual species, the relationship is generally positive, even though the overall combined dataset showed a negative correlation. 
This indicates Simpson’s paradox, where aggregated data obscures subgroup trends. Faceting or separating by species would make this pattern even clearer.

    sns.scatterplot(data=df, x='bill_depth_mm',y='bill_length_mm',hue='species',style='island')
    plt.legend(bbox_to_anchor=(1,1));

    print('in each species the relationship between bill length and depth is positive highlighting the fact that an higher depth is always followed by a larger length. Adding the shape based on islands we can see how Adelie are located in any of the 3 islands')

<img width="687" height="433" alt="image" src="https://github.com/user-attachments/assets/bcd4ff04-cb2d-4913-9cd5-4b486f413413" />

## Create the two following stacked bar plots. Which question can you answer with the first one? Which question can you answer with the second one?

Finally, stacked bar plots are created using a cross-tabulation of island and species. pd.crosstab() computes the counts of each species per island, and .plot(kind='bar', stacked=True) visualises this distribution. 
The resulting plot shows that Torgersen island contains only Adelie penguins, while other species are restricted to specific islands. This answers questions about species distribution across geographical locations.

    new_df=df.groupby(['island'])[['species']].count().reset_index()
    new_df=pd.crosstab(index=df['island'],columns=df['species'])
    new_df

<img width="285" height="137" alt="image" src="https://github.com/user-attachments/assets/8007df3a-bbff-484a-b465-efecb38d3a93" />

    new_df.plot(kind='bar',stacked=True)

    print('The island of Torgersen is populated only by Adelie and we can find this species distributed in each island while the others are located only in 1 of the 3')

<img width="552" height="486" alt="image" src="https://github.com/user-attachments/assets/a253be6b-7185-4bbc-ac69-13180a02a33c" />

# Conclusions

Overall, the script demonstrates exploratory data analysis through data inspection, correlation analysis, and a variety of visual encodings. It shows how different aesthetic mappings influence interpretation and reveals meaningful biological patterns, such as species differences in morphology, sex differences in body mass, and geographic distribution of penguin species.

From a reflective standpoint, working with Python for these analyses highlighted key differences compared to R. Python’s syntax is generally extremely efficient and concise, allowing many operations to be performed with fewer lines of code. However, there are cases where it can feel less intuitive than R. 
For example, creating a scatterplot with a regression line in Python often requires layering multiple charts here, one for the regression and one for the points whereas in R, functions like geom_point() and geom_smooth() allow both elements to be created in a single command. Despite this, Python’s outputs tend to be more compact and less verbose, which makes scripts easier to read and maintain. 
Overall, while R can offer more “all-in-one” plotting convenience, Python provides a streamlined, flexible, and programmatically efficient workflow that supports both analysis and reproducible visualisation.

