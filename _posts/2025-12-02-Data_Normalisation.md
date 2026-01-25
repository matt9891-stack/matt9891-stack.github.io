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

## Normalisation Process - it involves the organisation of data into specific table structures, improving data integrity and minimising data redundancies (Gomstyn and Jonker, 2025).

## First Normal Form (1NF) - it involves ensuring that each table has a primary key and each column is stored in an atomic value.

In order to analyse the dependencies within the dataset, it was first necessary to identify a suitable primary key. No single attribute was capable of uniquely identifying each record. Instead, uniqueness was achieved through a combination of Student Number and Course Name, which together formed a composite key. This composite key provided the foundation for assessing how the remaining attributes depended on the identifying fields.

<img width="868" height="791" alt="image" src="https://github.com/user-attachments/assets/9ebc4686-23f4-4372-8adf-c4408e99e4bd" />

## Second Normal Form (2NF)

However, the table failed to satisfy Second Normal Form (2NF) due to the presence of partial dependencies. Several non-key attributes depended on only part of the composite key rather than on the full key. Student-related attributes such as name, date of birth, and support status were dependent solely on the Student Number. Similarly, course-related attributes, including exam board and teacher name, depended only on the Course Name. These partial dependencies violated 2NF and necessitated a decomposition of the original table.

To resolve this issue, the dataset was divided into three separate relations, each designed so that all non-key attributes depended entirely on a single key. A Students table was created using Student Number as the primary key, with attributes such as student name, date of birth, and support status fully dependent on that identifier. A Courses table was introduced with Course Name as the primary key, containing attributes such as exam board and teacher name that describe the course itself. Finally, a junction table named StudentCourseScores was created to represent the many-to-many relationship between students and courses. This table used a composite key consisting of Student Number and Course Name, with Exam Score as an attribute dependent on both components of the key.

<img width="889" height="752" alt="image" src="https://github.com/user-attachments/assets/ddb84729-80a2-4867-a5c3-faf447370d3b" />

<img width="879" height="524" alt="image" src="https://github.com/user-attachments/assets/3eb37667-f385-406e-a02a-f9359a441425" />

<img width="879" height="536" alt="image" src="https://github.com/user-attachments/assets/f08ee0ed-b6a0-4a57-9ea1-1e51e3593513" />

## Third Normal Form (3NF)

Following this decomposition, the resulting tables were evaluated against the requirements of Third Normal Form (3NF). Each relation was examined to ensure that no transitive dependencies were present and that all non-key attributes depended only on the primary key. The Students table satisfied this condition, as all attributes were directly dependent on Student Number. The Courses table also met the criteria, with all attributes dependent solely on Course Name. In the StudentCourseScores table, the only non-key attribute was Exam Score, which depended exclusively on the composite key and not on any other non-key attributes.

Through this systematic normalisation process, the dataset was successfully transformed into a structure that conforms to Third Normal Form. The final design significantly reduces redundancy, eliminates update anomalies, and enforces clear functional dependencies. As a result, the database is more efficient, logically organised, and better suited for reliable data maintenance and future expansion.

# References

Gomstyn, A. and Jonker, A. (2025). Database normalisation. [online] Ibm.com. Available at: https://www.ibm.com/think/topics/database-normalization (Accessed 02 December 2025).
