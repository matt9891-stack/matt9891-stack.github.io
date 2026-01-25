---
layout: post
title: "Ebola Data Analysis"
subtitle: "Analysis of the Kaggle's Dataset of Ebola Outbreak in Western Africa ."
categories: [Module 3 Deciphering Big Data]
tags: [Python]
---
#  Ebola Outbreak Dataset Analysis
 
[GitHub Repository](https://github.com/matt9891-stack/Seminar_week5_Ebola_data)  
[Notebook](https://github.com/matt9891-stack/Seminar_week5_Ebola_data/blob/main/Seminar_activity.ipynb)

This Python project focuses on analysing the **Ebola outbreak dataset**, which shows cases and deaths in Western Africa. The script begins with **data cleaning**, including handling missing values and converting date strings into datetime objects, then extracts **year**  and **month**  for time‑based analysis.

<img width="913" height="106" alt="image" src="https://github.com/user-attachments/assets/b3d6fc18-2378-4b6c-b4b7-57e3a3a55c68" />

<img width="875" height="433" alt="image" src="https://github.com/user-attachments/assets/251c3444-bdfa-4784-8f87-c17a9dd9ed6a" />

Using **Pandas**, the data is aggregated to calculate **yearly totals** of confirmed, probable, and suspected cases and deaths, as well as **monthly totals for 2015** broken down by country. The analysis also shows **death rates** , highlighting differences in the severity of outbreaks between countries.

The script employs **Seaborn**  and **Matplotlib**  to create clear visualizations:

**Bar plots**  of cases and deaths by year, giving an overview of epidemic trends.

<img width="818" height="462" alt="image" src="https://github.com/user-attachments/assets/915afc60-db0d-4330-98ef-3111436f9a4b" />

<img width="807" height="529" alt="image" src="https://github.com/user-attachments/assets/3e44d56a-2bc3-44c1-b446-7aa091e35db5" />

**Line plots**  showing the monthly progression of cases and deaths in 2015, with separate lines for each country.

<img width="881" height="774" alt="image" src="https://github.com/user-attachments/assets/c8dd415e-20ba-44bf-97f6-768bfb2636b4" />

**Death rate trends**  per month, showing the impact of the epidemic over time.  
**Country‑level comparisons**  for total cases and death rates, helping identify the most affected regions.

  <img width="817" height="482" alt="image" src="https://github.com/user-attachments/assets/88b24840-56e4-49aa-b53f-ef3f910fe544" />


 Overall, the project demonstrates the use of **Python**  for **epidemiological data analysis**, combining data cleaning, aggregation, and visualisation to understand the spread and impact of Ebola in Western Africa.


