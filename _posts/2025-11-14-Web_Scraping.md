---
layout: post
title: "Web Scraping Script"
subtitle: "An end-to-end Python web scraping workflow extracting job titles, companies, locations, and salaries from online job portals."
categories: [Python]
tags: [Python]
---

import pandas as pd
import numpy as np
import requests
from bs4 import BeautifulSoup
import json


# The Url from where we will be getting the information about Job offer, Company, location and slary
url = 'https://www.totaljobs.com/jobs/data%20scientist/in-uk?&ef_id=CjwKCAiAlMHIBhAcEiwAZhZBUoKYZSNxnpKnzr1UuaYspRFSL5B4vD1piTjnCsjKqo-tAGIAfDjiZxoCaOcQAvD_BwE:G:s&cid=SEA_GO_UK-TJ-DIS22-LOC--B%7CUK%7C%5BA%5D_c_data%20scientist-uk-%7CJBT06873-LOC5549-_data%20scientist%20jobs%20uk_RL_rsa&s_kwcid=AL!7101!3!732539327689!b!!g!!data%20scientist%20jobs%20uk!22183338890!174671712933&adjust_t=1qv41avw_1qxxj48s&adjust_campaign=SEA_GO_UK-TJ-DIS22-LOC--B%7CUK%7C%5BA%5D_c_data%20scientist-uk-%7CJBT06873-LOC5549-_data%20scientist%20jobs%20uk_RL_rsa&gad_source=1&gad_campaignid=22183338890&gbraid=0AAAAAD3JKXOUmGBQcDZAW-Y8ehThxNIIE&gclid=CjwKCAiAlMHIBhAcEiwAZhZBUoKYZSNxnpKnzr1UuaYspRFSL5B4vD1piTjnCsjKqo-tAGIAfDjiZxoCaOcQAvD_BwE'

# The following line sends an HTTP GET request to the specified web page.
# A successful response (status code 200) confirms that the page is accessible,
# allowing us to continue with the scraping process.
page = requests.get(url)

page.status_code

# Parse the page content with BeautifulSoup using the built-in HTML parser.
# This creates a structured object (soup) that allows easy navigation and data extraction.
soup = BeautifulSoup(page.text, "html.parser")

# Create an empty list to store all the job offer information scraped from the web page.
Job_offers=[]

# Iterate through all <h2> elements in the HTML and extract only their text content.
title = [h2.get_text(strip=True) for h2 in soup.find_all('h2')]
title

# Retrieve all HTML elements associated with company names by targeting
# the 'data-at="job-item-company-name"' attribute. For each element found,
# extract only the textual content and remove leading or trailing spaces.
company = soup.select('[data-at="job-item-company-name"] .res-ewgtgq')
companies = [comp.get_text(strip=True) for comp in company]
companies

#the same code will be repeated for the locations
loc = soup.select('[data-at="job-item-location"] .res-du9bhi')
locations = [l.get_text(strip=True) for l in loc]
locations

#the same code will be repeated for the salaries
pay = soup.select('[data-at="job-item-salary-info"]')
salary = [p.get_text(strip=True) for p in pay]
salary

#We append the text extracted into an empty list
Job_offers.append({'title':title,
                    'company':companies,
                    'location':locations,
                    'salary':salary})

#We save the list as a json format file
with open('job_offers.json','w',encoding='utf-8') as f:
    json.dump(Job_offers,f,ensure_ascii=False,indent=4)
