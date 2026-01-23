---
layout: post
title: "Web Scraping Script"
subtitle: "An end-to-end Python web scraping workflow extracting job titles, companies, locations, and salaries from online job portals."
categories: [Module 3, Deciphering Big Data]
tags: [Python]
---

# Web_Scraping

[GitHub Repository](https://github.com/matt9891-stack/Web_Scraping.git)

[Script](https://github.com/matt9891-stack/Web_Scraping/blob/main/Web_scraping.py#L1C1-L54C56)

Job Scraper for Data Scientist Roles in the UK

This Python script automates the extraction of job listings for Data Scientist positions from TotalJobs UK. It collects key information such as job titles, company names, locations, and salary details, and saves the results in a structured JSON file for further analysis or integration.

## Requirements

Make sure you have the following Python libraries installed:

<img width="504" height="92" alt="image" src="https://github.com/user-attachments/assets/bc65800b-38e8-4102-9fa6-05ed687fba27" />

## The project

This project includes a web scraping component that automatically collects job listings from a user-specified TotalJobs URL. The scraper navigates the page structure to identify and extract key information from each posting, including job titles obtained directly from the relevant h2 HTML elements. 
This approach ensures accurate retrieval of role names as they appear on the platform and provides a reliable foundation for further analysis or data processing.

    import pandas as pd
    import numpy as np
    import requests
    from bs4 import BeautifulSoup
    import json

The URL from which we will obtain information about the job offer, the company, the location, and the salary.

    url = 'https://www.totaljobs.com/jobs/data%20scientist/in-uk?&ef_id=CjwKCAiAlMHIBhAcEiwAZhZBUoKYZSNxnpKnzr1UuaYspRFSL5B4vD1piTjnCsjKqo-tAGIAfDjiZxoCaOcQAvD_BwE:G:s&cid=SEA_GO_UK-TJ-DIS22-LOC--B%7CUK%7C%5BA%5D_c_data%20scientist-uk-%7CJBT06873-LOC5549-_data%20scientist%20jobs%20uk_RL_rsa&s_kwcid=AL!7101!3!732539327689!b!!g!!data%20scientist%20jobs%20uk!22183338890!174671712933&adjust_t=1qv41avw_1qxxj48s&adjust_campaign=SEA_GO_UK-TJ-DIS22-LOC--B%7CUK%7C%5BA%5D_c_data%20scientist-uk-%7CJBT06873-LOC5549-_data%20scientist%20jobs%20uk_RL_rsa&gad_source=1&gad_campaignid=22183338890&gbraid=0AAAAAD3JKXOUmGBQcDZAW-Y8ehThxNIIE&gclid=CjwKCAiAlMHIBhAcEiwAZhZBUoKYZSNxnpKnzr1UuaYspRFSL5B4vD1piTjnCsjKqo-tAGIAfDjiZxoCaOcQAvD_BwE'

The following line sends an HTTP GET request to the specified web page. A successful response (status code 200) confirms that the page is accessible, allowing us to continue with the scraping process.

    page = requests.get(url)

    page.status_code

Parse the page content with BeautifulSoup using the built-in HTML parser.  This creates a structured object (soup) that allows easy navigation and data extraction.
   
    soup = BeautifulSoup(page.text, "html.parser")

Create an empty list to store all the job offer information scraped from the web page.
 
    Job_offers=[]

Iterate through all h2 elements in the HTML and extract only their text content.
 
    title = [h2.get_text(strip=True) for h2 in soup.find_all('h2')]
    title

## How It Works

The script begins by sending an HTTP GET request to the TotalJobs search results page targeting Data Scientist positions in the United Kingdom. Once the response is received, the HTML content is parsed using BeautifulSoup to enable structured navigation 
of the page. Relevant job information is then identified and extracted through a combination of CSS selectors and HTML tag parsing.The collected data is progressively aggregated into a dictionary structure, with each job posting appended to a list. 
Finally, the complete and structured dataset is exported and saved as a job_offers json file, making it ready for downstream analysis or integration into other applications.
Retrieve all HTML elements associated with company names by targeting the 'data-at="job-item-company-name"' attribute. For each element found, extract only the textual content and remove leading or trailing spaces.

    company = soup.select('[data-at="job-item-company-name"] .res-ewgtgq')
    companies = [comp.get_text(strip=True) for comp in company]
    companies

The same code will be repeated for the locations
    
    loc = soup.select('[data-at="job-item-location"] .res-du9bhi')
    locations = [l.get_text(strip=True) for l in loc]
    locations

The same code will be repeated for the salaries

    pay = soup.select('[data-at="job-item-salary-info"]')
    salary = [p.get_text(strip=True) for p in pay]
    salary

We append the text extracted into an empty list

    Job_offers.append({'title':title,
                    'company':companies,
                    'location':locations,
                    'salary':salary})

We save the list as a JSON format file

    with open('job_offers.json','w',encoding='utf-8') as f:
    json.dump(Job_offers,f,ensure_ascii=False,indent=4)

## Output Format

The output JSON file contains a list with one dictionary structured as:
  
    [
      {
        "title": [...],
        "company": [...],
        "location": [...],
        "salary": [...]
      }
    ]


## Notes

- This script assumes the structure of the TotalJobs HTML remains consistent. If the site layout changes, selectors may need to be updated.
- It currently scrapes only the first page of results. Pagination support can be added for broader coverage.

Would you like me to help you add pagination or convert the output into a DataFrame for CSV export?

<img width="584" height="189" alt="image" src="https://github.com/user-attachments/assets/d25d522c-573a-4f50-8f66-c09116f6eb8d" />

- This script assumes the structure of the TotalJobs HTML remains consistent. If the site layout changes, selectors may need to be updated.
- It currently scrapes only the first page of results. Pagination support can be added for broader coverage.
