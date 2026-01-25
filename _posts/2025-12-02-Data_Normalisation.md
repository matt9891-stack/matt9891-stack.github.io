---
layout: post
title: "Data Normalisation Process"
subtitle: "Overview of the Data Normalisation Process"
categories: [Module 3 Deciphering Big Data]
tags: [Python]
---
# Overview of the Data Normalisation Process

[GitHub Repository](https://github.com/matt9891-stack/Data_Normalisation_excercise.git)

[Notebook](https://github.com/matt9891-stack/Data_Normalisation_excercise/blob/main/Normalisation.ipynb)

## Initial Structure

The original dataset was kept in a single, large table that incorporated student details, course information, teacher assignments, exam boards, and examination results, allowing, on one side, all relevant information to be accessed in one place, but, as a consequence, it resulted in redundancy and potential inconsistencies. 

<img width="891" height="334" alt="image" src="https://github.com/user-attachments/assets/b85a9bb5-ec63-4143-8c45-07890700a1ac" />

**Normalisation Process** - it involves the organisation of data into specific table structures, improving data integrity and minimising data redundancies (Gomstyn and Jonker, 2025).

**First Normal Form (1NF)** - it involves ensuring that each table has a primary key and each column is stored in an atomic value (Nguyen, 2023).

In order to analyse the dependencies within the dataset, it was first necessary to identify a suitable primary key. No single attribute was capable of uniquely identifying each record. Instead, uniqueness was achieved through a combination of Student Number and Course Name, which together formed a composite key. This composite key provided the foundation for assessing how the remaining attributes depended on the identifying fields.

<img width="868" height="791" alt="image" src="https://github.com/user-attachments/assets/9ebc4686-23f4-4372-8adf-c4408e99e4bd" />

<img width="874" height="461" alt="image" src="https://github.com/user-attachments/assets/9bab2770-0907-4333-82f1-0b60bc6e6b35" />

**Second Normal Form (2NF)** - it involves the condition that each column is dependent on the key column (Nguyen, 2023).

The table failed to satisfy Second Normal Form (2NF) due to the presence of partial dependencies; for instance, student attributes such as name, date of birth, and support status were dependent solely on the Student Number. These partial dependencies could be rectified by a decomposition of the original table.

To resolve this issue, the dataset was divided into three separate relations, each designed so that all non-key attributes depended entirely on a single key. A student's table was created using Student Number as the primary key, with attributes such as student name, date of birth, and support status fully dependent on that identifier. A Courses table was introduced with Course Name as the primary key, containing attributes such as exam board and teacher name that describe the course itself. Finally, a junction table named StudentCourseScores was created to represent the many-to-many relationship between students and courses. This table used a composite key consisting of Student Number and Course Name, with Exam Score as an attribute dependent on both components of the key.

<img width="427" height="191" alt="image" src="https://github.com/user-attachments/assets/4a81ce55-40ca-447e-a9fb-fb81b72079dd" />

<img width="418" height="206" alt="image" src="https://github.com/user-attachments/assets/8bb3667e-c3ee-468d-8159-e7029378aebf" />

<img width="447" height="427" alt="image" src="https://github.com/user-attachments/assets/20728b15-9877-4bd3-867c-d5a0e6f6188d" />

**Third Normal Form (3NF)** - it requires no transitive dependencies between columns of the table (Nguyen, 2023).

Following this decomposition, the resulting tables were evaluated against the requirements of Third Normal Form (3NF). The Students table satisfied this condition, as all attributes were directly dependent on Student Number. The Courses table also met the criteria, with all attributes dependent solely on Course Name.

Through this  process, the dataset was successfully transformed into a structure that conforms to Third Normal Form. The final design significantly reduces redundancy, eliminates update anomalies, and enforces clear functional dependencies. As a result, the database is more efficient, logically organised, and better suited for r data maintenance and expansion.

<img width="1414" height="566" alt="image" src="https://github.com/user-attachments/assets/d9037910-3a1d-4810-b3e5-83b9b3572fce" />

# References

Gomstyn, A. and Jonker, A. (2025). Database normalisation. [online] Ibm.com. Available at: https://www.ibm.com/think/topics/database-normalization (Accessed 02 December 2025).

Nguyen, L. (2023). A Brief Guide to Database Normalization. [online] Medium. Available at: https://medium.com/@ndleah/a-brief-guide-to-database-normalization-5ac59f093161 (Accessed 02 December 2025).
