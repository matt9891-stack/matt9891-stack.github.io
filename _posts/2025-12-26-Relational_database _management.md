---
layout: post
title: "Database Management"
subtitle: "This project demonstrates end-to-end data analysis using the UNICEF Child Labour dataset. It covers data wrangling, exploratory analysis, and integration with PostgreSQL, where a relational database is created and populated using psycopg2"
categories: [Module 3, Depriching Big Data]
tags: [Python, SQL]
---
# Database Management

# Seminar_week9_Database_management

[GitHub Repository](https://github.com/matt9891-stack/Data_Wrangling_DBMS.git)

📊 Analysis of Child Labour Worldwide

This project aims to analyse child labour data across countries and regions, highlighting how percentages have changed over time and how they vary geographically.

1️⃣ Data Import and Preparation

📥 Imported dataset from an Excel file with multiple sheets, specifically the "Child labour" sheet.

🧹 Data cleaning steps included:

Removing non-significant rows and columns.

Renaming columns clearly (e.g., Total_pct, Sex_pct_Male, Household_wealth_quintile_Poorest).

Handling missing values and replacing dashes - with NaN.

🔹 Example: Only the first 109 rows were kept to remove empty or summary rows, and indices were reset for an organised dataset.

2️⃣ Adding Geographic Regions 🌍

A new Region column was created, grouping countries into macro-areas:

West Europe, Central Europe, East Europe

Balkans, Eurasia, Middle East

North Africa, Central Africa, Southern Africa

Central Asia, South East Asia, South America, etc.

This allowed regional analysis of child labour, highlighting trends across continents.

3️⃣ Handling Reference Years 🗓️

The Reference_Year column had inconsistent formats (2008/2009, 2007-2008).

🔧 Extracted only the starting year and converted it to numeric format for temporal analysis.

4️⃣ Exploratory Data Analysis 🔍

📊 Checked missing values and visualised gaps in the dataset.

🔢 Converted relevant columns from strings to numeric values for analysis.

Analyses performed:

Global trend over time: Bar charts showed how total child labour percentages evolved.

Regional analysis:

South America and South Asia had notably high percentages in 2008.

Gender analysis:

Transformed data into long format to compare male vs female percentages.

Boxplots highlighted distribution differences between genders.

5️⃣ PostgreSQL Database Connection 🐘

💾 Created database: Using psycopg2, a database called seminar was created.

🏗️ Created table: Defined a child_labour table containing all cleaned columns.

🔗 Inserted data: Used SQLAlchemy to upload the cleaned dataset to PostgreSQL, ready for querying and dashboards.

💡 Ensures the dataset is centralised, clean, and scalable, ideal for further analysis.

6️⃣ Key Findings 🌟

📈 Child labour percentages vary across regions and over time.

🔹 In 2008, South America and South Asia had particularly high percentages.

⚖️ Gender differences were observed, allowing analysis of male vs female child labour.

7️⃣ Conclusion ✅

This project demonstrates:

🧹 Cleaning and standardising complex Excel datasets.

🌍 Adding geographic and temporal information for in-depth analysis.

🐘 Connecting to a PostgreSQL database for secure storage and scalable data analysis.
