---
layout: post
title: "Executive_Summary"
subtitle: "Executive_Summary of the Collaborative project"
categories: [Module 3, Deciphering Big Data]
tags: [Python]
---
# Individual Project: Executive Summary EPL Fan Fever DBMS 

In order to address the client’s business problem, we have proposed a fully integrated cloud
based architecture to support EPL Fan Fever Ltd. in securely collecting, transforming, and 
managing its data, while making it easily accessible for operational and strategic use. 

# Background 

EPL Fan Fever Ltd. sells Premier League merchandise online and in stores, generating 
valuable sales, inventory, customer, and supplier data. A secure, integrated system is 
needed to manage high volumes, ensure quality, and support decision-making (Haessner 
and Thomas, 2025). 

# Architecture Infrastructure  

To support EPL Fan Fever Ltd. the entire system is hosted on the scalable Amazon Web 
Services (AWS) cloud which allows the business to manage traffic surges without investing 
in permanent, costly hardware. The platform operates on a stable and secure foundation, 
using Ubuntu Linux for its proven reliability and cost-effectiveness, which minimizes 
technical disruptions and keeps the online store running smoothly for customers. 
The website's technical core is designed for resilience and performance. The Apache web 
server manages customer traffic with proven stability, making it a good choice for managing 
high volumes of online shoppers (IBM, 2025). The site itself is built using Flask, a flexible 
Python framework, which controls what customers see and how the site responds to their 
actions. These two components work together seamlessly through a bridge called WSGI, 
ensuring fast and efficient communication (Kumar et al., 2023) and providing a robust, 
maintainable, and high-performing foundation for the e-commerce platform. 
To ensure a fast and safe shopping experience, the platform is protected by Cloudflare 
which stops overwhelming traffic attacks that could take the website offline and speeds up 
page loads for customers around the world by using a network of efficient global servers 
(CDN )(Cloudflare, 2024).  

<img width="589" height="312" alt="image" src="https://github.com/user-attachments/assets/53cb6292-7ad7-4153-9069-d30657022d93" />
Figure 1: Map of a CDN’s distributed servers (Cloudflare, 2024). 

It also provides a Web Application Firewall (WAF) that uses machine learning to 
automatically update security rules, which define what web traffic is allowed or blocked 
based on known attack patterns (Daram and Senthilkumar, 2025). Additionally, UFW the 
Ubuntu’s default firewall, and ModSecurity, defend the system against common attacks such 
as SQL injection and cross-site scripting (Dau, Trang and Hung, 2022). 

<img width="617" height="286" alt="image" src="https://github.com/user-attachments/assets/54c1c8b4-7351-41fc-ba7a-d6f328bbc901" />
Figure 2- E-commerce cloud Infrastructure schema (adapted from Russo, Lopez & Muammeni, 2025) 

Beyond the online store, the physical retail operations are integrated through a 
centralized Enterprise Resource Planning (ERP) system. This platform unifies key business 
functions such as sales, inventory, human resources, and supplier management into a single 
source of truth, improving information flow and enabling more accurate, timely decision
making across the organization (Zaman, 2024).

<img width="590" height="499" alt="image" src="https://github.com/user-attachments/assets/bd9a2f86-e158-4871-8b5b-4d34e94c2b6b" />
Figure 3: ERP in operations management (adapted from Zaman, 2024). 

At the heart of the entire system lies the PostgreSQL database, which serves as the secure, 
unified data hub for both the e-commerce platform and the ERP.

<img width="614" height="311" alt="image" src="https://github.com/user-attachments/assets/f0b6e62c-1ad7-42a4-bf0d-93dae9b21fe8" />
Figure 4- Physical Infrastructure schema (adapted from Russo, Lopez & Muammeni, 2025) 

# Extract, Transform, Load process. 

To create a reliable and consistent source of data, the system uses a streamlined process 
called Extract, Transform, Load (ETL) which gathers data from different parts of the 
business, such as online and in-store sales, and prepares it for consistent analysis. A 
Python-based API acts as a secure gateway, receiving this data, formatting it for uniformity, 
and delivering it for central storage in a scalable way (Ray, 2025). Once collected, the data 
first enters a controlled, temporary staging area where, essential details like store location, 
date, and record count are logged, ensuring every piece of information can be traced back to 
its origin if needed. Next, the data is cleaned using a structured, step-by-step process that 
follows the detailed matrix below to ensure quality and consistency: 


<img width="605" height="123" alt="image" src="https://github.com/user-attachments/assets/8d3ecf81-4045-4a92-b0db-d7460273213f" />
<img width="604" height="581" alt="image" src="https://github.com/user-attachments/assets/87335d99-565a-497e-8fa4-9b8b7858212b" />
Figure 5- Transformation Steps Matrix 
 
The sequence and timing of the data-cleaning steps are coordinated by Apache Airflow 
which ensure each stage of the data pipeline runs in the correct order and at scheduled 
intervals. Its flexibility allows it to connect to any data source and scale efficiently, 
guaranteeing a reliable and adaptable ETL process that grows with the business (Apache 
Airflow, 2025). 
Once the data is fully cleaned and validated, it is securely loaded into the 
central PostgreSQL database on AWS.

<img width="636" height="217" alt="image" src="https://github.com/user-attachments/assets/3ecd8d20-4477-4e6c-afe1-47b825f174d3" />
Figure 6- ETL Workflow 

# Strategic Considerations: Security Over Pure Speed 

As data grows, a faster method called ELT (Extract, Load, Transform) could be considered. 
This approach loads data quickly and processes it inside the cloud database, which can be 
more flexible for large volumes (Poddar, 2024). However, security was prioritized over speed 
in our final design as  ELT can move unprotected raw data directly into the system, which 
increases the risk of interception or internal misuse. It can also slow down the database 
during large data transfers and leave information temporarily exposed during processing 
(Carnell, 2023). 

# Database Modelling 

The database for EPL Fan Fever Ltd. is designed to store business information in a clear 
and organized way, making it easy to find and use. It is built using three basic ideas: entities 
(like customers or products), attributes about those things (like a customer's name), and the 
relationship between them (like which customer made a purchase). This makes the 
database a true reflection of how the business works (McFadyen, n.d). 
To keep the data clean and efficient, the design avoids unnecessary repetition, a principle 
known as normalization. This means a customer's information is stored in one dedicated 
place, not copied into every sales record, which helps prevent mistakes and confusion (Watt, 
2020). The system also enforces rules to maintain data integrity, ensuring that all 
connections are valid, for example, a sale can only be recorded for a real customer who 
exists in the system. 

# Strategic Considerations: The Database Schema

<img width="643" height="376" alt="image" src="https://github.com/user-attachments/assets/77e5bd9a-59a2-4399-b537-62c75610e8ae" />
Figure 7 – Database Schema (adapted from Russo, Lopez & Muammeni, 2025) 

To support our business reporting and analysis, a hybrid database design has been chosen. 
It combines the clarity of a standard reporting model with the organizational benefits of a 
normalized structure. 
The main goal of this design is to create a reliable and cost-effective data foundation. It 
provides three key advantages: it reduces storage costs by minimizing data repetition, 
it ensures data accuracy for trustworthy reports, and it simplifies maintenance by keeping 
key information in one place. 
The trade-off for these benefits is that some reports may take a bit longer to generate and 
might require more technical skill to set up. 
Overall, this is a strategic decision that prioritizes data quality, efficiency, and long-term 
manageability over achieving the very fastest query speeds, giving us a solid and 
dependable data system (Sheldon, 2024). 


<img width="588" height="275" alt="image" src="https://github.com/user-attachments/assets/4c508816-bc20-4b25-97d2-554d522bf7e1" />
Figure 8 – Database Schema SWOT Analysis

# Security and Compliance 

EPL Fan Fever Ltd has designed its customer data systems with a strong focus on privacy, 
security, and compliance with the General Data Protection Regulation (GDPR). Personal 
data is handled responsibly to support customer trust and meet legal requirements. 
Access to sensitive information is tightly controlled. A role-based access system ensures 
staff can only see or manage data relevant to their role, reducing the risk of misuse or 
accidental exposure (Ramachandran, 2023). Different access levels are clearly defined, with 
higher privileges limited to authorised administrators, supporting accountability and 
compliance. 
The system is also protected against external threats. Firewalls are used to control network 
traffic and block unauthorised access, while secure logins and multi-factor authentication 
add an extra layer of protection (Tejaswini Kasture, 2023). Regular data backups and 
recovery processes help ensure the business can continue operating in the event of system 
issues. 
Overall, this GDPR-compliant approach helps protect customer data, reduce legal and 
financial risk, and maintain trust, providing a secure foundation for the ongoing growth of 
EPL Fan Fever Ltd. 

# Strategic Considerations: Compliance 

To keep customer data safe and remain GDPR compliant, EPL Fan Fever Ltd should 
maintain strong data governance across the organisation. This means having clear rules 
about how personal data is used, who is responsible for it, and how compliance is 
monitored. 
Regular training should be provided so employees understand how to handle sensitive data 
correctly and recognise potential risks. As human error is a common cause of data 
breaches, ongoing awareness and guidance are essential. 
The company should also carry out regular risk assessments to identify potential 
weaknesses in how data is protected. In addition, penetration testing should be used to 
safely test the system for security gaps before they can be exploited. These activities help 
the organisation stay ahead of emerging threats. 
All systems and software should be kept up to date with the latest security updates. 
Encouraging good data-handling practices and following best practices ensures customer 
information is protected at all times. 
By combining clear governance, ongoing staff training, regular system updates, and routine 
security testing, the organisation can reduce risk, protect customer trust, and support long
term business success. 

# Strategic recommendation 

To ensure the database system continues to support business growth, data accuracy, and 
regulatory compliance, we recommend the following steps listed in the recommendation 
matrix:


<img width="586" height="442" alt="image" src="https://github.com/user-attachments/assets/04bf2d60-2e39-42c9-95f1-55489319e0bc" />
Figure 9 – Recommendation Matrix 

# Conclusion 

The DBMS implemented for EPL Fan Fever delivers significant benefits, enabling the 
company to efficiently collect, manage, and prepare data for analysis while maintaining a 
strong focus on data quality and regulatory compliance. Given that customer data is highly 
structured, a SQL-based solution was selected to ensure integrity, consistency, and 
reliability across all business processes. While a NoSQL approach, such as a data lake 
supported by an ELT pipeline, could offer greater scalability and the ability to store diverse 
data types like emails, images, and other unstructured information, it would also introduce 
risks to data quality, integrity, and compliance. By prioritizing a structured SQL solution, EPL 
Fan Fever maintains a dependable and accurate data foundation that supports both 
operational needs and strategic decision-making, while remaining fully aligned with 
regulatory standards. 

# References 

Apache Airflow (2025) ETL/ELT. Available at: https://airflow.apache.org/use
cases/etl_analytics/ [Accessed 4 January 2026]. 

Carnell, P. (2023) ELT Security Considerations. Available at: https://www.lonti.com/blog/elt
security-considerations [Accessed 8 January 2026]. 

Cloudflare (2024) What is a content delivery network (CDN)? | How do CDNs work? 
Available at: https://www.cloudflare.com/en-gb/learning/cdn/what-is-a-cdn [Accessed 28 
December 2025]. 

Daram, K. and Senthilkumar, P. (2025) 'Optimizing Cloudflare security and performance with 
AI-based Web Application Firewall and anomaly detection', International Journal on Smart 
Sensing and Intelligent Systems, 18(1). doi: 10.2478/ijssis-2025-0040. 

Dau, H. X., Trang, N. T. T. and Hung, N. T. (2022) 'A Survey of Tools and Techniques for 
Web Attack Detection', Journal of Science and Technology on Information Security, 1(15), 
pp. 109–118. doi: 10.54654/isj.v1i15.852. 

Haessner, P. and Thomas, J. (2025) 'Maximizing Retail Potential: The Role of Big Data 
Analytics', Journal of Strategic Innovation and Sustainability, 19(4). doi: 
10.33423/jsis.v19i4.7486. 

IBM (2025) What is an Apache server? Available at: 
https://www.ibm.com/think/topics/apache-server [Accessed 7 January 2026]. 

Kasture, T. (2023) Data Privacy: 5 Proven Strategies for Compliance and Protection. 
Available at: https://hevodata.com/learn/data-privacy/ [Accessed 10 January 2026]. 

Kumar, S., Ojha, J., Tripathi, M. M. and Garg, K. (2023) 'Integrated e-healthcare 
management system using machine learning and Flask', International Journal of Electronic 
Healthcare. doi: 10.1504/IJEH.2023.128607 [Accessed 4 January 2026].

McFadyen, R. (n.d.) Entity Relationship Modeling. Available at: 
https://harpercollege.pressbooks.pub/relationaldatabases/chapter/entity-relationship
modeling/ [Accessed 6 January 2026]. 

Poddar, S. (2024) ETL vs ELT: Understanding Key Differences for Effective Data Integration. 
Available at: https://hevodata.com/learn/etl-vs-elt-key-differences/ [Accessed 8 January 
2026]. 

Ramachandran, A. (2023) Role Based Access Control for Data Teams - An A to Z Guide. 
Available at: https://hevodata.com/learn/role-based-access-control/ [Accessed 10 January 
2026]. 

Ray, S. N. (2025) Optimizing API-Based ETL Workflows for Scalable Data Pipelines. 
Available at: https://www.researchgate.net/publication/391216691 [Accessed 4 January 
2026]. 

Russo, M., Lopez, D. E. and Muammeni, S. S. (2025) Individual Collaborative Project: 
Database Design and Architecture. Unpublished master’s project, University of Essex. 
Sheldon, R. (2024) What is a star schema and how does it work? Available at: 
https://www.techtarget.com/searchdatamanagement/definition/star-schema [Accessed 9 
January 2026]. 

Watt, A. (2020) Chapter 12: Normalization. Available at: 
https://opentextbc.ca/dbdesign01/chapter/chapter-12-normalization/ [Accessed 6 January 
2026]. 

Zaman, S. (2024) 'A Systematic Review of ERP And CRM Integration For Sustainable 
Business And Data Management in Logistics And Supply Chain Industry', AIM International 
Journal, 1(01), pp. 204–221. doi: 10.70937/faet.v1i01.36.
