---
layout: post
title: "Web Scraping Script"
subtitle: "An end-to-end Python web scraping workflow extracting job titles, companies, locations, and salaries from online job portals."
categories: [Module 3, Depriching Big Data]
tags: [Python]
---

# Web_Scraping

🧠 Job Scraper for Data Scientist Roles in the UK

This Python script automates the extraction of job listings for Data Scientist positions from TotalJobs UK. It collects key information such as job titles, company names, locations, and salary details, and saves the results in a structured JSON file for further analysis or integration.

📌 Features
- Scrapes job listings from a specified TotalJobs URL
- Extracts:
- Job titles (h2 elements)
  
- Company names (data-at="job-item-company-name")
- Locations (data-at="job-item-location")
- Salary information (data-at="job-item-salary-info")
- Stores the data in a clean JSON format (job_offers.json)
- Uses requests and BeautifulSoup for efficient HTML parsing
🛠️ Requirements
Make sure you have the following Python libraries installed:

<img width="504" height="92" alt="image" src="https://github.com/user-attachments/assets/bc65800b-38e8-4102-9fa6-05ed687fba27" />

🚀 How It Works
- Sends an HTTP GET request to the TotalJobs search results page for Data Scientist roles in the UK.
- Parses the HTML content using BeautifulSoup.
- Extracts relevant job data using CSS selectors and tag parsing.
- Aggregates the data into a dictionary and appends it to a list.
- Saves the final structured data into a job_offers.json file.
📁 Output Format
The output JSON file contains a list with one dictionary structured as:
[
  {
    "title": [...],
    "company": [...],
    "location": [...],
    "salary": [...]
  }
]


⚠️ Notes
- This script assumes the structure of the TotalJobs HTML remains consistent. If the site layout changes, selectors may need to be updated.
- It currently scrapes only the first page of results. Pagination support can be added for broader coverage.

Would you like me to help you add pagination or convert the output into a DataFrame for CSV export?

<img width="584" height="189" alt="image" src="https://github.com/user-attachments/assets/d25d522c-573a-4f50-8f66-c09116f6eb8d" />

- This script assumes the structure of the TotalJobs HTML remains consistent. If the site layout changes, selectors may need to be updated.
- It currently scrapes only the first page of results. Pagination support can be added for broader coverage.

Link: [https://github.com/matt9891-stack/matt9891-stack.github.io/blob/main/_posts/Web_scraping.py](https://github.com/matt9891-stack/Web_Scraping.git)
