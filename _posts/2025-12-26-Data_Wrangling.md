---
layout: post
title: "Database Management"
subtitle: "This project placed a strong emphasis on data wrangling of the original UNICEF child labour dataset."
categories: [Module 3 Deciphering Big Data]
tags: [Python, SQL]
---

[Notebook](https://github.com/matt9891-stack/Data_Wrangling_DBMS/blob/main/DBMS_seminar.ipynb)

The file contained multiple worksheets, non-standard headers, and several non-informative rows, making it unsuitable for direct analysis. As a first step, the Excel file was programmatically inspected to identify the relevant worksheet containing child labour indicators, which was then loaded into a pandas DataFrame for further processing.

<img width="887" height="634" alt="image" src="https://github.com/user-attachments/assets/6609740e-4d7f-485c-9d39-00c8a62aa1ec" />

Once imported, the dataset required substantial cleaning. The initial rows contained metadata and irregular header information rather than actual observations, so these rows were removed and the index was reset to restore a consistent tabular structure. Additional filtering was applied to retain only rows corresponding to valid country-level observations. This step ensured that the dataset contained meaningful and comparable entries across all records.

Column names in the raw dataset were either missing, ambiguous, or inconsistent. To address this, all columns were systematically renamed using clear and descriptive labels. This improved readability and ensured that each variable could be easily interpreted in later stages of the analysis, particularly when working with demographic, geographic, and socio-economic indicators.

<img width="893" height="470" alt="image" src="https://github.com/user-attachments/assets/e0add8a9-5d1c-4a1b-9bd8-844212e10ed0" />

Further data transformation was required to standardise key variables. Reference years were stored using inconsistent formats, such as ranges or combined year values. These entries were normalised by extracting a single reference year, enabling temporal comparisons across countries. In addition, missing values were originally represented using placeholder symbols rather than standard null values. These placeholders were replaced with proper missing-value indicators, and relevant columns were converted to numeric data types to ensure compatibility with statistical operations.

<img width="898" height="686" alt="image" src="https://github.com/user-attachments/assets/3462584c-3217-4026-ae6c-2e6abd7d4ca7" />

To support regional analysis, an additional variable was created by mapping each country to its corresponding geographic region using a predefined lookup structure. This transformation enriched the dataset and enabled grouping and aggregation at a regional level without altering the original country-level data.

<img width="871" height="532" alt="image" src="https://github.com/user-attachments/assets/2872ef9b-21f4-4ffa-bd03-3e83b256a4a6" />

<img width="883" height="526" alt="image" src="https://github.com/user-attachments/assets/f136674c-9693-4746-b69e-bc42c0ae9cd4" />

Through this data wrangling process, the dataset was transformed from a messy, semi-structured Excel file into a clean, consistent, and analysis-ready table. The final result provided a reliable foundation for exploratory analysis, visualisation, and database integration, while also demonstrating practical skills in handling real-world data imperfections.
