---
layout: post
title: "API Security Requirements"
date: 2026-01-11
categories: [Module 3 Deciphering Big Data]

---

The project helped strengthen my understanding of APIs, their functions, and the different types available.
It also allowed me to explore which API is best suited for specific contexts, as well as the challenges involved in using them effectively.

This experience provided a valuable  understanding of integrating and managing APIs in real-world applications.

Below is the Project Developed

# API Security Requirements Specification

An Application Programming Interface (API) allows different applications to communicate with  each other in a safe and controlled way. In cloud-based architectures, APIs have become essential for enabling data sharing, integration, and automation across platforms and programming languages, including Python-based applications (Iqbal, 2023).

# How the API works

In simple terms, an API acts as a bridge between an application’s request and the server’s response. A practical example is an e-commerce website that relies on a third-party service, such as PayPal, to process payments. The API, in the moment the buyer clicks the payment button, takes the request from the webpage and translates it into a format that the server can understand and once the server receives this information, the API helps the connection to the third-party payment system. After the payment system processes the transaction, the API captures the response and delivers it back to the original website. Without the API, the website and the payment system would have no way to communicate or share the necessary data to complete the transaction  (Goodwin, 2024).

<img width="598" height="377" alt="image" src="https://github.com/user-attachments/assets/87c1eeaa-9399-41bc-940b-026bc78779b8" />

Figure 1: Architecture of the API conversion process (Moore, 2021).

# What type of API
There are different types of API. Public APIs, which are open for use outside the business and are often employed by companies that want to share data with other organisations. These typically use moderate authentication and authorisation measures. Partner APIs are used by businesses to connect with selected external parties and, therefore, usually implement stronger authentication and security measures. 
Internal APIs are designed for use within a company, for example, to connect different departments. Their security measures may vary depending on the organisation’s governance policies.
Composite APIs are a combination of two or more types of API, allowing more flexibility and integration (Bigelow, 2023).

# API Protocols and Architecture
APIs are generally supported by different protocols, which define how the API communicates over a network. Among these protocols, SOAP (Simple Object Access Protocol) provides a standardised way for different computer programs to communicate, even if they use different operating systems or internal designs. SOAP is highly flexible because it can work with many common internet protocols, such as those used for websites, file sharing, and email. However, it is limited in how it delivers information, as it can only send data back in a specific format known as XML.
The RPC (Remote Procedure Call) protocol is one of the most basic methods for programs to communicate. In this approach, a client requests that a remote server execute a specific task or command. RPC is mainly designed to trigger actions or functions on a remote system.
Finally, the REST (Representational State Transfer) protocol allows a user to request specific data from a server, which then returns the information exactly as it exists at that moment. REST typically relies on standard web protocols to organise communication. A major advantage of REST is its flexibility, as it can deliver data in multiple formats, including JSON, HTML, or XML, depending on the user’s needs (Cloudflare.com, 2025).

# Comparison
Choosing the right API format is important, as it can affect the security and performance over time.
Simpler APIs are generally faster and easier to maintain, but may lack robust security features, while more complex APIs often provide stronger security and more structured communication at a greater effort from developers and users.
REST and SOAP are the most commonly used API formats. Both rely on HTTP methods, such as GET, POST, and DELETE, to exchange data between applications. SOAP is highly structured and always uses XML, making it suitable for companies' systems that require strict rules, reliable process execution, and advanced security. REST is more flexible, supporting both JSON and XML, and is faster, more scalable, and easier to adopt, particularly for public-facing applications such as mobile or web apps.
RPC-based APIs focus on calling procedures rather than accessing data resources, and they are simpler but more limited and often useful for internal systems where performance and simplicity are prioritised over flexibility or advanced security (Bigelow, 2023).

<img width="604" height="329" alt="image" src="https://github.com/user-attachments/assets/f679d06b-bfc7-4964-8772-2938d229fa19" />

Figure 2:  API protocol comparison.

# Security challenges 

Just like any system connected to the internet, APIs face constant risks from people trying to exploit them. One major problem involves attacks on the security checks used to verify a user's identity. Even though these checks are designed to ensure only the right people get in, hackers can sometimes steal digital keys and intercept secret access tokens to gain access without permission.
Another significant threat comes from internal weaknesses within the API's own code, which often include issues like poorly managed user permissions or accidentally sharing too much private data.
By finding and using these weak spots, attackers can trigger massive data leaks or use the API as a starting point for even more serious cyberattacks.
Finally, APIs are often targeted by massive floods of artificial traffic designed to overwhelm the system. By clogging the connection, attackers can slow the service down or crash it entirely, making it impossible for genuine customers to use the application (Cloudflare.com, 2025).

# Security requirements

According to Iqbal (2023), a widely used method to secure API communications is Transport Layer Security (TLS), which encrypts data and can use digital signatures to ensure its integrity. TLS protects the information transmitted between a client and server while maintaining the privacy of the connection. For authentication and access control, frameworks such as OAuth, often used alongside OpenID, allow third-party applications to access a user’s resources without requiring the user to share their login credentials (Kumar, 2020).
Using these principles, additional security requirements can be implemented to reduce potential risks and ensure safe interaction with applications and data in different formats. 
Authentication and authorisation should use OAuth 2.0 or API keys, combined with Role-Based Access Control (RBAC), to ensure that only authorised users can perform actions appropriate to their roles. 
Data encryption should be applied to all information transmitted via the API using TLS 1.2 or higher, while sensitive data stored in SQL databases or XML/JSON files should also be encrypted. 
Input validation must be carried out against predefined schemas, and SQL queries should use parameterised statements to prevent injection attacks.
Additional measures, including rate limiting and throttling, logging and monitoring, error handling, and backup and recovery, complement the core TLS and OAuth mechanisms. 

<img width="608" height="283" alt="image" src="https://github.com/user-attachments/assets/69906116-fd36-4190-9da2-f7e3bd3c34a8" />

Figure 3:  Security Requirements.

Together, these create a layered security approach that reduces the risk of unauthorised access, data loss, or abuse, ensuring that API interactions remain reliable and secure.

# References

Bigelow, S., 2023. What are the types of APIs and their differences? [online] SearchAppArchitecture. Available at: https://www.techtarget.com/searchapparchitecture/tip/What-are-the-types-of-APIs-and-their-differences (Accessed 11 January 2026).

Cloudflare.com, 2025. How do APIs work? [online] Available at: https://www.cloudflare.com/en-gb/learning/security/api/how-do-apis-work/ (Accessed 11 January 2026).

Goodwin, M., 2024. What is an API (application programming interface)? [online] Ibm.com. Available at: https://www.ibm.com/think/topics/api (Accessed 11 January 2026).

Iqbal, F.N., 2023. A Brief Introduction to Application Programming Interface (API). ATHE Level 4, Diploma in Computing. AIMS Academy, Sylhet, Bangladesh. Available at: https://doi.org/10.5281/zenodo.10198423 (Accessed 11 January 2026).

Kumar, R., 2020. Enhancing API Security: A Comparative Analysis of OAuth 2.0, OpenID Connect, and SAML. International Journal of Innovative Research in Engineering & Multidisciplinary Physical Sciences, [online] 8(3), pp.1–15. doi:https://doi.org/10.5281/zenodo.15029738.

Moore, A., 2021. Figure X: [brief description of the image]. In: auto{API} – A Web Based Tool for Specification of an API Endpoint to Return JSON Data From an XML Source. Journal of Open Research Software, 9(1), p.24. DOI: 10.5334/jors.335. Available at: https://openresearchsoftware.metajnl.com/articles/10.5334/jors.335/ (Accessed 11 January 2026).



