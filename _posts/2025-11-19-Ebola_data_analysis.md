---
layout: post
title: "Ebola Data Analysis"
subtitle: "Analysis of the Kaggle's Dataset of Ebola Outbreak in Western Africa ."
categories: [Module 3, Depriching Big Data]
tags: [Python]
---
# 🦠 Ebola Outbreak Dataset Analysis

## 📂 Seminar_week5_Ebola_data

This Python project focuses on analyzing the **Ebola outbreak dataset from Kaggle**, which documents cases and deaths in Western Africa. The script begins with **data cleaning** 🧹, including handling missing values and converting date strings into datetime objects, then extracts **year** 📅 and **month** 🗓 features for time-based analysis.

Using **Pandas** 🐼, the data is aggregated to calculate **yearly totals** of confirmed, probable, and suspected cases and deaths, as well as **monthly totals for 2015** broken down by country. The analysis also computes **death rates** ⚰️, highlighting differences in the severity of outbreaks across countries.

The script employs **Seaborn** 🎨 and **Matplotlib** 📊 to create clear visualizations:

- **Bar plots** 📈 of cases and deaths by year, giving a high-level overview of epidemic trends.  
- **Line plots** 📉 showing monthly progression of cases and deaths in 2015, with separate lines for each country.  
- **Death rate trends** ⚖️ per month, revealing the impact of the epidemic over time.  
- **Country-level comparisons** 🌍 for total cases and death rates, helping identify the most affected regions.  

Additionally, **pivot tables** 🔢 summarize deaths per year and per country, providing a tabular perspective to complement the visualizations. Overall, the project demonstrates the use of **Python** 🐍 for **epidemiological data analysis**, combining data cleaning, aggregation, and visualization to understand the spread and impact of Ebola in Western Africa.
