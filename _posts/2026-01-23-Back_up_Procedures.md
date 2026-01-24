---
layout: post
title: "Back up procedures"
subtitle: "Comparative Work on Back-up Procedures."
categories: [Module 3 Deciphering Big Data]
tags: [Python]
---
# Back Up Procedure
A database backup is used to create a copy of the original database in case data is lost. A database recovery strategy helps organisations restore data with accuracy and integrity when recovery is required (Ibm.com, 2025). 

There are several types of backup operations. A full backup copies the entire database, including all data and structure, offering a complete recovery solution but requiring large storage space and longer backup times. Incremental backups store only the changes made since the last backup, making them faster and more storage efficient; however, recovery can take longer because multiple backups may be needed. Differential backups copy changes made since the last full backup, allowing faster recovery than incremental backups. Snapshot backups create a point-in-time copy of the database and are useful for quick backups, testing, and development. Continuous Data Protection (CDP) records data changes in near real time, ensuring minimal data loss. Replication maintains multiple copies of the database to support disaster recovery and improve read performance (Nayak, 2023).

<img width="585" height="565" alt="image" src="https://github.com/user-attachments/assets/e557142c-6385-4970-bcce-0dd41208abb8" />

# The Grandfather–Father–Son (GFS)

The Grandfather–Father–Son (GFS) backup is a rotational procedure based on a hierarchical system, where different types of backups are performed on a daily, weekly, and monthly basis to ensure data can be restored from multiple points in time (Happonen, 2025). The GFS strategy provides strong data protection by maintaining multiple generations of backups. Daily “son” backups allow organisations to quickly recover recent data, reducing downtime and supporting business continuity. Weekly “father” and monthly “grandfather” backups preserve historical data, which is useful for audits, regulatory compliance, and restoring older versions of information. This structured approach helps organisations meet data retention requirements while minimising the risk of permanent data loss. By distributing backups across different time periods, GFS also improves resilience against hardware failures, ransomware, and accidental deletion, making it a reliable and widely used backup strategy (Nheu, 2024).

<img width="559" height="213" alt="image" src="https://github.com/user-attachments/assets/54e40c3c-f429-4b64-9a18-a4a7a2e1aedf" />

Compared to full backups, GFS is more resource efficient for large databases because it avoids creating full backups every day, reducing storage and system load. Unlike incremental or differential backups, which are faster and use less space, GFS offers multiple recovery points and preserves historical data systematically. However, it is slower to restore than continuous data protection (CDP), which captures changes in real time, and may consume considerable storage due to multiple backup generations (Łukasz Błocki, 2024). Overall, GFS is effective for organisations prioritising historical data retention, compliance, and risk mitigation, but it may be less suitable where immediate, real-time recovery is essential.

# References

Happonen, A. (2025) Data Backup in Multicloud Environment. Metropolia University of Applied Sciences, Master of Engineering in Information Technology. Available at: https://www.theseus.fi/bitstream/10024/892504/2/Happonen_Arto.pdf (Accessed: 23 January 2026).

IBM.com. (2025) Db2 for Linux, UNIX and Windows. [online] Available at: https://www.ibm.com/docs/en/db2/11.5.x?topic=recovery-developing-backup-strategy (Accessed: 23 January 2026).

Łukasz Błocki (2024) Grandfather-Father-Son (GFS) Backup | Storware BLOG. [online] Storware. Available at: https://storware.eu/blog/grandfather-father-son-gfs-backup/?utm_source=chatgpt.com (Accessed: 23 January 2026).

Nayak, S. (2023) Database backup and recovery techniques - Shruti Nayak. [online] Medium. Available at: https://medium.com/@shruti.nayak20/database-backup-and-recovery-techniques-c541faf3444a (Accessed: 23 January 2026).

Nheu, W. (2024) The Grandfather-Father-Son Backup Scheme Explained. [online] Cyber Resilience Blog. Available at: https://www.backupassist.com/blog/the-grandfather-father-son-backup-scheme-explained (Accessed: 23 January 2026).
