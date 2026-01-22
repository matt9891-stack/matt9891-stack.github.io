---
layout: post
title: "Data Normalisation Process"
subtitle: "Overview of the Data Normalisation Process"
categories: [Module 3, Depriching Big Data]
tags: [Python]
---
# Overview of the Data Normalisation Process

[GitHub Repository](https://github.com/matt9891-stack/Data_Normalisation_excercise.git)

🔍 Initial Structure

The original dataset was stored in one large table combining student information, course details, teachers, exam boards and exam scores. This design led to extensive duplication: each student’s personal information appeared multiple times, and each course’s information was repeated for every student enrolled. Such redundancy indicated that the table was not normalised.

🗝️ Identifying the Key

A single attribute could not uniquely identify each row, so the effective primary key was recognised as the combination of Student Number and Course Name. This composite key became the basis for assessing functional dependencies.

🧩 First Normal Form (1NF)

The dataset met the requirements of First Normal Form because all values were atomic and no repeating groups were present. Each field held a single, indivisible piece of information.

🧠 Second Normal Form (2NF)

Second Normal Form requires the removal of partial dependencies. The original table contained partial dependencies because several non-key attributes depended on only part of the composite key:

Student attributes such as name, date of birth and support status depended solely on Student Number.

Course-related attributes such as exam board and teacher name depended solely on Course Name.

To satisfy 2NF, the data was decomposed into separate tables so that each set of attributes depended entirely on a single key.

🗂️ Creating the Normalised Tables

Three relations were created to remove partial dependencies:

📘 Students

Key: Student Number
Attributes such as Student Name, Date of Birth and Support depend fully on this key.

📗 Courses

Key: Course Name
Attributes such as Exam Board and Teacher Name depend entirely on the course identity.

📙 StudentCourseScores

Composite key: Student Number + Course Name
The Exam Score depends on both parts of the key, representing the relationship between students and the courses they take.

🎯 Third Normal Form (3NF)

After decomposition, each relation was checked for transitive dependencies. Third Normal Form requires that non-key attributes depend only on the key and not on other non-key attributes.
All three tables satisfy this requirement:

In Students, all attributes depend solely on Student Number.

In Courses, all attributes depend solely on Course Name.

In StudentCourseScores, the only non-key attribute is Exam Score, which depends only on the composite key.

✅ Final Outcome

Through this process, the dataset was fully normalised up to Third Normal Form, reducing redundancy, preventing update anomalies and ensuring logically structured data that reflects clear functional dependencies.
