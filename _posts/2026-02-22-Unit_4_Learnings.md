---
layout: post
title: "Unit 4 Data Visualisation Learnings Activity"
subtitle: "Data Visualisation of Mpg Dataset using Python"
date: 2026-02-22
categories: [Module 4 Visualising Data]
tags: [Python, Seaborn, Matplotlib]
---


# Critical Reflection on the Use of R (ggplot2) and Python (Seaborn & Matplotlib) in Data Visualisation

Throughout this module, I have had the opportunity to work with both Python visualisation libraries (Seaborn and Matplotlib) and R’s ggplot2.
Prior to this unit, I already had experience using Python, particularly Seaborn and Matplotlib, for exploratory data analysis and visualisation tasks. 
This previous experience made it easier for me to engage with the visualisation component of the course.
Concepts such as scatterplots, regression lines, histograms and boxplots were already familiar, and I felt confident working with Python’s general syntax and programming structure.
However, R, and specifically ggplot2, was a new tool for me. 
Although I used it consistently throughout previous units and completed the recommended book exercises, I initially faced some conceptual and syntactical challenges. 
Despite some similarities between Python and R, especially in data manipulation workflows, the grammar-of-graphics approach used in ggplot2 required a different way of thinking. 
Understanding the layered structure of aesthetic mappings, geoms and statistical transformations took time and practice to grasp fully.
As the module progressed, I began to recognise and appreciate the strengths of ggplot2, particularly its readability and compact syntax. 
Compared to Matplotlib and Seaborn, ggplot2 often allows more complex visualisations to be created more clearly and concisely. 
Its declarative style — where the user specifies what should be plotted rather than the step-by-step process of how to plot it makes the code feel more structured and expressive once the underlying grammar is understood.

A clear example of this difference can be seen when plotting a scatterplot with a regression line. In R using ggplot2, this can be achieved by layering geom_point() and geom_smooth() within the same plotting object:

<img width="921" height="168" alt="image" src="https://github.com/user-attachments/assets/47ad4799-4fb9-428f-babf-638101b27071" />

This approach is concise and logically organised. The regression line is added as an additional layer and automatically follows the same aesthetic mappings. The syntax clearly reflects the purpose of the visualisation.
In contrast, achieving a similar result in Python using Seaborn and Matplotlib often involves more procedural steps. A common method is to first create the scatterplot and then overlay a regression plot, while suppressing duplicated elements:

<img width="940" height="634" alt="image" src="https://github.com/user-attachments/assets/da716232-f7f2-4a8b-a711-18e3dc3fa4ef" />

In this case, the regression line is generated through a separate function call (regplot), and the scatter element must be explicitly removed (scatter=False) to avoid duplication. 
While this approach works effectively, it introduces a degree of redundancy and requires additional lines of code. The process feels more sequential and less integrated compared to ggplot2’s layered structure.
From a critical perspective, Matplotlib offers a high level of flexibility and detailed control, which is particularly useful for highly customised visualisations. However, this flexibility can also lead to more verbose and complex code. 
Seaborn improves the visual quality and simplifies many statistical plots, but it still relies on Matplotlib’s underlying framework, which can require extra configuration in certain situations.
In comparison, ggplot2 promotes a structured and theory-based approach to visualisation through the grammar of graphics. Once understood, this framework supports clarity, reduces repetition and improves readability.
During the unit, I noticed that tasks which required several lines of adjustment in Python could often be achieved more efficiently in R.
Nevertheless, my stronger background in Python still makes it feel more natural to use. R remains a developing skill for me, and some aspects, such as interpreting default statistical transformations and understanding aesthetic inheritance, continue to present occasional difficulties.
This experience has highlighted how familiarity with a programming language strongly shapes perceptions of ease and usability.

In conclusion, this module has enabled me to make a meaningful comparison between the two ecosystems.
My prior experience with Seaborn and Matplotlib allowed me to work confidently and efficiently from the outset. 
At the same time, learning ggplot2 has expanded my understanding of data visualisation and introduced me to a more structured and compact coding style.
Despite the initial challenges, I now recognise the advantages of R’s readability and conceptual clarity. 
Developing further confidence in ggplot2 will strengthen my analytical versatility and allow me to choose the most appropriate tool depending on the context of the task.

